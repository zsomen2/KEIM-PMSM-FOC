function run_pmsm_mechanical_validation()
modelName = 'pmsm_control';
plantPath = [modelName '/Plant'];
selName = [plantPath '/MechValidationSelect'];
tauLogName = [plantPath '/MechValidationLogTau'];
wmLogName = [plantPath '/MechValidationLogWm'];
wLogName = [plantPath '/MechValidationLogW'];
rpmLogName = [plantPath '/MechValidationLogRpm'];
thetaLogName = [plantPath '/MechValidationLogTheta'];
tauVar = 'mech_tau_log';
wmVar = 'mech_wm_log';
wVar = 'mech_w_log';
rpmVar = 'mech_rpm_log';
thetaVar = 'mech_theta_log';

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

cleanupObj = onCleanup(@() restore_and_cleanup(modelName, orig, selName, ...
    tauLogName, wmLogName, wLogName, rpmLogName, thetaLogName)); %#ok<NASGU>

safe_delete_if_exists(plantPath, 'MechValidationLog');
safe_delete_if_exists(plantPath, 'MechValidationMux');
safe_delete_if_exists(plantPath, 'MechValidationLogTau');
safe_delete_if_exists(plantPath, 'MechValidationLogWm');
safe_delete_if_exists(plantPath, 'MechValidationLogW');
safe_delete_if_exists(plantPath, 'MechValidationLogRpm');
safe_delete_if_exists(plantPath, 'MechValidationLogTheta');
safe_delete_if_exists(plantPath, 'MechValidationSelect');

add_block('simulink/Signal Routing/Bus Selector', selName, ...
    'OutputSignals', 'tau,wm,w,rpm,theta', ...
    'Position', [540 250 640 355]);
add_block('simulink/Sinks/To Workspace', tauLogName, ...
    'VariableName', tauVar, ...
    'SaveFormat', 'Structure With Time', ...
    'Position', [710 250 830 280]);
add_block('simulink/Sinks/To Workspace', wmLogName, ...
    'VariableName', wmVar, ...
    'SaveFormat', 'Structure With Time', ...
    'Position', [710 285 830 315]);
add_block('simulink/Sinks/To Workspace', wLogName, ...
    'VariableName', wVar, ...
    'SaveFormat', 'Structure With Time', ...
    'Position', [710 320 830 350]);
add_block('simulink/Sinks/To Workspace', rpmLogName, ...
    'VariableName', rpmVar, ...
    'SaveFormat', 'Structure With Time', ...
    'Position', [710 355 830 385]);
add_block('simulink/Sinks/To Workspace', thetaLogName, ...
    'VariableName', thetaVar, ...
    'SaveFormat', 'Structure With Time', ...
    'Position', [710 390 830 420]);

add_line(plantPath, 'Plant_PMSM_HIL/1', 'MechValidationSelect/1', 'autorouting', 'on');
add_line(plantPath, 'MechValidationSelect/1', 'MechValidationLogTau/1', 'autorouting', 'on');
add_line(plantPath, 'MechValidationSelect/2', 'MechValidationLogWm/1', 'autorouting', 'on');
add_line(plantPath, 'MechValidationSelect/3', 'MechValidationLogW/1', 'autorouting', 'on');
add_line(plantPath, 'MechValidationSelect/4', 'MechValidationLogRpm/1', 'autorouting', 'on');
add_line(plantPath, 'MechValidationSelect/5', 'MechValidationLogTheta/1', 'autorouting', 'on');

set_param(modelName, 'Solver', 'FixedStepDiscrete');
set_param(modelName, 'FixedStep', 'dt_plant_sim');
set_param(modelName, 'StopTime', '0.2');
set_param([modelName '/StartStep'], 'Time', '0.005', 'Before', '0', 'After', '1');
set_param([modelName '/IqRefStep'], 'Time', '0.005', 'Before', '0', 'After', '20');

simOut = sim(modelName, 'ReturnWorkspaceOutputs', 'on');
tau = get_logged_values(simOut, tauVar);
wm = get_logged_values(simOut, wmVar);
w = get_logged_values(simOut, wVar);
rpm = get_logged_values(simOut, rpmVar);
theta = get_logged_values(simOut, thetaVar);

tauAbsMax = max(abs(tau));
wmAbsMax = max(abs(wm));
wAbsMax = max(abs(w));
rpmAbsMax = max(abs(rpm));
thetaAbsMax = max(abs(theta));

disp('PMSM mechanical validation summary:');
fprintf('tau_abs_max=%g wm_abs_max=%g w_abs_max=%g rpm_abs_max=%g theta_abs_max=%g\n', ...
    tauAbsMax, wmAbsMax, wAbsMax, rpmAbsMax, thetaAbsMax);

torqueGenerated = tauAbsMax > 1e-3;
motionDetected = (wmAbsMax > 1e-6) || (wAbsMax > 1e-6) || (rpmAbsMax > 1e-6) || (thetaAbsMax > 1e-6);
lockedRotor = ~motionDetected;

fprintf('torque_generated=%d motion_detected=%d\n', torqueGenerated, motionDetected);

if ~torqueGenerated
    error('PMSM_MECH_VALIDATION_NO_TORQUE');
end

if lockedRotor
    disp('PMSM_MECH_VALIDATION_LOCKED_ROTOR (torque exists, speed/theta remained zero)');
    return;
end

disp('PMSM_MECH_VALIDATION_OK');
end

function restore_and_cleanup(modelName, orig, selName, tauLogName, wmLogName, wLogName, rpmLogName, thetaLogName)
try
    set_param(modelName, 'StopTime', orig.StopTime);
    set_param(modelName, 'Solver', orig.Solver);
    set_param(modelName, 'FixedStep', orig.FixedStep);
    set_param([modelName '/StartStep'], 'Time', orig.StartTime, 'Before', orig.StartBefore, 'After', orig.StartAfter);
    set_param([modelName '/IqRefStep'], 'Time', orig.IqTime, 'Before', orig.IqBefore, 'After', orig.IqAfter);
catch
end
try
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationLog');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationMux');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogTau');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogWm');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogW');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogRpm');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationLogTheta');
    safe_delete_if_exists([modelName '/Plant'], 'MechValidationSelect');
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

function values = get_logged_values(simOut, varName)
sig = simOut.get(varName);
if isstruct(sig) && isfield(sig, 'signals') && isfield(sig.signals, 'values')
    values = double(sig.signals.values(:));
    return;
end
error('PMSM_MECH_VALIDATION_LOG_MISSING: %s', varName);
end
