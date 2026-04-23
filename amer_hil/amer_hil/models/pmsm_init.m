clear;

dt = 50e-9;          % FPGA/HIL plant simulation sample time.

Udc = 300;           % Nominal DC-link voltage.
Imax = 300;          % Maximum phase current used for limits and scaling.
tau_max = 150;       % Maximum torque limit.


R = 18e-3;           % Stator phase resistance.
Ld = 0.37e-3;        % Direct-axis inductance.
Lq = 1.2e-3;         % Quadrature-axis inductance.
L = [Ld Lq];         % Vector containing d-axis and q-axis inductances.
Psi_PM = 66e-3;      % Permanent magnet flux linkage.

pp = 3;              % Number of motor pole pairs.

Tst = 0.25;          % Acceleration time used for inertia estimation.
Tau = 150;           % Torque used for inertia estimation.
W = 250;             % Mechanical angular speed used for inertia estimation.

J = Tst*Tau/W;       % Estimated rotor inertia.


UmaxFX = 600;        % Fixed-point full-scale voltage limit.
ImaxFX = 600;        % Fixed-point full-scale current limit.
WmaxFX = 1500*pp;    % Fixed-point full-scale electrical angular speed limit.
PsimaxFX = 2*abs(Psi_PM + Ld*Imax + j*Lq*Imax);                         % Fixed-point full-scale stator flux estimate.
TaumaxFX = (3/2)*pp*real(j*(Psi_PM + Ld*Imax + j*Lq*Imax)*Imax*(-1+j));  % Fixed-point full-scale torque estimate.

vbits = 25;          % Fixed-point word length for voltage-like signals.
cbits = 18;          % Fixed-point word length for current/control signals.

IabcFS = 300;        % Full-scale value for phase current measurements.
wFS = WmaxFX;        % Full-scale value for speed measurement and scaling.
UdcFS = 1000;        % Full-scale value for DC-link voltage measurement.

RPMmax = 60*1500/2/pi;  % Maximum RPM value used by monitor/display scaling.
RPMresolution = 1024;   % RPM quantization resolution used by monitor/display scaling.

