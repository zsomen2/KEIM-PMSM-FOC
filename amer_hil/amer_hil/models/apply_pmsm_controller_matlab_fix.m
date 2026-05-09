function apply_pmsm_controller_matlab_fix(saveModel, runValidation)
%APPLY_PMSM_CONTROLLER_MATLAB_FIX Apply the controller harness fixes in MATLAB.
%
% This helper is intended for R2018b-era scripted edits to the top-level
% pmsm_control.slx model.

if nargin < 1 || isempty(saveModel)
    saveModel = true;
end
if nargin < 2 || isempty(runValidation)
    runValidation = false;
end

scriptDir = fileparts(mfilename('fullpath'));
projectRoot = fileparts(scriptDir);
cd(scriptDir);

addpath(projectRoot);
addpath(fullfile(projectRoot, 'data'));
addpath(fullfile(projectRoot, 'utilities'));
addpath(fullfile(projectRoot, 'plugins'));

rehash toolboxcache;
if exist('sl_refresh_customizations', 'file') == 2
    sl_refresh_customizations;
elseif exist('Advisor.Manager.refresh_customizations', 'file') == 2
    Advisor.Manager.refresh_customizations;
end

if exist('xilinxpath', 'file') == 2
    xilinxpath;
end

evalin('base', 'pmsm_control_init;');
load_system('pmsm_control');

modelName = 'pmsm_control';
mainSpeedPath = [modelName '/Controller/Speed Controller'];

% Keep the PWM trigger aligned to the fast current loop.
set_param([modelName '/PWM_it_Pulse'], 'SampleTime', 'Ts_current/2');
set_param([modelName '/PWM_it_Pulse'], 'Period', 'PWM_it_period');
patch_open_loop_iq_override(mainSpeedPath);

controllerHarnessModel = patch_read_analog_inputs();
controllerPath = [controllerHarnessModel '/Controller'];
focPath = [controllerPath '/PMSM_FOC'];
speedPath = [controllerPath '/Speed Controller'];
gatePath = [focPath '/Gate Enable Fault Logic'];
voltPath = [focPath '/Voltage Limit Anti-Windup'];
svpwmPath = [focPath '/SVPWM Duty Calculation'];

patch_voltage_limit(voltPath);
patch_gate_enable_logic(gatePath, focPath, controllerHarnessModel);
patch_current_pi([focPath '/Id PI Controller'], voltPath, modelName);
patch_current_pi([focPath '/Iq PI Controller'], voltPath, modelName);
patch_speed_controller(speedPath);
patch_open_loop_iq_override(speedPath);
patch_safe_duty_switches(focPath, svpwmPath);
patch_hiterm_current_exports(controllerHarnessModel, controllerPath, focPath);

set_param(controllerHarnessModel, 'SimulationCommand', 'update');

try
    close_system(controllerHarnessModel, 0);
catch
end

if saveModel
    save_system(modelName);
end

if runValidation
    run_pmsm_control_sanity_check;
end
end

function harnessModel = patch_read_analog_inputs()
% Apply theta polarity and optional B/C current channel swap diagnostics.

owner = 'pmsm_control/Controller';
harnessName = 'Controller_DSP';

try
    Simulink.harness.open(owner, harnessName);
catch
    Simulink.harness.open(owner, 'Name', harnessName);
end

harnessModel = bdroot(gcs);
readAnalogPath = [harnessModel '/ReadAnalogInputs'];

if isempty(find_system(harnessModel, 'SearchDepth', 1, 'Name', 'ReadAnalogInputs'))
    error('apply_pmsm_controller_matlab_fix:MissingBlock', ...
        'No block called ''ReadAnalogInputs'' could be found under controller harness ''%s''.', ...
        harnessModel);
end

% Make encoder polarity an actual runtime parameter instead of a dead init
% variable. The generated code then multiplies the raw mechanical angle by
% theta_sign before every downstream use (speed estimation + Park angle).
gainThetaPath = [readAnalogPath '/GainTheta'];
set_param(gainThetaPath, ...
    'Gain', 'single(0.00153398078788564) * single(theta_sign)');

