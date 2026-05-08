function run_pmsm_controller_diagnostics(thetaSign, swapPhaseBC, openLoopIqRef)
%RUN_PMSM_CONTROLLER_DIAGNOSTICS Apply the model-side motor response diagnostics.
%
% This helper keeps the changes on the MATLAB side:
% - open-loop direct q-axis current injection
% - encoder polarity flip for theta
% - optional B/C phase swap in the controller harness

if nargin < 1 || isempty(thetaSign)
    thetaSign = int8(1);
end
if nargin < 2 || isempty(swapPhaseBC)
    swapPhaseBC = false;
end
if nargin < 3 || isempty(openLoopIqRef)
    openLoopIqRef = single(5);
end

scriptDir = fileparts(mfilename('fullpath'));
cd(scriptDir);

theta_sign.Value = int8(thetaSign);
phase_swap_bc.Value = logical(swapPhaseBC);
open_loop_mode.Value = true;
open_loop_iq_ref.Value = single(openLoopIqRef);

apply_pmsm_controller_matlab_fix;
run_pmsm_harness_sensor_alignment_check;

disp('PMSM_CONTROLLER_DIAGNOSTICS_OK');
end
