clear;

scriptDir = fileparts(mfilename('fullpath'));
projectRoot = fileparts(scriptDir);
addpath(scriptDir);
addpath(fullfile(projectRoot, 'data'));
addpath(genpath(fullfile(projectRoot, 'plugins')));
addpath(genpath(fullfile(projectRoot, 'utilities')));
addpath(genpath(fullfile(projectRoot, 'ipcores')));

rehash toolboxcache;
if exist('sl_refresh_customizations', 'file') == 2
    sl_refresh_customizations;
elseif exist('Advisor.Manager.refresh_customizations', 'file') == 2
    Advisor.Manager.refresh_customizations;
end

if exist('xilinxpath', 'file') == 2
    xilinxpath;
end

% PMSM plant and fixed-point scaling parameters.
pmsm_init;

% Legacy DSP hardware buses plus PMSM controller buses.
RLUb_data_types;
pmsm_data_types;

% Controller timing.
PlantVariant = 13;
% Keeps the legacy top-level plant variant resolvable.
L = Ld;
% Legacy RLUb plant blocks expect scalar L.
Ub = Udc / 2;
% Legacy half-bridge plant bias voltage.
Uout0 = Ub;
% Legacy PWM initial output voltage.
D0 = Uout0 / Udc;
% Legacy PWM initial duty ratio.
U_FS = Udc / 0.8;
% Legacy fixed-point voltage full scale.
I_FS = IabcFS / 0.8;
% Legacy fixed-point current full scale.
tmp = sfi(2 * U_FS, vbits);
Utype = tmp.numerictype;
tmp = sfi(2 * I_FS, vbits);
Itype = tmp.numerictype;

fsw = 10e3;
% PWM switching frequency.
SampleMode = 1;
% 1 : sample at both triangular carrier peaks.
dt_plant_sim = dt;
% Plant simulation step used by the controller testbench copy of the HIL plant.
Ts_pwm = 1 / fsw / 20;
% PWM carrier sample time used by the top-level gate adapter.
pwm_carrier_steps = 20;
% Number of discrete steps in one PWM carrier period.

if SampleMode == 1
    Ts = 1 / fsw / 2;
% Current controller sample time.
else
    Ts = 1 / fsw;
end
Ts_current = Ts;
% Fast FOC update period.
Ts_speed = 1e-3;
% Runtime speed loop period on the legacy 1 ms task.

Td = 2 * Ts;                  % Effective loop delay used for PI design.

% Current-loop PI design, matching the course RLUb tuning style.
phim = pi/3;
% Desired phase margin.
phi0 = pi / 2 - phim;         % Remaining phase for controller design.
wc = (2/3)*phi0/Td;
% Current-loop crossover frequency.
TI = 1 / (wc * tan(phi0 / 3));
% Current-loop integral time constant.

Id_Kp = Simulink.Parameter(single(wc * Ld));
Id_Kp.CoderInfo.StorageClass = 'ExportedGlobal';
% The inner current-loop integrators are implemented as fixed-step discrete
% accumulators inside the PWM interrupt, so Ki includes Ts_current.
Id_Ki = Simulink.Parameter(single((Id_Kp.Value / TI) * Ts_current));
Id_Ki.CoderInfo.StorageClass = 'ExportedGlobal';

Iq_Kp = Simulink.Parameter(single(wc * Lq));
Iq_Kp.CoderInfo.StorageClass = 'ExportedGlobal';
Iq_Ki = Simulink.Parameter(single((Iq_Kp.Value / TI) * Ts_current));
Iq_Ki.CoderInfo.StorageClass = 'ExportedGlobal';

% Outer speed-loop PI design. The speed loop outputs the q-axis current
% reference used by the inner FOC current loop when ctrl_mode == 1.
Speed_Kp = Simulink.Parameter(single(0.4));
% A / rpm 
Speed_Kp.CoderInfo.StorageClass = 'ExportedGlobal';
Speed_Ki = Simulink.Parameter(single(Speed_Kp.Value / 0.03));
Speed_Ki.CoderInfo.StorageClass = 'ExportedGlobal';
Speed_Iq_limit = Simulink.Parameter(single(40));
Speed_Iq_limit.CoderInfo.StorageClass = 'ExportedGlobal';

% PWM and C2000 timing.
fcpu = 80e6;
% C2000 CPU clock used by the original skeleton.
Deadtime = 0e-6;
% Deadtime in seconds.
TBPER = fcpu / fsw / 2;
TBPER2 = fcpu / (2 * fsw) - 1;
RED = Deadtime * fcpu;
FED = Deadtime * fcpu;

