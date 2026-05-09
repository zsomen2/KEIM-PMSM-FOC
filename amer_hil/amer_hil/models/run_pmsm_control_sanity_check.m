function run_pmsm_control_sanity_check()
modelName = 'pmsm_control';
load_system(modelName);

orig = struct();
orig.StopTime = get_param(modelName, 'StopTime');
orig.Solver = get_param(modelName, 'Solver');
orig.FixedStep = get_param(modelName, 'FixedStep');
orig.StartTime = get_param([modelName '/StartStep'], 'Time');
orig.StartBefore = get_param([modelName '/StartStep'], 'Before');
orig.StartAfter = get_param([modelName '/StartStep'], 'After');
orig.IqTime = get_param([modelName '/IqRefStep'], 'Time');
orig.IqBefore = get_param([modelName '/IqRefStep'], 'Before');
orig.IqAfter = get_param([modelName '/IqRefStep'], 'After');
orig.ctrl_mode = evalin('base', 'ctrl_mode');
orig.speed_ref = evalin('base', 'speed_ref');
orig.Iq_ref = evalin('base', 'Iq_ref');
orig.Id_ref = evalin('base', 'Id_ref');
orig.Speed_Kp = evalin('base', 'Speed_Kp.Value');
orig.Speed_Ki = evalin('base', 'Speed_Ki.Value');
orig.Speed_Iq_limit = evalin('base', 'Speed_Iq_limit.Value');

cleanupObj = onCleanup(@() restore_model(modelName, orig)); %#ok<NASGU>

safe_delete_if_exists([modelName '/Plant'], 'MechValidationLog');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationMux');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogTau');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogWm');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogW');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogRpm');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogTheta');
safe_delete_if_exists([modelName '/Plant'], 'MechValidationSelect');

set_param(modelName, 'Solver', 'FixedStepDiscrete');
set_param(modelName, 'FixedStep', 'dt_plant_sim');
set_param(modelName, 'StopTime', '0.02');

tests = { ...
    struct('name', 'StartOff', 'startAfter', '0', 'iqAfter', '0', 'expectGate', 0), ...
    struct('name', 'StartOnIq5', 'startAfter', '1', 'iqAfter', '5', 'expectGate', 1), ...
    struct('name', 'StartOnIqMinus5', 'startAfter', '1', 'iqAfter', '-5', 'expectGate', 1) ...
};

results = struct([]);

for k = 1:numel(tests)
    testCfg = tests{k};
    set_param([modelName '/StartStep'], 'Time', '0.005', 'Before', '0', 'After', testCfg.startAfter);
    set_param([modelName '/IqRefStep'], 'Time', '0.005', 'Before', '0', 'After', testCfg.iqAfter);
    assignin('base', 'ctrl_mode', uint8(0));
    assignin('base', 'speed_ref', single(0));
    assignin('base', 'Id_ref', single(0));
    assignin('base', 'Iq_ref', single(0));

    simOut = sim(modelName, 'ReturnWorkspaceOutputs', 'on');
    duty = simOut.get('pmsm_duty_log').signals.values;
    idiq = simOut.get('pmsm_id_iq_log').signals.values;
    motion = simOut.get('pmsm_motion_log').signals.values;
    status = simOut.get('pmsm_status_log').signals.values;

    gateMax = max(status(:, 1));
    faultMax = max(status(:, 2));
    sensorFaultMax = max(status(:, 3));
    iqAbsMax = max(abs(idiq(:, 2)));
    rpmFinal = motion(end, 3);
    dutyMin = min(duty(:));
    dutyMax = max(duty(:));

    passGate = (testCfg.expectGate == 0 && gateMax == 0) || (testCfg.expectGate == 1 && gateMax > 0);
    passFault = faultMax == 0 && sensorFaultMax == 0;
    passDuty = dutyMin >= 0 && dutyMax <= 1;
    passIq = true;
    if testCfg.expectGate == 1
        passIq = iqAbsMax > 0.5;
    end

    results(k).name = testCfg.name; %#ok<AGROW>
    results(k).gateMax = gateMax;
    results(k).faultMax = faultMax;
    results(k).sensorFaultMax = sensorFaultMax;
    results(k).iqAbsMax = iqAbsMax;
    results(k).rpmFinal = rpmFinal;
    results(k).dutyMin = dutyMin;
    results(k).dutyMax = dutyMax;
    results(k).pass = passGate && passFault && passDuty && passIq;
end