% Optional B/C swap on the ADC channels. This keeps the complete current
% processing path coherent because the swap happens before gain/offset/comp.
ensure_block(readAnalogPath, 'phase_swap_sel', 'simulink/Sources/Constant', [ -300 10 -225 35 ]);
ensure_block(readAnalogPath, 'ADC1_swap', 'simulink/Signal Routing/Switch', [ -110 -105 -55 -70 ]);
ensure_block(readAnalogPath, 'ADC2_swap', 'simulink/Signal Routing/Switch', [ -110 -50 -55 -15 ]);

set_param([readAnalogPath '/phase_swap_sel'], 'Value', 'double(phase_swap_bc)');
set_param([readAnalogPath '/ADC1_swap'], 'Criteria', 'u2 >= Threshold');
set_param([readAnalogPath '/ADC1_swap'], 'Threshold', '0.5');
set_param([readAnalogPath '/ADC2_swap'], 'Criteria', 'u2 >= Threshold');
set_param([readAnalogPath '/ADC2_swap'], 'Threshold', '0.5');

try, delete_line(readAnalogPath, 'ADC1/1', 'Mux/2'); catch, end
try, delete_line(readAnalogPath, 'ADC2/1', 'Mux/3'); catch, end

connect_line(readAnalogPath, 'ADC1/1', 'ADC1_swap/1');
connect_line(readAnalogPath, 'phase_swap_sel/1', 'ADC1_swap/2');
connect_line(readAnalogPath, 'ADC2/1', 'ADC1_swap/3');
connect_line(readAnalogPath, 'ADC2/1', 'ADC2_swap/1');
connect_line(readAnalogPath, 'phase_swap_sel/1', 'ADC2_swap/2');
connect_line(readAnalogPath, 'ADC1/1', 'ADC2_swap/3');
connect_line(readAnalogPath, 'ADC1_swap/1', 'Mux/2');
connect_line(readAnalogPath, 'ADC2_swap/1', 'Mux/3');
end

function patch_voltage_limit(voltPath)
% Replace the dummy sat output with an actual saturation flag.

ensure_block(voltPath, 'sat_vd', 'simulink/Logic and Bit Operations/Relational Operator', [220 60 300 95]);
ensure_block(voltPath, 'sat_vq', 'simulink/Logic and Bit Operations/Relational Operator', [220 130 300 165]);
ensure_block(voltPath, 'sat_or', 'simulink/Logic and Bit Operations/Logical Operator', [330 90 385 135]);

set_param([voltPath '/sat_vd'], 'Operator', '~=');
set_param([voltPath '/sat_vq'], 'Operator', '~=');
set_param([voltPath '/sat_or'], 'Operator', 'OR');
set_param([voltPath '/sat_or'], 'Inputs', '2');

try, delete_line(voltPath, 'Vd_raw/1', 'sat_vd/1'); catch, end
try, delete_line(voltPath, 'Limit Vd/1', 'sat_vd/2'); catch, end
try, delete_line(voltPath, 'Vq_raw/1', 'sat_vq/1'); catch, end
try, delete_line(voltPath, 'Limit Vq/1', 'sat_vq/2'); catch, end
try, delete_line(voltPath, 'sat_vd/1', 'sat_or/1'); catch, end
try, delete_line(voltPath, 'sat_vq/1', 'sat_or/2'); catch, end
try, delete_line(voltPath, 'sat_false/1', 'sat/1'); catch, end

connect_line(voltPath, 'Vd_raw/1', 'sat_vd/1');
connect_line(voltPath, 'Limit Vd/1', 'sat_vd/2');
connect_line(voltPath, 'Vq_raw/1', 'sat_vq/1');
connect_line(voltPath, 'Limit Vq/1', 'sat_vq/2');
connect_line(voltPath, 'sat_vd/1', 'sat_or/1');
connect_line(voltPath, 'sat_vq/1', 'sat_or/2');
connect_line(voltPath, 'sat_or/1', 'sat/1');
end

function patch_gate_enable_logic(gatePath, focPath, modelName)
% Add a latched fault state with I_limit and status awareness.