% Runtime commands exported for HiTerm/CCS monitoring.
Start = Simulink.Parameter(boolean(0));
Start.CoderInfo.StorageClass = 'ExportedGlobal';
Id_ref = Simulink.Parameter(single(0));
Id_ref.CoderInfo.StorageClass = 'ExportedGlobal';
Iq_ref = Simulink.Parameter(single(0));
Iq_ref.CoderInfo.StorageClass = 'ExportedGlobal';
Iref = Simulink.Parameter(single(0));
Iref.CoderInfo.StorageClass = 'ExportedGlobal';
speed_ref = Simulink.Parameter(single(0));
speed_ref.CoderInfo.StorageClass = 'ExportedGlobal';
ctrl_mode = Simulink.Parameter(uint8(0));
ctrl_mode.CoderInfo.StorageClass = 'ExportedGlobal';
fault_reset = Simulink.Parameter(boolean(0));
fault_reset.CoderInfo.StorageClass = 'ExportedGlobal';

% Diagnostics controlled from MATLAB scripts only.
% theta_sign = +1 keeps the existing encoder polarity.
% theta_offset = electrical angle offset added after encoder scaling/sign.
% phase_swap_bc = true swaps phase B/C routing in the harness for checks.
% open_loop_mode = true forces a fixed q-axis current command for a motor response test.
theta_sign = Simulink.Parameter(int8(-1));
theta_sign.CoderInfo.StorageClass = 'ExportedGlobal';
theta_offset = Simulink.Parameter(single(0));
theta_offset.CoderInfo.StorageClass = 'ExportedGlobal';
phase_swap_bc = Simulink.Parameter(boolean(0));
phase_swap_bc.CoderInfo.StorageClass = 'ExportedGlobal';
open_loop_mode = Simulink.Parameter(boolean(0));
open_loop_mode.CoderInfo.StorageClass = 'ExportedGlobal';
open_loop_iq_ref = Simulink.Parameter(single(5));
open_loop_iq_ref.CoderInfo.StorageClass = 'ExportedGlobal';

% Protection and modulation limits.
I_limit = Simulink.Parameter(single(Imax));
I_limit.CoderInfo.StorageClass = 'ExportedGlobal';
Udc_min = Simulink.Parameter(single(20));
Udc_min.CoderInfo.StorageClass = 'ExportedGlobal';
modulation_limit = Simulink.Parameter(single(0.577350269189626));
modulation_limit.CoderInfo.StorageClass = 'ExportedGlobal';

% PWM adapter defaults.
PWM_it_period = Simulink.Parameter(2);
PWM_it_period.CoderInfo.StorageClass = 'ExportedGlobal';
D_safe = Simulink.Parameter(single(D0));
D_safe.CoderInfo.StorageClass = 'ExportedGlobal';

FOCConfig = struct;
FOCConfig.pp = single(pp);
FOCConfig.Ts = single(Ts_current);
FOCConfig.Ts_speed = single(Ts_speed);
FOCConfig.Id_Kp = single(Id_Kp.Value);
FOCConfig.Id_Ki = single(Id_Ki.Value);
FOCConfig.Iq_Kp = single(Iq_Kp.Value);
FOCConfig.Iq_Ki = single(Iq_Ki.Value);
FOCConfig.Speed_Kp = single(Speed_Kp.Value);
FOCConfig.Speed_Ki = single(Speed_Ki.Value);
FOCConfig.Speed_Iq_limit = single(Speed_Iq_limit.Value);
FOCConfig.I_limit = single(I_limit.Value);
FOCConfig.Udc_min = single(Udc_min.Value);
FOCConfig.modulation_limit = single(modulation_limit.Value);

% ADC scaling for the existing three-channel C2000 skeleton.
% The controller harness uses the three ADC inputs as phase current sensors.
AnalogChA_ini = struct;
AnalogChA_ini.value = single([0 0 0]);
AnalogChA_ini.gain = single([2 * IabcFS 2 * IabcFS 2 * IabcFS] / 4096);
% Per-channel current-sensor zero-current offsets identified from the
% measured idle ADC averages on hardware (ADC ~= [1884 1864 1865]).
AnalogChA_ini.offset = single([275.9765625 273.046875 273.193359375]);
AnalogChA_ini.comp = single([0 0 0]);

% Compatibility variable used by existing C2000 scheduling blocks.
% EPwm5 triggers the ADC on CMPA-up; keeping it at zero samples close to the
% PWM edge and produces large current spikes on the HIL analog frontend.
% Sampling near the middle of the 20 kHz ADC trigger period is the stable
% default for the sigma-delta / analog mux chain.
delay = Simulink.Parameter(uint16((TBPER2 + 1) / 2));
delay.CoderInfo.StorageClass = 'ExportedGlobal';
