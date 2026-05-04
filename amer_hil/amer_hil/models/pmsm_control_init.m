clear;

scriptDir = fileparts(mfilename('fullpath'));
projectRoot = fileparts(scriptDir);
addpath(scriptDir);
addpath(fullfile(projectRoot, 'data'));

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
Id_Ki = Simulink.Parameter(single(Id_Kp.Value * Ts / TI));
Id_Ki.CoderInfo.StorageClass = 'ExportedGlobal';

Iq_Kp = Simulink.Parameter(single(wc * Lq));
Iq_Kp.CoderInfo.StorageClass = 'ExportedGlobal';
Iq_Ki = Simulink.Parameter(single(Iq_Kp.Value * Ts / TI));
Iq_Ki.CoderInfo.StorageClass = 'ExportedGlobal';

% Outer speed-loop PI design. The speed loop outputs the q-axis current
% reference used by the inner FOC current loop when ctrl_mode == 1.
Speed_Kp = Simulink.Parameter(single(0.6));
% A / rpm 
Speed_Kp.CoderInfo.StorageClass = 'ExportedGlobal';
Speed_Ki = Simulink.Parameter(single(Speed_Kp.Value * Ts / 0.03));
Speed_Ki.CoderInfo.StorageClass = 'ExportedGlobal';
Speed_Iq_limit = Simulink.Parameter(single(50));
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

% Protection and modulation limits.
I_limit = Simulink.Parameter(single(Imax));
I_limit.CoderInfo.StorageClass = 'ExportedGlobal';
Udc_min = Simulink.Parameter(single(20));
Udc_min.CoderInfo.StorageClass = 'ExportedGlobal';
modulation_limit = Simulink.Parameter(single(0.577350269189626));
modulation_limit.CoderInfo.StorageClass = 'ExportedGlobal';

FOCConfig = struct;
FOCConfig.pp = single(pp);
FOCConfig.Ts = single(Ts);
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
AnalogChA_ini = struct;
AnalogChA_ini.value = single([0 0 0]);
AnalogChA_ini.gain = single([UdcFS UdcFS 2 * IabcFS] / 4096);
AnalogChA_ini.offset = single([0 0 IabcFS]);
AnalogChA_ini.comp = single([0 0 0]);

% Compatibility variable used by existing C2000 scheduling blocks.
delay = Simulink.Parameter(uint16(0));
delay.CoderInfo.StorageClass = 'ExportedGlobal';
