function apply_pmsm_controller_matlab_fix()
%APPLY_PMSM_CONTROLLER_MATLAB_FIX Persist QEP module selection in the model.
% This patch updates the Controller harness eQEP block to use eQEP2
% at model level, so code generation stays consistent.

scriptDir = fileparts(mfilename('fullpath'));
cd(scriptDir);

try
    setappdata(0, 'pmsm_diag_knobs', capture_diagnostic_knobs());
    pmsm_control_init;
    if isappdata(0, 'pmsm_diag_knobs')
        restore_diagnostic_knobs(getappdata(0, 'pmsm_diag_knobs'));
        rmappdata(0, 'pmsm_diag_knobs');
    end
    load_system('pmsm_control');

    Simulink.harness.open('pmsm_control/Controller', 'Controller_DSP');
    hModel = bdroot(gcs);
    assert(strcmp(hModel, 'Controller_DSP'), 'Controller harness did not open.');

    eqepBlk = 'Controller_DSP/ReadAnalogInputs/eQEP1';
    assert(getSimulinkBlockHandle(eqepBlk) ~= -1, 'Missing block: %s', eqepBlk);

    thetaSign = read_workspace_value('theta_sign', int8(1));
    phaseSwapBC = logical(read_workspace_value('phase_swap_bc', false));
    openLoopMode = logical(read_workspace_value('open_loop_mode', false));
    openLoopIqRef = single(read_workspace_value('open_loop_iq_ref', single(5)));

    set_eqep_module_to_2(eqepBlk);
    set_eqep_position_limits(eqepBlk);
    set_digital_input2_bank('Controller_DSP/Task_1ms_pre/Digital Input2');
    set_sensor_and_udc_wiring('Controller_DSP/ReadAnalogInputs', phaseSwapBC);
    set_theta_gain_sign('Controller_DSP/ReadAnalogInputs/GainTheta', thetaSign);
    set_wrap_aware_theta_delta('Controller_DSP/ReadAnalogInputs');
    set_rpm_average_filter('Controller_DSP/ReadAnalogInputs');
    set_open_loop_runtime_defaults(openLoopMode, openLoopIqRef);

    save_system(hModel);
    save_system('pmsm_control');

    if bdIsLoaded(hModel)
        close_system(hModel, 0);
    end
    if bdIsLoaded('pmsm_control')
        close_system('pmsm_control', 0);
    end

    disp('PMSM_CONTROLLER_MATLAB_FIX_OK');
catch ME
    cleanup_models({'Controller_DSP', 'pmsm_control'});
    rethrow(ME);
end
end

function set_eqep_module_to_2(blockPath)
dp = get_param(blockPath, 'DialogParameters');
fn = fieldnames(dp);
moduleIdx = find(contains(lower(fn), 'module'));
assert(~isempty(moduleIdx), 'No module-like parameter found on %s.', blockPath);

done = false;
for i = 1:numel(moduleIdx)
    p = fn{moduleIdx(i)};
    for v = {'eQEP2', 'EQEP2', '2'}
        try
            set_param(blockPath, p, v{1});
            readback = get_param(blockPath, p);
            if contains(lower(readback), '2')
                done = true;
                break;
            end
        catch
            % try next candidate
        end
    end
    if done
        break;
    end
end

assert(done, 'Failed to set eQEP module to eQEP2 on block %s.', blockPath);
end

function set_digital_input2_bank(blockPath)
assert(getSimulinkBlockHandle(blockPath) ~= -1, 'Missing block: %s', blockPath);
set_param(blockPath, 'GPIO_Number', 'GPIO40~GPIO44');
set_param(blockPath, 'GPIO_Bit0', 'on');
set_param(blockPath, 'GPIO_Bit1', 'on');
set_param(blockPath, 'GPIO_Bit2', 'on');
set_param(blockPath, 'GPIO_Bit3', 'on');
set_param(blockPath, 'GPIO_Bit4', 'off');
set_param(blockPath, 'GPIO_Bit5', 'off');
set_param(blockPath, 'GPIO_Bit6', 'off');
set_param(blockPath, 'GPIO_Bit7', 'off');
end

