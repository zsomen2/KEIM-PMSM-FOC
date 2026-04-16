#include "inic.h"
#include "CPLDHandler.h"

volatile struct SCI_REGS *sci_ptr_terminal;

//--------------------------------------------------------------------
//  Configure Device for target Application Here
//--------------------------------------------------------------------

void DeviceInit(void)
{
  EALLOW;
  //--------------------------------------------------------------------------------------
  //  GPIO-00 - PIN FUNCTION = --GPIO Output EPWM1A--  // !!! felesleges
//  GpioCtrlRegs.GPAMUX1.bit.GPIO0 = 0;     // 0=GPIO, 1=EPWM1A, 2=Reserved, 3=Reserved
//  GpioCtrlRegs.GPADIR.bit.GPIO0 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO0 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO0 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-01 - PIN FUNCTION = --GPIO Output EPWM1A--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO1 = 0;     // 0=GPIO, 1=EPWM1B, 2=Reserved, 3=COMP1OUT
//  GpioCtrlRegs.GPADIR.bit.GPIO1 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO1 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO1 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-02 - PIN FUNCTION = --GPIO Output EPWM2A--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO2 = 0;     // 0=GPIO, 1=EPWM2A, 2=Reserved, 3=Reserved
//  GpioCtrlRegs.GPADIR.bit.GPIO2 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO2 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO2 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-03 - PIN FUNCTION = --GPIO Output EPWM2B--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO3 = 0;     // 0=GPIO, 1=EPWM2B, 2=SPISOMIA, 3=COMP2OUT
//  GpioCtrlRegs.GPADIR.bit.GPIO3 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO3 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO3 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-04 - PIN FUNCTION = --GPIO Output EPWM3A--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO4 = 0;     // 0=GPIO, 1=EPWM3A, 2=Reserved, 3=Reserved
//  GpioCtrlRegs.GPADIR.bit.GPIO4 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO4 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO4 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-05 - PIN FUNCTION = --GPIO Output EPWM3B--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO5 = 0;     // 0=GPIO, 1=EPWM3B, 2=SPISIMOA, 3=ECAP1
//  GpioCtrlRegs.GPADIR.bit.GPIO5 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO5 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO5 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-06 - PIN FUNCTION = --GPIO Output EPWM4A--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO6 = 0;     // 0=GPIO, 1=EPWM4A, 2=EPWMSYNCI, 3=EPWMSYNCO
//  GpioCtrlRegs.GPADIR.bit.GPIO6 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO6 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO6 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-07 - PIN FUNCTION = --GPIO Output EPWM4B--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO7 = 0;     // 0=GPIO, 1=EPWM4B, 2=SCIRXDA, 3=ECAP2
//  GpioCtrlRegs.GPADIR.bit.GPIO7 = 1;    // 1=OUTput,  0=INput
//  GpioDataRegs.GPACLEAR.bit.GPIO7 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO7 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-08 - PIN FUNCTION = --Spare--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO8 = 0;     // 0=GPIO, 1=EPWM5A, 2=Reserved, 3=#ADCSOCAO
  //GpioCtrlRegs.GPADIR.bit.GPIO8 = 0;    // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO8 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO8 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-09 - PIN FUNCTION = --Spare--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO9 = 0;     // 0=GPIO, 1=EPWM5B, 2=SCITXDB, 3=ECAP3
  //GpioCtrlRegs.GPADIR.bit.GPIO9 = 0;    // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO9 = 1;  // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO9 = 1;    // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-10 - PIN FUNCTION = --Spare--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO10 = 0;    // 0=GPIO, 1=EPWM6A, 2=Reserved, 3=#ADCSOCBO
  //GpioCtrlRegs.GPADIR.bit.GPIO10 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO10 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO10 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-11 - PIN FUNCTION = --Spare--
//  GpioCtrlRegs.GPAMUX1.bit.GPIO11 = 0;    // 0=GPIO, 1=EPWM6B, 2=SCIRXDB, 3=ECAP1
  //GpioCtrlRegs.GPADIR.bit.GPIO11 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO11 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO11 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-12 - PIN FUNCTION = --GPIO Output SPISIMOB--
  GpioCtrlRegs.GPAMUX1.bit.GPIO12 = 0;    // 0=GPIO, 1=#TZ1, 2=SCITXDA, 3=SPISIMOB
  GpioCtrlRegs.GPADIR.bit.GPIO12 = 1;   // 1=OUTput,  0=INput
  GpioDataRegs.GPACLEAR.bit.GPIO12 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO12 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-13 - PIN FUNCTION = --GPIO Input SPISOMIB--
  GpioCtrlRegs.GPAMUX1.bit.GPIO13 = 0;    // 0=GPIO, 1=#TZ2, 2=Reserved, 3=SPISOMIB
  GpioCtrlRegs.GPADIR.bit.GPIO13 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO13 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO13 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-14 - PIN FUNCTION = --GPIO Output SPICLKB--
  GpioCtrlRegs.GPAMUX1.bit.GPIO14 = 0;    // 0=GPIO, 1=#TZ3, 2=SCITXDB, 3=SPICLKB
  GpioCtrlRegs.GPADIR.bit.GPIO14 = 1;   // 1=OUTput,  0=INput
  GpioDataRegs.GPACLEAR.bit.GPIO14 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO14 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-15 - PIN FUNCTION = --GPIO Output #SPISTEB--
  GpioCtrlRegs.GPAMUX1.bit.GPIO15 = 0;    // 0=GPIO, 1=ECAP2, 2=SCIRXDB, 3=#SPISTEB
  GpioCtrlRegs.GPADIR.bit.GPIO15 = 1;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO15 = 1; // uncomment if --> Set Low initially
  GpioDataRegs.GPASET.bit.GPIO15 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-16 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPAMUX2.bit.GPIO16 = 0;    // 0=GPIO, 1=SPISIMOA, 2=Reserved, 3=#TZ2
  //GpioCtrlRegs.GPADIR.bit.GPIO16 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO16 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO16 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-17 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPAMUX2.bit.GPIO17 = 0;    // 0=GPIO, 1=SPISOMIA, 2=Reserved, 3=#TZ3
  //GpioCtrlRegs.GPADIR.bit.GPIO17 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO17 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO17 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-18 - PIN FUNCTION = --XCLKOUT--
  GpioCtrlRegs.GPAMUX2.bit.GPIO18 = 3;    // 0=GPIO, 1=SPICLKA, 2=SCITXDB, 3=XCLKOUT
  //GpioCtrlRegs.GPADIR.bit.GPIO18 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO18 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO18 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-19 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPAMUX2.bit.GPIO19 = 0;    // 0=GPIO/XCLKIN, 1=#SPISTEA, 2=SCIRXDB, 3=ECAP1
  //GpioCtrlRegs.GPADIR.bit.GPIO19 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO19 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO19 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-20 - PIN FUNCTION = --GPIO Input EQEP1A--
  GpioCtrlRegs.GPAMUX2.bit.GPIO20 = 0;    // 0=GPIO, 1=EQEP1A, 2=MDXA, 3=COMP1OUT
  GpioCtrlRegs.GPADIR.bit.GPIO20 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO20 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO20 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-21 - PIN FUNCTION = --GPIO Input EQEP1B--
  // GpioCtrlRegs.GPAMUX2.bit.GPIO21 = 0;    // 0=GPIO, 1=EQEP1B, 2=MDRA, 3=COMP2OUT
  // GpioCtrlRegs.GPADIR.bit.GPIO21 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO21 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO21 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-22 - PIN FUNCTION = --GPIO Output SCITXDB--
  GpioCtrlRegs.GPAMUX2.bit.GPIO22 = 0;    // 0=GPIO, 1=EQEP1S, 2=MCLKXA, 3=SCITXDB
  GpioCtrlRegs.GPADIR.bit.GPIO22 = 1;   // 1=OUTput,  0=INput
  GpioDataRegs.GPACLEAR.bit.GPIO22 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO22 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-23 - PIN FUNCTION = --GPIO Input SCIRXDB--
  GpioCtrlRegs.GPAMUX2.bit.GPIO23 = 0;    // 0=GPIO, 1=EQEP1I, 2=MFSXA, 3=SCIRXDB
  GpioCtrlRegs.GPADIR.bit.GPIO23 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO23 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO23 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-24 - PIN FUNCTION = --GPIO Input EQEP2A--
//  GpioCtrlRegs.GPAMUX2.bit.GPIO24 = 0;    // 0=GPIO, 1=ECAP1, 2=EQEP2A, 3=SPISIMOB
//  GpioCtrlRegs.GPADIR.bit.GPIO24 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO24 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO24 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-25 - PIN FUNCTION = --GPIO Input EQEP2B--
//  GpioCtrlRegs.GPAMUX2.bit.GPIO25 = 0;    // 0=GPIO, 1=ECAP2, 2=EQEP2B, 3=SPISOMIB
//  GpioCtrlRegs.GPADIR.bit.GPIO25 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO25 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO25 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-26 - PIN FUNCTION = --GPIO Input EQEP2I--
//  GpioCtrlRegs.GPAMUX2.bit.GPIO26 = 0;    // 0=GPIO, 1=ECAP3, 2=EQEP2I, 3=SPICLKB
//  GpioCtrlRegs.GPADIR.bit.GPIO26 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO26 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO26 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-27 - PIN FUNCTION = --Spare--
//  GpioCtrlRegs.GPAMUX2.bit.GPIO27 = 0;    // 0=GPIO, 1=HRCAP2, 2=EQEP2S, 3=#SPISTEB
  //GpioCtrlRegs.GPADIR.bit.GPIO27 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO27 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO27 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-28 - PIN FUNCTION = --SCIRXDA--
  GpioCtrlRegs.GPAMUX2.bit.GPIO28 = 1;    // 0=GPIO, 1=SCIRXDA, 2=SDAA, 3=#TZ2
  //GpioCtrlRegs.GPADIR.bit.GPIO28 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO28 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO28 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-29 - PIN FUNCTION = --SCITXDA--
  GpioCtrlRegs.GPAMUX2.bit.GPIO29 = 1;    // 0=GPIO, 1=SCITXDA, 2=SCLA, 3=#TZ3
  //GpioCtrlRegs.GPADIR.bit.GPIO29 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO29 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO29 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-30 - PIN FUNCTION = --GPIO Input CANRXA--
  // GpioCtrlRegs.GPAMUX2.bit.GPIO30 = 0;    // 0=GPIO, 1=CANRXA, 2=EQEP2I, 3=EPWM7A
  // GpioCtrlRegs.GPADIR.bit.GPIO30 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPACLEAR.bit.GPIO30 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO30 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-31 - PIN FUNCTION = --GPIO Output CANTXA--
  // GpioCtrlRegs.GPAMUX2.bit.GPIO31 = 0;    // 0=GPIO, 1=CANTXA, 2=EQEP2S, 3=EPWM8A
  // GpioCtrlRegs.GPADIR.bit.GPIO31 = 1;   // 1=OUTput,  0=INput
  // GpioDataRegs.GPACLEAR.bit.GPIO31 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPASET.bit.GPIO31 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-32 - PIN FUNCTION = --GPIO Input SDAA--
  GpioCtrlRegs.GPBMUX1.bit.GPIO32 = 0;    // 0=GPIO, 1=SDAA, 2=EPWMSYNCI, 3=#ADCSOCAO
  GpioCtrlRegs.GPBDIR.bit.GPIO32 = 1;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO32 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO32 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-33 - PIN FUNCTION = --GPIO Output SCLA--
  GpioCtrlRegs.GPBMUX1.bit.GPIO33 = 0;    // 0=GPIO, 1=SCLA, 2=EPWMSYNCO, 3=#ADCSOCBO
  GpioCtrlRegs.GPBDIR.bit.GPIO33 = 1;   // 1=OUTput,  0=INput
  GpioDataRegs.GPBCLEAR.bit.GPIO33 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO33 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-34 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO34 = 0;    // 0=GPIO, 1=COMP2OUT, 2=Reserved, 3=COMP3OUT
  //GpioCtrlRegs.GPBDIR.bit.GPIO34 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO34 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO34 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-35 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO35 = 0;    // 0=GPIO (TDI), 1=Reserved, 2=Reserved, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO35 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO35 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO35 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-36 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO36 = 0;    // 0=GPIO (TMS), 1=Reserved, 2=Reserved, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO36 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO36 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO36 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-37 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO37 = 0;    // 0=GPIO (TDO), 1=Reserved, 2=Reserved, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO37 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO37 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO37 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-38 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO38 = 0;    // 0=GPIO/XCLKIN (TCK), 1=Reserved, 2=Reserved, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO38 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO38 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO38 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-39 - PIN FUNCTION = --GPIO Output REDE--
  GpioCtrlRegs.GPBMUX1.bit.GPIO39 = 0;    // 0=GPIO, 1=Reserved, 2=Reserved, 3=Reserved
  GpioCtrlRegs.GPBDIR.bit.GPIO39 = 1;   // 1=OUTput,  0=INput
  GpioDataRegs.GPBCLEAR.bit.GPIO39 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO39 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-40 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO40 = 0;    // 0=GPIO, 1=EPWM7A, 2=SCITXDB, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO40 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO40 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO40 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-41 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO41 = 0;    // 0=GPIO, 1=EPWM7B, 2=SCIRXDB, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO41 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO41 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO41 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-42 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO42 = 0;    // 0=GPIO, 1=EPWM8A, 2=#TZ1, 3=COMP1OUT
  //GpioCtrlRegs.GPBDIR.bit.GPIO42 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO42 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO42 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-43 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO43 = 0;    // 0=GPIO, 1=EPWM8B, 2=#TZ2, 3=COMP2OUT
  //GpioCtrlRegs.GPBDIR.bit.GPIO43 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO43 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO43 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-44 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX1.bit.GPIO44 = 0;    // 0=GPIO, 1=MFSRA, 2=SCIRXDB, 3=EPWM7B
  //GpioCtrlRegs.GPBDIR.bit.GPIO44 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO44 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO44 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-50 - PIN FUNCTION = --GPIO Input #TZ1--
  GpioCtrlRegs.GPBMUX2.bit.GPIO50 = 0;    // 0=GPIO, 1=EQEP1A, 2=MDXA, 3=#TZ1
  GpioCtrlRegs.GPBDIR.bit.GPIO50 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO50 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO50 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-51 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX2.bit.GPIO51 = 0;    // 0=GPIO, 1=EQEP1B, 2=MDRA, 3=#TZ2
  //GpioCtrlRegs.GPBDIR.bit.GPIO51 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO51 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO51 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-52 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX2.bit.GPIO52 = 0;    // 0=GPIO, 1=EQEP1S, 2=MCLKXA, 3=#TZ3
  //GpioCtrlRegs.GPBDIR.bit.GPIO52 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO52 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO52 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-53 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX2.bit.GPIO53 = 0;    // 0=GPIO, 1=EQEP1I, 2=MFSXA, 3=Reserved
  //GpioCtrlRegs.GPBDIR.bit.GPIO53 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO53 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO53 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-54 - PIN FUNCTION = --GPIO Input HRCAP1--
//  GpioCtrlRegs.GPBMUX2.bit.GPIO54 = 0;    // 0=GPIO, 1=SPISIMOA, 2=EQEP2A, 3=HRCAP1
//  GpioCtrlRegs.GPBDIR.bit.GPIO54 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO54 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO54 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-55 - PIN FUNCTION = --GPIO Input HRCAP2--
//  GpioCtrlRegs.GPBMUX2.bit.GPIO55 = 0;    // 0=GPIO, 1=SPISOMIA, 2=EQEP2B, 3=HRCAP2
//  GpioCtrlRegs.GPBDIR.bit.GPIO55 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO55 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO55 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-56 - PIN FUNCTION = --GPIO Input HRCAP3--
//  GpioCtrlRegs.GPBMUX2.bit.GPIO56 = 0;    // 0=GPIO, 1=SPICLKA, 2=EQEP2I, 3=HRCAP3
//  GpioCtrlRegs.GPBDIR.bit.GPIO56 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO56 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO56 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-57 - PIN FUNCTION = --GPIO Input HRCAP4--
//  GpioCtrlRegs.GPBMUX2.bit.GPIO57 = 0;    // 0=GPIO, 1=#SPISTEA, 2=EQEP2S, 3=HRCAP4
//  GpioCtrlRegs.GPBDIR.bit.GPIO57 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO57 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO57 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------
  //  GPIO-58 - PIN FUNCTION = --Spare--
  GpioCtrlRegs.GPBMUX2.bit.GPIO58 = 0;    // 0=GPIO, 1=MCLKRA, 2=SCITXDB, 3=EPWM7A
  //GpioCtrlRegs.GPBDIR.bit.GPIO58 = 0;   // 1=OUTput,  0=INput
  //GpioDataRegs.GPBCLEAR.bit.GPIO58 = 1; // uncomment if --> Set Low initially
  //GpioDataRegs.GPBSET.bit.GPIO58 = 1;   // uncomment if --> Set High initially
  //--------------------------------------------------------------------------------------

  SetSCITMSmon(&SciaRegs);  //Setup HiTerm communications port
  CPLD_Init();
//  EDIS;  // Disable register access
}

