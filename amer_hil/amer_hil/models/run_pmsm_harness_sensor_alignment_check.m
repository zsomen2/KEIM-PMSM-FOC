function run_pmsm_harness_sensor_alignment_check()
%RUN_PMSM_HARNESS_SENSOR_ALIGNMENT_CHECK Structural check for PMSM HIL sensor paths.

scriptDir = fileparts(mfilename('fullpath'));
cd(scriptDir);

setappdata(0, 'pmsm_diag_knobs', capture_diagnostic_knobs());
pmsm_control_init;
if isappdata(0, 'pmsm_diag_knobs')
    restore_diagnostic_knobs(getappdata(0, 'pmsm_diag_knobs'));
    rmappdata(0, 'pmsm_diag_knobs');
end
scriptDir = fileparts(mfilename('fullpath'));
load_system('pmsm_control');

verify_controller_harness();
verify_fpga_harness();
verify_generated_hdl_semantics(scriptDir);

disp('PMSM_HARNESS_SENSOR_ALIGNMENT_CHECK_OK');
bdclose('all');
end

function verify_controller_harness()
Simulink.harness.open('pmsm_control/Controller', 'Controller_DSP');
hModel = bdroot(gcs);
assert(strcmp(hModel, 'Controller_DSP'), 'Controller harness did not open.');

requiredBlocks = {
    'Controller_DSP/ReadAnalogInputs/eQEP1'
    'Controller_DSP/ReadAnalogInputs/GainTheta'
    'Controller_DSP/ReadAnalogInputs/GainW'
    'Controller_DSP/ReadAnalogInputs/GainRPM'
    'Controller_DSP/ReadAnalogInputs/UdcADC'
    'Controller_DSP/ReadAnalogInputs/UdcGain'
    'Controller_DSP/ReadAnalogInputs/StatusFromTask'
    'Controller_DSP/ReadAnalogInputs/CPLDInRead'
    'Controller_DSP/ReadAnalogInputs/CPLDInSelect'
    'Controller_DSP/ReadAnalogInputs/FaultFromFAIL'
    'Controller_DSP/SensorStatusMemory'
    'Controller_DSP/Task_1ms_pre/StatusToUint16'
    'Controller_DSP/Task_1ms_pre/WriteSensorStatus'
    };

for k = 1:numel(requiredBlocks)
    assert(getSimulinkBlockHandle(requiredBlocks{k}) ~= -1, ...
        'Missing block: %s', requiredBlocks{k});
end

for name = {'theta0', 'w0', 'rpm0', 'status0', 'fault0'}
    assert(getSimulinkBlockHandle(['Controller_DSP/ReadAnalogInputs/' name{1}]) == -1, ...
        'Stale placeholder block still exists: %s', name{1});
end

verify_eqep_module_is_2('Controller_DSP/ReadAnalogInputs/eQEP1');
verify_eqep_position_limits('Controller_DSP/ReadAnalogInputs/eQEP1');
verify_digital_input2_bank('Controller_DSP/Task_1ms_pre/Digital Input2');
verify_wrap_aware_theta_delta('Controller_DSP/ReadAnalogInputs/DTheta');
verify_rpm_average_filter('Controller_DSP/ReadAnalogInputs/GainRPM');
verify_sensor_routes('Controller_DSP/ReadAnalogInputs');

sensorBus = 'Controller_DSP/ReadAnalogInputs/SensorBus';
sensorPh = get_param(sensorBus, 'PortHandles');
assert(strcmp(get_param(get_param(sensorPh.Inport(6), 'Line'), 'Name'), 'theta'), 'theta line mismatch');
assert(strcmp(get_param(get_param(sensorPh.Inport(7), 'Line'), 'Name'), 'w'), 'w line mismatch');
assert(strcmp(get_param(get_param(sensorPh.Inport(8), 'Line'), 'Name'), 'rpm'), 'rpm line mismatch');
assert(strcmp(get_param(get_param(sensorPh.Inport(9), 'Line'), 'Name'), 'status'), 'status line mismatch');
assert(strcmp(get_param(get_param(sensorPh.Inport(10), 'Line'), 'Name'), 'fault'), 'fault line mismatch');

cs = getActiveConfigSet(hModel);
toolchainOptions = get_param(cs, 'CustomToolchainOptions');
assert(iscell(toolchainOptions), 'CustomToolchainOptions is not a cell array.');
assert(numel(toolchainOptions) >= 24, 'Unexpected CustomToolchainOptions size.');
assert(any(strcmp(toolchainOptions, 'Assembler')), 'Missing Assembler toolchain option.');
assert(any(strcmp(toolchainOptions, 'C Compiler')), 'Missing C Compiler toolchain option.');
assert(any(strcmp(toolchainOptions, 'Linker')), 'Missing Linker toolchain option.');
assert(any(strcmp(toolchainOptions, 'Make Tool')), 'Missing Make Tool toolchain option.');
assert(strcmp(get_param(cs, 'Toolchain'), 'Texas Instruments Code Composer Studio (C2000)'), ...
    'Unexpected toolchain on Controller_DSP harness.');