function set_sensor_and_udc_wiring(parentPath, swapPhaseBC)
demuxBlk = [parentPath '/Demux'];
iabcMuxBlk = [parentPath '/IabcMux'];
sensorBusBlk = [parentPath '/SensorBus'];
udcAdcBlk = [parentPath '/UdcADC'];
udcGainBlk = [parentPath '/UdcGain'];

assert(getSimulinkBlockHandle(demuxBlk) ~= -1, 'Missing block: %s', demuxBlk);
assert(getSimulinkBlockHandle(iabcMuxBlk) ~= -1, 'Missing block: %s', iabcMuxBlk);
assert(getSimulinkBlockHandle(sensorBusBlk) ~= -1, 'Missing block: %s', sensorBusBlk);

UdcFS = evalin('caller', 'UdcFS');
udcExpr = sprintf('single(%g/4096)', UdcFS);
demuxPos = get_param(demuxBlk, 'Position');

obsoleteBlocks = {
    'Vout0'
    'zero_current'
    'neg_ia'
    'UdcConst'
    'UdcADC'
    'UdcGain'
    };
for i = 1:numel(obsoleteBlocks)
    safe_delete_block([parentPath '/' obsoleteBlocks{i}]);
end

add_block([parentPath '/ADC2'], udcAdcBlk, ...
    'Position', [demuxPos(1) - 290, demuxPos(2) - 50, demuxPos(1) - 230, demuxPos(2) - 10]);
set_param(udcAdcBlk, 'useSOC1', 'SOC3');
set_param(udcAdcBlk, 'conv1', 'ADCINA6');
set_param(udcAdcBlk, 'ADCModule', '1');
set_param(udcAdcBlk, 'interruptSel', 'ADCINT2');
set_param(udcAdcBlk, 'postInterrupt', 'off');
set_param(udcAdcBlk, 'Ts', '-1');
set_param(udcAdcBlk, 'samplingMode', 'Single sample mode');
set_param(udcAdcBlk, 'ADCResolution', '12-bit (Single-ended input)');

add_block('simulink/Math Operations/Gain', udcGainBlk, ...
    'Gain', udcExpr, ...
    'OutDataTypeStr', 'single', ...
    'Position', [demuxPos(1) - 200, demuxPos(2) - 50, demuxPos(1) - 140, demuxPos(2) - 20]);

demuxPh = get_param(demuxBlk, 'PortHandles');
iabcMuxPh = get_param(iabcMuxBlk, 'PortHandles');
sensorBusPh = get_param(sensorBusBlk, 'PortHandles');
udcAdcPh = get_param(udcAdcBlk, 'PortHandles');
udcGainPh = get_param(udcGainBlk, 'PortHandles');

assert(numel(sensorBusPh.Inport) >= 10, 'SensorBus does not expose enough inputs.');

safe_add_line(parentPath, demuxPh.Outport(1), sensorBusPh.Inport(1));
safe_add_line(parentPath, demuxPh.Outport(1), iabcMuxPh.Inport(1));
if swapPhaseBC
    safe_add_line(parentPath, demuxPh.Outport(3), sensorBusPh.Inport(2));
    safe_add_line(parentPath, demuxPh.Outport(3), iabcMuxPh.Inport(2));
    safe_add_line(parentPath, demuxPh.Outport(2), sensorBusPh.Inport(3));
    safe_add_line(parentPath, demuxPh.Outport(2), iabcMuxPh.Inport(3));
else
    safe_add_line(parentPath, demuxPh.Outport(2), sensorBusPh.Inport(2));
    safe_add_line(parentPath, demuxPh.Outport(2), iabcMuxPh.Inport(2));
    safe_add_line(parentPath, demuxPh.Outport(3), sensorBusPh.Inport(3));
    safe_add_line(parentPath, demuxPh.Outport(3), iabcMuxPh.Inport(3));
