function open_rlub_hil_harness()
%OPEN_RLUB_HIL_HARNESS Open the embedded RLUb_HIL harness for HDL generation.
%
% The RLUb_HIL HDL top is not a separate .slx file in this project. It is an
% embedded Simulink harness owned by:
%   RLUb/Plant/RLUb_DTFX/RLUb_DTFX

projectRoot = fileparts(mfilename('fullpath'));
cd(projectRoot);

% The original workflow expects Q: to point at this folder.
[~, substOut] = system('subst');
if isempty(strfind(upper(substOut), 'Q:\:')) && isempty(strfind(upper(substOut), 'Q:\'))
    system('qra.bat');
end

if exist('Q:\', 'dir')
    cd('Q:\');
end

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

RLUb_init;
xilinxpath;

load_system('RLUb');

owner = 'RLUb/Plant/RLUb_DTFX/RLUb_DTFX';
harnessName = 'RLUb_HIL';

fprintf('\nEmbedded harnesses in RLUb:\n');
try
    disp(Simulink.harness.find('RLUb'));
catch findErr
    warning('Could not list harnesses: %s', findErr.message);
end

try
    Simulink.harness.open(owner, harnessName);
catch firstErr
    try
        Simulink.harness.open(owner, 'Name', harnessName);
    catch secondErr
        fprintf('\nFirst open attempt failed:\n%s\n', firstErr.message);
        fprintf('\nSecond open attempt failed:\n%s\n', secondErr.message);
        error('Could not open the embedded RLUb_HIL harness.');
    end
end

% After opening, gcs should be inside the harness model.
harnessModel = bdroot(gcs);
fprintf('\nOpened harness model: %s\n', harnessModel);

try
    hdladvisor(harnessModel);
catch advisorErr
    warning('Harness opened, but HDL Workflow Advisor did not start: %s', advisorErr.message);
    fprintf('Start it manually from the Simulink window: Code -> HDL Code -> HDL Workflow Advisor.\n');
end
end
