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
    struct('name', 'StartOnIq5', 'startAfter', '1', 'iqAfter', '5', 'expectGate', 1) ...
};

results = struct([]);

for k = 1:numel(tests)
    testCfg = tests{k};
    set_param([modelName '/StartStep'], 'Time', '0.005', 'Before', '0', 'After', testCfg.startAfter);
    set_param([modelName '/IqRefStep'], 'Time', '0.005', 'Before', '0', 'After', testCfg.iqAfter);

    simOut = sim(modelName, 'ReturnWorkspaceOutputs', 'on');
    duty = simOut.get('pmsm_duty_log').signals.values;
    idiq = simOut.get('pmsm_id_iq_log').signals.values;
    status = simOut.get('pmsm_status_log').signals.values;

    gateMax = max(status(:, 1));
    faultMax = max(status(:, 2));
    sensorFaultMax = max(status(:, 3));
    iqAbsMax = max(abs(idiq(:, 2)));
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
    results(k).dutyMin = dutyMin;
    results(k).dutyMax = dutyMax;
    results(k).pass = passGate && passFault && passDuty && passIq;
end

disp('PMSM control sanity check summary:');
allPass = true;
for k = 1:numel(results)
    r = results(k);
    fprintf('%s pass=%d gate_max=%g fault_max=%g sensor_fault_max=%g iq_abs_max=%g duty=[%g,%g]\n', ...
        r.name, r.pass, r.gateMax, r.faultMax, r.sensorFaultMax, r.iqAbsMax, r.dutyMin, r.dutyMax);
    allPass = allPass && r.pass;
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