end
safe_add_line(parentPath, udcAdcPh.Outport(1), udcGainPh.Inport(1));
safe_add_line(parentPath, udcGainPh.Outport(1), sensorBusPh.Inport(4));

sensorLines = get_sensor_lines(sensorBusPh);
set_line_name(sensorLines{1}, 'Ia');
set_line_name(sensorLines{2}, 'Ib');
set_line_name(sensorLines{3}, 'Ic');
set_line_name(sensorLines{4}, 'Udc');
end

function set_eqep_position_limits(blockPath)
set_param(blockPath, 'pcMaximumvalue', '4095');
set_param(blockPath, 'pcInitialvalue', '0');
end

function diagKnobs = capture_diagnostic_knobs()
diagKnobs = struct();
for name = {'theta_sign', 'phase_swap_bc', 'open_loop_mode', 'open_loop_iq_ref'}
    if evalin('caller', sprintf('exist(''%s'', ''var'')', name{1}))
        diagKnobs.(name{1}) = evalin('caller', name{1});
    end
end
end

function restore_diagnostic_knobs(diagKnobs)
fields = fieldnames(diagKnobs);
for k = 1:numel(fields)
    assignin('caller', fields{k}, diagKnobs.(fields{k}));
end
end

function set_theta_gain_sign(blockPath, thetaSign)
assert(isnumeric(thetaSign) && isscalar(thetaSign), 'theta_sign must be numeric scalar.');
thetaSign = double(thetaSign);
assert(thetaSign == 1 || thetaSign == -1, 'theta_sign must be +1 or -1.');

% The mechanical angle gain is fixed by the encoder resolution.
% Only the sign is switched for polarity diagnostics.
gainValue = thetaSign * (2*pi/4096);
set_param(blockPath, 'Gain', sprintf('single(%0.15g)', gainValue));
end

function set_wrap_aware_theta_delta(parentPath)
dthetaBlk = [parentPath '/DTheta'];
thetaPrevBlk = [parentPath '/ThetaPrev'];
thetaGainBlk = [parentPath '/GainTheta'];
gainWBlk = [parentPath '/GainW'];

assert(getSimulinkBlockHandle(dthetaBlk) ~= -1, 'Missing block: %s', dthetaBlk);
assert(getSimulinkBlockHandle(thetaPrevBlk) ~= -1, 'Missing block: %s', thetaPrevBlk);
assert(getSimulinkBlockHandle(thetaGainBlk) ~= -1, 'Missing block: %s', thetaGainBlk);
assert(getSimulinkBlockHandle(gainWBlk) ~= -1, 'Missing block: %s', gainWBlk);

pos = get_param(dthetaBlk, 'Position');
dthetaPh = get_param(dthetaBlk, 'PortHandles');
gainWPh = get_param(gainWBlk, 'PortHandles');

obsoleteWrapBlocks = {
    'WrapPi'
    'WrapNegPi'
    'WrapTwoPi'
    'WrapGTpi'
    'WrapLTnegpi'
    'WrapMinus2Pi'
    'WrapPlus2Pi'
    'WrapHighSwitch'
    'WrapLowSwitch'
    'WrapAddPi'
    'WrapMod'
    'WrapSubPi'
    'WrapThetaDeltaFcn'
    };
for i = 1:numel(obsoleteWrapBlocks)
    safe_delete_block([parentPath '/' obsoleteWrapBlocks{i}]);
end

oldDThetaLine = get_param(dthetaPh.Outport(1), 'Line');
if oldDThetaLine ~= -1
    delete_line(oldDThetaLine);
end
safe_clear_port(gainWPh.Inport(1));