ensure_block(gatePath, 'status', 'simulink/Sources/In1', [25 25 55 39]);
ensure_block(gatePath, 'Iabc', 'simulink/Sources/In1', [25 70 55 84]);
try, delete_block([gatePath '/IabsMax']); catch, end
ensure_block(gatePath, 'Iabc_split', 'simulink/Signal Routing/Demux', [95 55 125 120]);
ensure_block(gatePath, 'Iabs_a', 'simulink/Math Operations/Abs', [160 35 200 65]);
ensure_block(gatePath, 'Iabs_b', 'simulink/Math Operations/Abs', [160 85 200 115]);
ensure_block(gatePath, 'Iabs_c', 'simulink/Math Operations/Abs', [160 135 200 165]);
ensure_block(gatePath, 'Imax_ab', 'simulink/Math Operations/MinMax', [240 60 290 100]);
ensure_block(gatePath, 'Imax_abc', 'simulink/Math Operations/MinMax', [320 85 370 125]);
ensure_block(gatePath, 'current_limit', 'simulink/Sources/Constant', [180 30 230 50]);
ensure_block(gatePath, 'status_zero', 'simulink/Sources/Constant', [180 120 230 140]);
ensure_block(gatePath, 'current_fault', 'simulink/Logic and Bit Operations/Relational Operator', [245 40 305 75]);
ensure_block(gatePath, 'status_fault', 'simulink/Logic and Bit Operations/Relational Operator', [245 115 305 150]);
ensure_block(gatePath, 'fault_state', 'simulink/Discrete/Unit Delay', [360 90 410 130]);
ensure_block(gatePath, 'fault_reset_switch', 'simulink/Signal Routing/Switch', [300 150 350 210]);
ensure_block(gatePath, 'fault_zero', 'simulink/Sources/Constant', [250 175 285 195]);

set_param([gatePath '/Iabc_split'], 'Outputs', '3');
set_param([gatePath '/Imax_ab'], 'Function', 'max');
set_param([gatePath '/Imax_ab'], 'Inputs', '2');
set_param([gatePath '/Imax_abc'], 'Function', 'max');
set_param([gatePath '/Imax_abc'], 'Inputs', '2');
set_param([gatePath '/current_fault'], 'Operator', '>=');
set_param([gatePath '/status_fault'], 'Operator', '~=');
set_param([gatePath '/fault_state'], 'InitialCondition', 'false');
set_param([gatePath '/fault_reset_switch'], 'Criteria', 'u2 >= Threshold');
set_param([gatePath '/fault_reset_switch'], 'Threshold', '0.5');
set_param([gatePath '/fault_zero'], 'Value', 'false');
set_param([gatePath '/current_limit'], 'Value', 'I_limit');
set_param([gatePath '/status_zero'], 'Value', '0');
set_param([gatePath '/status'], 'Port', '5');
set_param([gatePath '/Iabc'], 'Port', '6');

% Inputs 1 and 2 already exist.
set_param([gatePath '/fault_or'], 'Operator', 'OR');
set_param([gatePath '/fault_or'], 'Inputs', '5');
set_param([gatePath '/not_fault'], 'Operator', 'NOT');
set_param([gatePath '/gate_and'], 'Operator', 'AND');
set_param([gatePath '/gate_and'], 'Inputs', '2');

% Rewire the gate logic.
try, delete_line(gatePath, 'sensor_fault/1', 'fault_or/1'); catch, end
try, delete_line(gatePath, 'Udc_low/1', 'fault_or/2'); catch, end
try, delete_line(gatePath, 'fault_or/1', 'not_fault/1'); catch, end
try, delete_line(gatePath, 'fault_or/1', 'fault/1'); catch, end
try, delete_line(gatePath, 'fault_reset/1', 'fault/1'); catch, end
try, delete_line(gatePath, 'Start/1', 'gate_and/1'); catch, end
try, delete_line(gatePath, 'not_fault/1', 'gate_and/2'); catch, end

