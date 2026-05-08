function open_pmsm_hil_harness()
%OPEN_PMSM_HIL_HARNESS Open the embedded PMSM FPGA harness and start HDL Workflow Advisor.

projectRoot = fileparts(mfilename('fullpath'));
cd(projectRoot);

addpath(genpath('plugins'));
addpath(genpath('ipcores'));
addpath(genpath('utilities'));
addpath('models');
addpath('data');

if exist('Simulink.harness.find', 'file') == 0
    harnessApiPath = fullfile(matlabroot, 'toolbox', 'simulinktest', ...
        'core', 'simharness', 'simharness');
    if exist(harnessApiPath, 'dir')
        addpath(harnessApiPath);
    end
end

rehash toolboxcache;
if exist('sl_refresh_customizations', 'file') == 2
    sl_refresh_customizations;
elseif exist('Advisor.Manager.refresh_customizations', 'file') == 2
    Advisor.Manager.refresh_customizations;
end

if exist('xilinxpath', 'file') == 2
    xilinxpath;
end

pmsm_control_init;
load_system('pmsm_control');

owner = 'pmsm_control/Plant/Plant_PMSM_HIL';
harnessName = 'pmsm_FPGA_HIL';

try
    Simulink.harness.open(owner, harnessName);
catch firstErr
    try
        Simulink.harness.open(owner, 'Name', harnessName);
    catch secondErr
        fprintf('\nFirst open attempt failed:\n%s\n', firstErr.message);
        fprintf('\nSecond open attempt failed:\n%s\n', secondErr.message);
        error('Could not open the embedded pmsm_FPGA_HIL harness.');
    end
end

harnessModel = bdroot(gcs);
fprintf('\nOpened harness model: %s\n', harnessModel);

set_param(harnessModel, 'SimulationCommand', 'update');

try
    hdladvisor(hdlget_param(harnessModel, 'HDLSubsystem'));
catch advisorErr
    warning('Harness opened, but HDL Workflow Advisor did not start: %s', advisorErr.message);
    fprintf('Start it manually from the Simulink window: Code -> HDL Code -> HDL Workflow Advisor.\n');
end
end