wrapFcnBlk = [parentPath '/WrapThetaDeltaFcn'];
add_block('simulink/User-Defined Functions/Fcn', wrapFcnBlk, ...
    'Expr', 'u - 2*pi*floor((u+pi)/(2*pi))', ...
    'Position', [pos(1) + 180, pos(2) - 25, pos(1) + 340, pos(2) + 10]);

wrapFcnPh = get_param(wrapFcnBlk, 'PortHandles');

safe_add_line(parentPath, dthetaPh.Outport(1), wrapFcnPh.Inport(1));
safe_add_line(parentPath, wrapFcnPh.Outport(1), gainWPh.Inport(1));
end

function set_rpm_average_filter(parentPath)
gainRpmBlk = [parentPath '/GainRPM'];
sensorBusBlk = [parentPath '/SensorBus'];

assert(getSimulinkBlockHandle(gainRpmBlk) ~= -1, 'Missing block: %s', gainRpmBlk);
assert(getSimulinkBlockHandle(sensorBusBlk) ~= -1, 'Missing block: %s', sensorBusBlk);

gainRpmPh = get_param(gainRpmBlk, 'PortHandles');
sensorBusPh = get_param(sensorBusBlk, 'PortHandles');
assert(numel(sensorBusPh.Inport) >= 8, 'SensorBus does not expose enough inputs.');
dstPort = sensorBusPh.Inport(8);

if isempty(dstPort) || dstPort == -1
    error('GainRPM has no downstream destination to rewrite.');
end

safe_delete_block([parentPath '/RpmAvgDiff']);
safe_delete_block([parentPath '/RpmAvgGain']);
safe_delete_block([parentPath '/RpmAvgSum']);
safe_delete_block([parentPath '/RpmAvgDelay']);
safe_delete_line(parentPath, gainRpmPh.Outport(1), dstPort);

gainPos = get_param(gainRpmBlk, 'Position');

diffBlk = [parentPath '/RpmAvgDiff'];
gainBlk = [parentPath '/RpmAvgGain'];
sumBlk = [parentPath '/RpmAvgSum'];
delayBlk = [parentPath '/RpmAvgDelay'];

add_block('simulink/Math Operations/Sum', diffBlk, ...
    'Inputs', '+-', ...
    'Position', [gainPos(1) + 90, gainPos(2) - 15, gainPos(1) + 140, gainPos(2) + 15]);
add_block('simulink/Math Operations/Gain', gainBlk, ...
    'Gain', '0.125', ...
    'Position', [gainPos(1) + 180, gainPos(2) - 15, gainPos(1) + 230, gainPos(2) + 15]);
add_block('simulink/Math Operations/Sum', sumBlk, ...
    'Inputs', '++', ...
    'Position', [gainPos(1) + 270, gainPos(2) - 15, gainPos(1) + 320, gainPos(2) + 15]);
add_block('simulink/Discrete/Unit Delay', delayBlk, ...
    'InitialCondition', '0', ...
    'Position', [gainPos(1) + 360, gainPos(2) - 15, gainPos(1) + 410, gainPos(2) + 15]);

diffPh = get_param(diffBlk, 'PortHandles');
gainPh = get_param(gainBlk, 'PortHandles');
sumPh = get_param(sumBlk, 'PortHandles');
delayPh = get_param(delayBlk, 'PortHandles');

safe_add_line(parentPath, gainRpmPh.Outport(1), diffPh.Inport(1));
safe_add_line(parentPath, delayPh.Outport(1), diffPh.Inport(2));
safe_add_line(parentPath, diffPh.Outport(1), gainPh.Inport(1));
safe_add_line(parentPath, gainPh.Outport(1), sumPh.Inport(1));
safe_add_line(parentPath, delayPh.Outport(1), sumPh.Inport(2));
safe_add_line(parentPath, sumPh.Outport(1), delayPh.Inport(1));
rpmLine = safe_add_line(parentPath, sumPh.Outport(1), dstPort);
set_param(rpmLine, 'Name', 'rpm');
end