connect_line(gatePath, 'sensor_fault/1', 'fault_or/1');
connect_line(gatePath, 'Udc_low/1', 'fault_or/2');
connect_line(gatePath, 'status_fault/1', 'fault_or/3');
connect_line(gatePath, 'current_fault/1', 'fault_or/4');
connect_line(gatePath, 'fault_state/1', 'fault_or/5');
connect_line(gatePath, 'fault_or/1', 'fault_reset_switch/3');
connect_line(gatePath, 'fault_zero/1', 'fault_reset_switch/1');
connect_line(gatePath, 'fault_reset/1', 'fault_reset_switch/2');
connect_line(gatePath, 'fault_reset_switch/1', 'fault_state/1');
connect_line(gatePath, 'fault_state/1', 'fault/1');
connect_line(gatePath, 'fault_state/1', 'not_fault/1');
connect_line(gatePath, 'Start/1', 'gate_and/1');
connect_line(gatePath, 'not_fault/1', 'gate_and/2');

% Route top-level signals into the new inputs.
connect_line(focPath, 'status/1', 'Gate Enable Fault Logic/5');
connect_line(focPath, 'Iabc/1', 'Gate Enable Fault Logic/6');

% Current fault compare uses the exported phase current limit.
connect_line(gatePath, 'Iabc/1', 'Iabc_split/1');
connect_line(gatePath, 'Iabc_split/1', 'Iabs_a/1');
connect_line(gatePath, 'Iabc_split/2', 'Iabs_b/1');
connect_line(gatePath, 'Iabc_split/3', 'Iabs_c/1');
connect_line(gatePath, 'Iabs_a/1', 'Imax_ab/1');
connect_line(gatePath, 'Iabs_b/1', 'Imax_ab/2');
connect_line(gatePath, 'Imax_ab/1', 'Imax_abc/1');
connect_line(gatePath, 'Iabs_c/1', 'Imax_abc/2');
connect_line(gatePath, 'Imax_abc/1', 'current_fault/1');
connect_line(gatePath, 'current_limit/1', 'current_fault/2');
connect_line(gatePath, 'status/1', 'status_fault/1');
connect_line(gatePath, 'status_zero/1', 'status_fault/2');
end

function patch_current_pi(piPath, voltPath, modelName)
% Convert the current PI to a fixed-step discrete integrator inside the ISR.

ensure_block(piPath, 'sat', 'simulink/Sources/In1', [25 145 55 159]);
ensure_block(piPath, 'fault_reset', 'simulink/Sources/In1', [25 185 55 199]);
ensure_block(piPath, 'sat_not', 'simulink/Logic and Bit Operations/Logical Operator', [95 135 135 170]);
ensure_block(piPath, 'Ki_gate', 'simulink/Math Operations/Product', [175 95 220 135]);
ensure_block(piPath, 'Integrator_sum', 'simulink/Math Operations/Sum', [255 88 295 122]);
ensure_block(piPath, 'Integrator_zero', 'simulink/Sources/Constant', [250 165 295 185]);
ensure_block(piPath, 'Integrator_reset_switch', 'simulink/Signal Routing/Switch', [330 110 390 170]);

set_param([piPath '/sat_not'], 'Operator', 'NOT');
set_param([piPath '/Ki_gate'], 'Inputs', '**');
set_param([piPath '/sat'], 'Port', '3');
set_param([piPath '/fault_reset'], 'Port', '4');
set_param([piPath '/Integrator_sum'], 'Inputs', '++');
set_param([piPath '/Integrator_zero'], 'Value', 'single(0)');
set_param([piPath '/Integrator_reset_switch'], 'Criteria', 'u2 >= Threshold');
set_param([piPath '/Integrator_reset_switch'], 'Threshold', '0.5');

safe_delete_if_exists(piPath, 'Integrator');
add_block('simulink/Discrete/Unit Delay', [piPath '/Integrator'], ...
    'Position', [430 90 480 120]);
set_param([piPath '/Integrator'], ...
    'X0', 'single(0)', ...
    'SampleTime', '-1');