/******************************************************************************/
// A TMSmon protokolhoz megfeleoen all�tja be a soros portot.
void SetSCITMSmon(volatile struct SCI_REGS *ptr)
{
  sci_ptr_terminal = ptr;

  sci_ptr_terminal->SCICCR.all = 7;  //1 stop bit,no parity, no test, idle�line protocol, 8bits

  sci_ptr_terminal->SCICTL2.bit.RXBKINTENA=0;
  sci_ptr_terminal->SCICTL2.bit.TXINTENA=0;

  sci_ptr_terminal->SCIPRI.bit.FREE = 0;
  sci_ptr_terminal->SCIPRI.bit.SOFT = 0;

  sci_ptr_terminal->SCICTL1.bit.RXERRINTENA=0;
  sci_ptr_terminal->SCICTL1.bit.SWRESET=0;

  sci_ptr_terminal->SCICTL1.bit.TXWAKE=0;
  sci_ptr_terminal->SCICTL1.bit.SLEEP=0;
  sci_ptr_terminal->SCICTL1.bit.TXENA=1;
  sci_ptr_terminal->SCICTL1.bit.RXENA=1;

  sci_ptr_terminal->SCILBAUD = (((40*1000000L)/57600-8)/8) & 0xff;
  sci_ptr_terminal->SCIHBAUD = (((40*1000000L)/57600-8)/8) >> 8;

  sci_ptr_terminal->SCICTL1.bit.RXERRINTENA=0;
  sci_ptr_terminal->SCICTL1.bit.SWRESET=1;

  sci_ptr_terminal->SCICTL1.bit.TXWAKE=0;
  sci_ptr_terminal->SCICTL1.bit.SLEEP=0;
  sci_ptr_terminal->SCICTL1.bit.TXENA=1;
  sci_ptr_terminal->SCICTL1.bit.RXENA=1;

  sci_ptr_terminal->SCIFFTX.bit.SCIFFENA = 1;
  sci_ptr_terminal->SCIFFTX.all=0xE000;
  sci_ptr_terminal->SCICTL1.all = 0x0023;     // Relinquish SCI from Reset
  sci_ptr_terminal->SCIFFTX.bit.TXFIFOXRESET = 1;

// FIFO
  sci_ptr_terminal->SCIFFRX.bit.RXFFOVRCLR = 1;
  sci_ptr_terminal->SCIFFRX.bit.RXFIFORESET = 0; // Clear and disable receiver FIFO
  sci_ptr_terminal->SCIFFRX.bit.RXFFINTCLR = 1;

  sci_ptr_terminal->SCIFFRX.bit.RXFIFORESET = 1; // Reenable FIFO
  sci_ptr_terminal->SCIFFRX.bit.RXFFIENA = 1;  // Receive FIFO interrupt enable
  sci_ptr_terminal->SCIFFRX.bit.RXFFIL = 1;   // Receive FIFO interrupt level: 1 b�jt j�tt

}
/******************************************************************************/