bdclose(hModel);
end

function verify_digital_input2_bank(blockPath)
gpioBank = get_param(blockPath, 'GPIO_Number');
assert(strcmp(gpioBank, 'GPIO40~GPIO44'), ...
    'Digital Input2 GPIO bank must be GPIO40~GPIO44 to avoid eQEP2 conflict.');
end

function verify_eqep_position_limits(blockPath)
maxVal = get_param(blockPath, 'pcMaximumvalue');
assert(strcmp(maxVal, '4095'), 'eQEP pcMaximumvalue must be 4095.');
end

function verify_wrap_aware_theta_delta(blockPath)
parentPath = fileparts(blockPath);
for name = {'WrapThetaDeltaFcn'}
    blk = [parentPath '/' name{1}];
    assert(getSimulinkBlockHandle(blk) ~= -1, 'Missing wrap block: %s', blk);
end
end

function verify_rpm_average_filter(blockPath)
parentPath = fileparts(blockPath);
for name = {'RpmAvgDiff', 'RpmAvgGain', 'RpmAvgSum', 'RpmAvgDelay'}
    blk = [parentPath '/' name{1}];
    assert(getSimulinkBlockHandle(blk) ~= -1, 'Missing rpm filter block: %s', blk);
end
end

function diagKnobs = capture_diagnostic_knobs()
diagKnobs = struct();
for name = {'theta_sign', 'phase_swap_bc', 'open_loop_mode', 'open_loop_iq_ref'}
    if evalin('caller', sprintf('exist(''%s'', ''var'')', name{1}))
        candidate = evalin('caller', name{1});
        if isa(candidate, 'Simulink.Parameter')
            diagKnobs.(name{1}) = candidate;
        else
            diagKnobs.(name{1}) = candidate;
        end
    end
end
end

function restore_diagnostic_knobs(diagKnobs)
fields = fieldnames(diagKnobs);
for k = 1:numel(fields)
    assignin('caller', fields{k}, diagKnobs.(fields{k}));
end
end

function verify_sensor_routes(parentPath)
assert(getSimulinkBlockHandle([parentPath '/Vout0']) == -1, 'Old Vout0 block must be removed.');
assert(getSimulinkBlockHandle([parentPath '/zero_current']) == -1, 'Old zero_current block must be removed.');
assert(getSimulinkBlockHandle([parentPath '/neg_ia']) == -1, 'Old neg_ia block must be removed.');
assert(getSimulinkBlockHandle([parentPath '/UdcConst']) == -1, 'Old Udc constant source must be removed.');
assert(getSimulinkBlockHandle([parentPath '/UdcADC']) ~= -1, 'Missing Udc ADC source.');
assert(getSimulinkBlockHandle([parentPath '/UdcGain']) ~= -1, 'Missing Udc scaling block.');

sensorBusPath = [parentPath '/SensorBus'];
sensorPh = get_param(sensorBusPath, 'PortHandles');
assert_line_source(sensorPh.Inport(1), [parentPath '/Demux'], 'Ia');
assert_line_source(sensorPh.Inport(2), [parentPath '/Demux'], 'Ib');
assert_line_source(sensorPh.Inport(3), [parentPath '/Demux'], 'Ic');
assert_line_source(sensorPh.Inport(4), [parentPath '/UdcGain'], 'Udc');
assert_line_source(sensorPh.Inport(5), [parentPath '/IabcMux'], 'Iabc');
assert_line_source(sensorPh.Inport(6), [parentPath '/GainTheta'], 'theta');
assert_line_source(sensorPh.Inport(7), [parentPath '/GainW'], 'w');
assert_line_source(sensorPh.Inport(8), [parentPath '/RpmAvgSum'], 'rpm');
assert_line_source(sensorPh.Inport(9), [parentPath '/StatusFromTask'], 'status');
assert_line_source(sensorPh.Inport(10), [parentPath '/FaultFromFAIL'], 'fault');

abcMuxPh = get_param([parentPath '/IabcMux'], 'PortHandles');
assert_line_source(abcMuxPh.Inport(1), [parentPath '/Demux'], 'Ia');
assert_line_source(abcMuxPh.Inport(2), [parentPath '/Demux'], 'Ib');
assert_line_source(abcMuxPh.Inport(3), [parentPath '/Demux'], 'Ic');