try, delete_line(piPath, 'Ki/1', 'Integrator/1'); catch, end
try, delete_line(piPath, 'Ki_gate/1', 'Integrator/1'); catch, end
try, delete_line(piPath, 'fault_reset/1', 'Integrator/2'); catch, end
try, delete_line(piPath, 'Integrator/1', 'P_plus_I/2'); catch, end
connect_line(piPath, 'sat/1', 'sat_not/1');
connect_line(piPath, 'Ki/1', 'Ki_gate/1');
connect_line(piPath, 'sat_not/1', 'Ki_gate/2');
connect_line(piPath, 'Integrator/1', 'Integrator_sum/1');
connect_line(piPath, 'Ki_gate/1', 'Integrator_sum/2');
connect_line(piPath, 'Integrator_zero/1', 'Integrator_reset_switch/1');
connect_line(piPath, 'fault_reset/1', 'Integrator_reset_switch/2');
connect_line(piPath, 'Integrator_sum/1', 'Integrator_reset_switch/3');
connect_line(piPath, 'Integrator_reset_switch/1', 'Integrator/1');
connect_line(piPath, 'Integrator/1', 'P_plus_I/2');

% Route the saturation and reset signals from the parent FOC subsystem.
focPath = fileparts(piPath);
connect_line(focPath, 'Voltage Limit Anti-Windup/3', [get_param(piPath, 'Name') '/3']);
connect_line(focPath, 'fault_reset/1', [get_param(piPath, 'Name') '/4']);
end

function patch_speed_controller(speedPath)
% Add an anti-windup gate to the speed PI and wire reset to the integrator.

set_param([speedPath '/Integrator'], 'ExternalReset', 'rising');
set_param([speedPath '/Integrator'], 'LimitOutput', 'off');
set_param([speedPath '/Iq_limit'], 'UpperLimit', 'Speed_Iq_limit');
set_param([speedPath '/Iq_limit'], 'LowerLimit', '-Speed_Iq_limit');

ensure_block(speedPath, 'sat_detect', 'simulink/Logic and Bit Operations/Relational Operator', [460 165 530 205]);
ensure_block(speedPath, 'sat_not', 'simulink/Logic and Bit Operations/Logical Operator', [540 160 585 200]);
ensure_block(speedPath, 'Ki_aw_gate', 'simulink/Logic and Bit Operations/Logical Operator', [610 155 660 205]);

set_param([speedPath '/sat_detect'], 'Operator', '~=');
set_param([speedPath '/sat_not'], 'Operator', 'NOT');
set_param([speedPath '/Ki_aw_gate'], 'Operator', 'AND');
set_param([speedPath '/Ki_aw_gate'], 'Inputs', '2');

try, delete_line(speedPath, 'add_feedforward/1', 'sat_detect/1'); catch, end
try, delete_line(speedPath, 'Iq_limit/1', 'sat_detect/2'); catch, end
try, delete_line(speedPath, 'active_single/1', 'Ki_gate/2'); catch, end
connect_line(speedPath, 'add_feedforward/1', 'sat_detect/1');
connect_line(speedPath, 'Iq_limit/1', 'sat_detect/2');
connect_line(speedPath, 'sat_detect/1', 'sat_not/1');
connect_line(speedPath, 'active_single/1', 'Ki_aw_gate/1');
connect_line(speedPath, 'sat_not/1', 'Ki_aw_gate/2');
connect_line(speedPath, 'Ki_aw_gate/1', 'Ki_gate/2');
connect_line(speedPath, 'fault_reset/1', 'Integrator/2');
end

function patch_open_loop_iq_override(speedPath)
% Allow forcing a fixed q-axis current command from HiTerm/CCS.

ensure_block(speedPath, 'open_loop_mode_sel', 'simulink/Sources/Constant', [720 35 800 55]);
ensure_block(speedPath, 'open_loop_iq_cmd', 'simulink/Sources/Constant', [720 90 800 110]);
ensure_block(speedPath, 'open_loop_iq_switch', 'simulink/Signal Routing/Switch', [860 55 920 115]);

set_param([speedPath '/open_loop_mode_sel'], 'Value', 'double(open_loop_mode)');
set_param([speedPath '/open_loop_iq_cmd'], 'Value', 'single(open_loop_iq_ref)');
set_param([speedPath '/open_loop_iq_switch'], 'Criteria', 'u2 >= Threshold');
set_param([speedPath '/open_loop_iq_switch'], 'Threshold', '0.5');

modeSwitchPath = [speedPath '/mode_switch'];
try
    delete_line(speedPath, 'mode_switch/1', 'Iq_cmd/1');