function sensorLines = get_sensor_lines(sensorBusPh)
sensorLines = cell(4, 1);
for k = 1:4
    sensorLines{k} = get_param(sensorBusPh.Inport(k), 'Line');
end
end

function set_line_name(lineHandle, name)
if lineHandle ~= -1
    set_param(lineHandle, 'Name', name);
end
end

function set_open_loop_runtime_defaults(openLoopMode, openLoopIqRef)
if ~openLoopMode
    return;
end

if evalin('caller', 'exist(''Start'', ''var'')')
    candidate = evalin('caller', 'Start');
    if isa(candidate, 'Simulink.Parameter')
        candidate.Value = true;
        assignin('caller', 'Start', candidate);
    else
        assignin('caller', 'Start', true);
    end
else
    assignin('caller', 'Start', true);
end

if evalin('caller', 'exist(''ctrl_mode'', ''var'')')
    candidate = evalin('caller', 'ctrl_mode');
    if isa(candidate, 'Simulink.Parameter')
        candidate.Value = uint8(0);
        assignin('caller', 'ctrl_mode', candidate);
    else
        assignin('caller', 'ctrl_mode', uint8(0));
    end
else
    assignin('caller', 'ctrl_mode', uint8(0));
end

if evalin('caller', 'exist(''Id_ref'', ''var'')')
    candidate = evalin('caller', 'Id_ref');
    if isa(candidate, 'Simulink.Parameter')
        candidate.Value = single(0);
        assignin('caller', 'Id_ref', candidate);
    else
        assignin('caller', 'Id_ref', single(0));
    end
else
    assignin('caller', 'Id_ref', single(0));
end

if evalin('caller', 'exist(''Iq_ref'', ''var'')')
    candidate = evalin('caller', 'Iq_ref');
    if isa(candidate, 'Simulink.Parameter')
        candidate.Value = single(openLoopIqRef);
        assignin('caller', 'Iq_ref', candidate);
    else
        assignin('caller', 'Iq_ref', single(openLoopIqRef));
    end
else
    assignin('caller', 'Iq_ref', single(openLoopIqRef));
end

if evalin('caller', 'exist(''speed_ref'', ''var'')')
    candidate = evalin('caller', 'speed_ref');
    if isa(candidate, 'Simulink.Parameter')
        candidate.Value = single(0);
        assignin('caller', 'speed_ref', candidate);
    else
        assignin('caller', 'speed_ref', single(0));
    end
else
    assignin('caller', 'speed_ref', single(0));
end
end

function value = read_workspace_value(name, defaultValue)
value = defaultValue;
if evalin('caller', sprintf('exist(''%s'', ''var'')', name))
    candidate = evalin('caller', name);
    if isa(candidate, 'Simulink.Parameter')
        value = candidate.Value;
    else
        value = candidate;
    end
end
end

function safe_delete_block(blockPath)
if getSimulinkBlockHandle(blockPath) ~= -1
    delete_block(blockPath);
end
end

function safe_delete_line(parentPath, srcPort, dstPort)
try
    delete_line(parentPath, srcPort, dstPort);
catch
    % Line may already be absent on rerun; keep script idempotent.
end
end

function lineHandle = safe_add_line(parentPath, srcPort, dstPort)
safe_delete_line(parentPath, srcPort, dstPort);
safe_clear_port(dstPort);
lineHandle = add_line(parentPath, srcPort, dstPort, 'autorouting', 'on');
end

function safe_clear_port(portHandle)
try
    lineHandle = get_param(portHandle, 'Line');
    if lineHandle ~= -1
        delete_line(lineHandle);
    end
catch
    % Port may already be disconnected.
end
end

function cleanup_models(modelNames)
for k = 1:numel(modelNames)
    name = modelNames{k};
    if bdIsLoaded(name)
        close_system(name, 0);
    end
end
end