% Speed-mode risk test: conservative gains and low speed command.
assignin('base', 'Speed_Kp', set_param_value(evalin('base','Speed_Kp'), single(0.05)));
assignin('base', 'Speed_Ki', set_param_value(evalin('base','Speed_Ki'), single(0.05 / 0.03)));
assignin('base', 'Speed_Iq_limit', set_param_value(evalin('base','Speed_Iq_limit'), single(10)));
assignin('base', 'ctrl_mode', uint8(1));
assignin('base', 'speed_ref', single(10));
assignin('base', 'Id_ref', single(0));
assignin('base', 'Iq_ref', single(0));
set_param([modelName '/StartStep'], 'Time', '0.005', 'Before', '0', 'After', '1');
set_param([modelName '/IqRefStep'], 'Time', '0.005', 'Before', '0', 'After', '0');
simOut = sim(modelName, 'ReturnWorkspaceOutputs', 'on');
status = simOut.get('pmsm_status_log').signals.values;
idiq = simOut.get('pmsm_id_iq_log').signals.values;
motion = simOut.get('pmsm_motion_log').signals.values;

gateMax = max(status(:, 1));
faultMax = max(status(:, 2));
sensorFaultMax = max(status(:, 3));
iqPeak = max(abs(idiq(:, 2)));
rpmFinal = motion(end, 3);
speedModePass = (gateMax > 0) && (faultMax == 0) && (sensorFaultMax == 0) && (iqPeak <= 12);

speedModeResult = struct();
speedModeResult.name = 'SpeedModeLowRefConservativeGains';
speedModeResult.pass = speedModePass;
speedModeResult.gateMax = gateMax;
speedModeResult.faultMax = faultMax;
speedModeResult.sensorFaultMax = sensorFaultMax;
speedModeResult.iqPeak = iqPeak;
speedModeResult.rpmFinal = rpmFinal;

disp('PMSM control sanity check summary:');
allPass = true;
for k = 1:numel(results)
    r = results(k);
    fprintf('%s pass=%d gate_max=%g fault_max=%g sensor_fault_max=%g iq_abs_max=%g rpm_final=%g duty=[%g,%g]\n', ...
        r.name, r.pass, r.gateMax, r.faultMax, r.sensorFaultMax, r.iqAbsMax, r.rpmFinal, r.dutyMin, r.dutyMax);
    allPass = allPass && r.pass;
end

fprintf('%s pass=%d gate_max=%g fault_max=%g sensor_fault_max=%g iq_peak=%g rpm_final=%g\n', ...
    speedModeResult.name, speedModeResult.pass, speedModeResult.gateMax, ...
    speedModeResult.faultMax, speedModeResult.sensorFaultMax, speedModeResult.iqPeak, speedModeResult.rpmFinal);
allPass = allPass && speedModeResult.pass;

% Direction consistency diagnostic only for current mode tests.
if numel(results) >= 3
    iqPlusRpm = results(2).rpmFinal;
    iqMinusRpm = results(3).rpmFinal;
    if sign(iqPlusRpm) == sign(iqMinusRpm) && (abs(iqPlusRpm) > 0.5 || abs(iqMinusRpm) > 0.5)
        fprintf('PMSM_DIRECTION_NOTE: +Iq and -Iq produced the same short-window rpm sign. Use run_pmsm_torque_probe for a longer signed check.\n');
    end
end

if ~allPass
    error('PMSM_CONTROL_SANITY_CHECK_FAILED');
end

disp('PMSM_CONTROL_SANITY_CHECK_OK');
end

function restore_model(modelName, orig)
try
    set_param(modelName, 'StopTime', orig.StopTime);
    set_param(modelName, 'Solver', orig.Solver);
    set_param(modelName, 'FixedStep', orig.FixedStep);
    set_param([modelName '/StartStep'], 'Time', orig.StartTime, 'Before', orig.StartBefore, 'After', orig.StartAfter);
    set_param([modelName '/IqRefStep'], 'Time', orig.IqTime, 'Before', orig.IqBefore, 'After', orig.IqAfter);
    assignin('base', 'ctrl_mode', orig.ctrl_mode);
    assignin('base', 'speed_ref', orig.speed_ref);
    assignin('base', 'Iq_ref', orig.Iq_ref);
    assignin('base', 'Id_ref', orig.Id_ref);
    assignin('base', 'Speed_Kp', set_param_value(evalin('base','Speed_Kp'), orig.Speed_Kp));
    assignin('base', 'Speed_Ki', set_param_value(evalin('base','Speed_Ki'), orig.Speed_Ki));
    assignin('base', 'Speed_Iq_limit', set_param_value(evalin('base','Speed_Iq_limit'), orig.Speed_Iq_limit));
catch
end
try
    close_system(modelName, 0);
catch
end
end

function safe_delete_if_exists(parentPath, blockName)
if ~isempty(find_system(parentPath, 'SearchDepth', 1, 'Name', blockName))
    delete_block([parentPath '/' blockName]);
end
end

function p = set_param_value(p, value)
p.Value = value;
end