catch
end

connect_line(speedPath, 'mode_switch/1', 'open_loop_iq_switch/3');
connect_line(speedPath, 'open_loop_mode_sel/1', 'open_loop_iq_switch/2');
connect_line(speedPath, 'open_loop_iq_cmd/1', 'open_loop_iq_switch/1');
connect_line(speedPath, 'open_loop_iq_switch/1', 'Iq_cmd/1');
end

function patch_safe_duty_switches(focPath, svpwmPath)
% Force neutral duty on gate-off at the FOC output.

ensure_block(focPath, 'D_safe', 'simulink/Sources/Constant', [770 70 820 100]);
ensure_block(focPath, 'Da_safe_switch', 'simulink/Signal Routing/Switch', [860 60 920 100]);
ensure_block(focPath, 'Db_safe_switch', 'simulink/Signal Routing/Switch', [860 110 920 150]);
ensure_block(focPath, 'Dc_safe_switch', 'simulink/Signal Routing/Switch', [860 160 920 200]);

set_param([focPath '/D_safe'], 'Value', 'D_safe');
set_param([focPath '/Da_safe_switch'], 'Criteria', 'u2 >= Threshold');
set_param([focPath '/Da_safe_switch'], 'Threshold', '0.5');
set_param([focPath '/Db_safe_switch'], 'Criteria', 'u2 >= Threshold');
set_param([focPath '/Db_safe_switch'], 'Threshold', '0.5');
set_param([focPath '/Dc_safe_switch'], 'Criteria', 'u2 >= Threshold');
set_param([focPath '/Dc_safe_switch'], 'Threshold', '0.5');

% Re-route the computed duties through the safe-duty switches.
try, delete_line(focPath, 'SVPWM Duty Calculation/1', 'Da/1'); catch, end
try, delete_line(focPath, 'SVPWM Duty Calculation/2', 'Db/1'); catch, end
try, delete_line(focPath, 'SVPWM Duty Calculation/3', 'Dc/1'); catch, end
connect_line(focPath, 'SVPWM Duty Calculation/1', 'Da_safe_switch/1');
connect_line(focPath, 'Gate Enable Fault Logic/1', 'Da_safe_switch/2');
connect_line(focPath, 'D_safe/1', 'Da_safe_switch/3');
connect_line(focPath, 'SVPWM Duty Calculation/2', 'Db_safe_switch/1');
connect_line(focPath, 'Gate Enable Fault Logic/1', 'Db_safe_switch/2');
connect_line(focPath, 'D_safe/1', 'Db_safe_switch/3');
connect_line(focPath, 'SVPWM Duty Calculation/3', 'Dc_safe_switch/1');
connect_line(focPath, 'Gate Enable Fault Logic/1', 'Dc_safe_switch/2');
connect_line(focPath, 'D_safe/1', 'Dc_safe_switch/3');
connect_line(focPath, 'Da_safe_switch/1', 'Da/1');
connect_line(focPath, 'Db_safe_switch/1', 'Db/1');
connect_line(focPath, 'Dc_safe_switch/1', 'Dc/1');
end

function patch_hiterm_current_exports(harnessModel, controllerPath, focPath)
% Export the controller-computed d/q currents as globals for HiTerm.

parkPath = [focPath '/Park Transform'];

safe_delete_if_exists(harnessModel, 'IdMonitorMemory');
safe_delete_if_exists(harnessModel, 'IqMonitorMemory');
safe_delete_if_exists(harnessModel, 'IdMonStore');
safe_delete_if_exists(harnessModel, 'IqMonStore');
safe_delete_if_exists(controllerPath, 'IdMonStore');
safe_delete_if_exists(controllerPath, 'IqMonStore');
safe_delete_if_exists(focPath, 'IdMonStore');
safe_delete_if_exists(focPath, 'IqMonStore');
safe_delete_if_exists(focPath, 'WriteIdMonitor');
safe_delete_if_exists(focPath, 'WriteIqMonitor');
safe_delete_if_exists(parkPath, 'WriteIdMon');
safe_delete_if_exists(parkPath, 'WriteIqMon');

