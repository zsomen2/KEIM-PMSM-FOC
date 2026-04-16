clear;

%load plant_data_types.mat

PlantVariant = 13;  % 10: RLUb_SimPower
                    % 11: RLUb_CT (Continous-time Simulink model)
                    % 12: RLUb_DT (Discrete-time Simulink model)
                    % 13: RLUb_DT (Discrete-time fixed-point Simulink model)
                                
R = 0.1;
L = 500e-6;

Udc = 100;
Ub = 50;

fsw = 10e3;
Deadtime = 0e-6;

% Current Control
SampleMode = 1;     % 0: Sampling at the lower triangular peak
                    % 1: Sampling at both triangular peaks
                   
if (SampleMode == 1),
    Ts = 1/fsw/2;
    Td = 2*Ts;
else
    Ts = 1/fsw;
    Td = 2*Ts;   
end;

phim = pi/3;                % phase margin
phi0 = pi/2 - phim;
wc = (2/3)*phi0/Td;         % cut-off frequency
TI = 1/wc/tan(phi0/3);      % Integral time constant 
A_P = Simulink.Parameter(single(wc*L));                 % Proportional gain
A_P.CoderInfo.StorageClass = 'ExportedGlobal';
A_I = Simulink.Parameter(single(A_P.Value*Ts/TI));            % Integral gain
A_I.CoderInfo.StorageClass = 'ExportedGlobal';

Uout0 = Ub;                 % Initial control output voltage
D0 = Uout0/Udc;             % Initial duty ratio

%% HIL
dt = 50e-9;  
U_FS = Udc/0.8;
I_FS = 50/0.8;
vbits = 25;
cbits = 18;
tmp = sfi(2*U_FS,vbits);
Utype = tmp.numerictype;
tmp = sfi(2*I_FS,vbits);
Itype = tmp.numerictype;

%% DSP
RLUb_data_types;

delay = Simulink.Parameter(uint16(0));
delay.CoderInfo.StorageClass = 'ExportedGlobal';

AnalogChA_ini = struct;
AnalogChA_ini.value = single([0 0 0]);
AnalogChA_ini.gain = single([2*I_FS U_FS U_FS]/4096);
AnalogChA_ini.offset = single([I_FS 0 0]);
AnalogChA_ini.comp = single([0 0 0]);

fcpu = 80e6;
TBPER = fcpu/fsw/2;
TBPER2 = fcpu/(2*fsw)-1;
RED = Deadtime*fcpu;
FED = Deadtime*fcpu;

Start = Simulink.Parameter(boolean(0));
Start.CoderInfo.StorageClass = 'ExportedGlobal';
Iref = Simulink.Parameter(single(0));
Iref.CoderInfo.StorageClass = 'ExportedGlobal';