udcAdcBlk = [parentPath '/UdcADC'];
assert(strcmp(get_param(udcAdcBlk, 'useSOC1'), 'SOC3'), 'Udc ADC must use SOC3.');
assert(strcmp(get_param(udcAdcBlk, 'conv1'), 'ADCINA6'), 'Udc ADC must read ADCINA6.');
assert(strcmp(get_param(udcAdcBlk, 'interruptSel'), 'ADCINT2'), 'Udc ADC interrupt selection must be ADCINT2.');
assert(strcmp(get_param([parentPath '/UdcGain'], 'OutDataTypeStr'), 'single'), 'Udc gain output must be single.');

udcGainExpr = get_param([parentPath '/UdcGain'], 'Gain');
assert(strcmp(udcGainExpr, 'single(1000/4096)'), 'Udc gain must be single(1000/4096).');
end

function assert_line_source(portHandle, expectedSrcBlock, expectedLineName)
ln = get_param(portHandle, 'Line');
assert(ln ~= -1, 'Missing line connection.');
src = get_param(ln, 'SrcBlockHandle');
assert(strcmp(getfullname(src), expectedSrcBlock), ...
    'Unexpected source block. Expected %s.', expectedSrcBlock);
assert(strcmp(get_param(ln, 'Name'), expectedLineName), ...
    'Unexpected line name. Expected %s.', expectedLineName);
end

function verify_eqep_module_is_2(blockPath)
dp = get_param(blockPath, 'DialogParameters');
fn = fieldnames(dp);
moduleIdx = find(contains(lower(fn), 'module'));
assert(~isempty(moduleIdx), 'No module-like parameter found on %s.', blockPath);

isEqep2 = false;
for i = 1:numel(moduleIdx)
    readback = get_param(blockPath, fn{moduleIdx(i)});
    if contains(lower(readback), '2')
        isEqep2 = true;
        break;
    end
end

assert(isEqep2, 'eQEP block is not configured to eQEP2 in Controller harness.');
end

function verify_generated_hdl_semantics(scriptDir)
hdlDir = fullfile(scriptDir, '..', 'work', 'hdl_prj_pmsm', 'hdlsrc', 'pmsm_FPGA_HIL');
mechFile = fullfile(hdlDir, 'pmsm_FPGA_ip_src_pmsm_mechanical.v');
signalMuxFile = fullfile(hdlDir, 'pmsm_FPGA_ip_src_SignalMUX.v');

assert(exist(mechFile, 'file') == 2, 'Missing generated HDL file: %s', mechFile);
assert(exist(signalMuxFile, 'file') == 2, 'Missing generated HDL file: %s', signalMuxFile);

mechText = fileread(mechFile);
signalMuxText = fileread(signalMuxFile);

assert(contains(mechText, "assign Switch2_out1 = (switch_compare_1 == 1'b0 ? Gain1_out1_dtc :"), ...
    'speed_en semantics changed unexpectedly in generated pmsm_mechanical HDL.');
assert(contains(mechText, "assign Switch1_out1 = (switch_compare_1_1 == 1'b0 ? Gain2_out1_dtc :"), ...
    'theta_en semantics changed unexpectedly in generated pmsm_mechanical HDL.');
assert(contains(signalMuxText, 'assign rpm = ModelOut_rpm;'), ...
    'Encoder path is not sourced from ModelOut_rpm in generated SignalMUX HDL.');
assert(contains(signalMuxText, '.RPM(rpm)'), ...
    'Encoder instance does not use the generated rpm signal.');
end

function verify_fpga_harness()
Simulink.harness.open('pmsm_control/Plant/Plant_PMSM_HIL', 'pmsm_FPGA_HIL');
hModel = bdroot(gcs);
assert(strcmp(hModel, 'pmsm_FPGA_HIL'), 'FPGA harness did not open.');

selector = sprintf('pmsm_FPGA_HIL/SignalMUX/Bus\nSelector7');
signals = get_param(selector, 'OutputSignals');
assert(contains(signals, 'encoder_on'), 'SignalMUX selector does not expose encoder_on.');

for path = {
        'pmsm_FPGA_HIL/HitermInputs/speed_en'
        'pmsm_FPGA_HIL/HitermInputs/speed0'
        'pmsm_FPGA_HIL/HitermInputs/theta_en'
        'pmsm_FPGA_HIL/HitermInputs/theta0'
        'pmsm_FPGA_HIL/HitermInputs/encoder_on'
        }
    assert(getSimulinkBlockHandle(path{1}) ~= -1, 'Missing HIL parameter port: %s', path{1});
end

bdclose(hModel);
end