ensure_block(focPath, 'IdMonStore', 'simulink/Signal Routing/Data Store Memory', [820 20 900 50]);
ensure_block(focPath, 'IqMonStore', 'simulink/Signal Routing/Data Store Memory', [820 60 900 90]);
ensure_block(parkPath, 'WriteIdMon', 'simulink/Signal Routing/Data Store Write', [355 60 455 90]);
ensure_block(parkPath, 'WriteIqMon', 'simulink/Signal Routing/Data Store Write', [355 110 455 140]);

set_param([focPath '/IdMonStore'], ...
    'DataStoreName', 'Id_mon', ...
    'InitialValue', 'single(0)', ...
    'RTWStateStorageClass', 'ExportedGlobal', ...
    'OutDataTypeStr', 'single');
set_param([focPath '/IqMonStore'], ...
    'DataStoreName', 'Iq_mon', ...
    'InitialValue', 'single(0)', ...
    'RTWStateStorageClass', 'ExportedGlobal', ...
    'OutDataTypeStr', 'single');

set_param([parkPath '/WriteIdMon'], 'DataStoreName', 'Id_mon');
set_param([parkPath '/WriteIqMon'], 'DataStoreName', 'Iq_mon');

connect_line(parkPath, 'Id_sum/1', 'WriteIdMon/1');
connect_line(parkPath, 'Iq_sum/1', 'WriteIqMon/1');
end

function ensure_block(parentPath, blockName, libPath, position)
fullPath = [parentPath '/' blockName];
if isempty(find_system(parentPath, 'SearchDepth', 1, 'Name', blockName))
    add_block(libPath, fullPath, 'Position', position);
else
    set_param(fullPath, 'Position', position);
end
end

function connect_line(parentPath, src, dst)
try
    delete_line(parentPath, src, dst);
catch
end

dstPortHandle = local_port_handle(parentPath, dst, 'Inport');
try
    dstLineHandle = get_param(dstPortHandle, 'Line');
    if dstLineHandle ~= -1
        delete_line(dstLineHandle);
    end
catch
end

try
    srcPortHandle = local_port_handle(parentPath, src, 'Outport');
    srcLineHandle = get_param(srcPortHandle, 'Line');
    if srcLineHandle ~= -1 && dstPortHandle ~= -1
        dstPortHandles = get_param(srcLineHandle, 'DstPortHandle');
        if ~iscell(dstPortHandles)
            dstPortHandles = num2cell(dstPortHandles);
        end
        for k = 1:numel(dstPortHandles)
            if isequal(dstPortHandles{k}, dstPortHandle)
                return;
            end
        end
    end
catch
end

add_line(parentPath, src, dst, 'autorouting', 'on');
end

function portNum = subsystem_port_number(subsystemPath, blockName, blockType)
block = find_system(subsystemPath, 'SearchDepth', 1, 'BlockType', blockType, 'Name', blockName);
if isempty(block)
    error('apply_pmsm_controller_matlab_fix:MissingPortBlock', ...
        'Could not find %s block ''%s'' under ''%s''.', blockType, blockName, subsystemPath);
end

portNum = str2double(get_param(block{1}, 'Port'));
end

function safe_delete_if_exists(parentPath, blockName)
fullPath = [parentPath '/' blockName];
if ~isempty(find_system(parentPath, 'SearchDepth', 1, 'Name', blockName))
    try
        delete_block(fullPath);
    catch
    end
end
end

function portHandle = local_port_handle(parentPath, endpoint, portType)
tokens = regexp(endpoint, '^(.*)/(\d+)$', 'tokens', 'once');
if isempty(tokens)
    error('apply_pmsm_controller_matlab_fix:BadEndpoint', ...
        'Endpoint must have block/port form: %s', endpoint);
end

blockPath = [parentPath '/' tokens{1}];
portNum = str2double(tokens{2});
portHandles = get_param(blockPath, 'PortHandles');

switch portType
    case 'Inport'
        portHandle = portHandles.Inport(portNum);
    case 'Outport'
        portHandle = portHandles.Outport(portNum);
    otherwise
        error('apply_pmsm_controller_matlab_fix:BadPortType', ...
            'Unsupported port type: %s', portType);
end
end
