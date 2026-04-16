clear;

dt = 50e-9;

Udc = 300;
Imax = 300;
tau_max = 150;


R = 18e-3;
Ld = 0.37e-3;
Lq = 1.2e-3;
L = [Ld Lq];
Psi_PM = 66e-3;

pp = 3;

Tst = 0.25;
Tau = 150;
W = 250;

J = Tst*Tau/W;


UmaxFX = 600;
ImaxFX = 600;
WmaxFX = 1500*pp;
PsimaxFX = 2*abs(Psi_PM + Ld*Imax + j*Lq*Imax);
TaumaxFX = (3/2)*pp*real(j*(Psi_PM + Ld*Imax + j*Lq*Imax)*Imax*(-1+j));

vbits = 25;
cbits = 18;

IabcFS = 300;
wFS = WmaxFX;
UdcFS = 1000;

RPMmax = 60*1500/2/pi;
RPMresolution = 1024;

