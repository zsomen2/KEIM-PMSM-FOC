#include "c2000BoardSupport.h"
#include "F2806x_Device.h"
#include "F2806x_Examples.h"
#include "F2806x_GlobalPrototypes.h"
#include "rtwtypes.h"
#include "Controller_DSP.h"
#include "Controller_DSP_private.h"

void config_ADC_SOC0()
{
  EALLOW;
  AdcRegs.ADCCTL2.bit.CLKDIV2EN = 1;   /* Set ADC clock division */
  AdcRegs.ADCCTL2.bit.CLKDIV4EN = 0;   /* Set ADC clock division */
  AdcRegs.ADCCTL2.bit.ADCNONOVERLAP = 0;/* Set ADCNONOVERLAP contorl bit to  Allowed */
  AdcRegs.ADCSAMPLEMODE.bit.SIMULEN0 = 0;/* Single sample mode set for SOC0.*/
  AdcRegs.ADCSOC0CTL.bit.CHSEL = 0;    /* Set SOC0 channel select to ADCINA0*/
  AdcRegs.ADCSOC0CTL.bit.TRIGSEL = 13;
  AdcRegs.ADCSOC0CTL.bit.ACQPS = 6;    /* Set SOC0 S/H Window to 7 ADC Clock Cycles*/
  AdcRegs.ADCINTSOCSEL1.bit.SOC0 = 0;  /* SOCx No ADCINT Interrupt Trigger Select.*/
  AdcRegs.ADCOFFTRIM.bit.OFFTRIM = AdcRegs.ADCOFFTRIM.bit.OFFTRIM;/* Set Offset Error Correctino Value*/
  AdcRegs.ADCCTL1.bit.ADCREFSEL = 0 ;  /* Set Reference Voltage*/
  AdcRegs.ADCCTL1.bit.INTPULSEPOS = 1; /* Late interrupt pulse trips AdcResults latch*/
  AdcRegs.SOCPRICTL.bit.SOCPRIORITY = 0;/* All in round robin mode SOC Priority*/
  EDIS;
}

void config_ADC_SOC1()
{
  EALLOW;
  AdcRegs.ADCCTL2.bit.CLKDIV2EN = 1;   /* Set ADC clock division */
  AdcRegs.ADCCTL2.bit.CLKDIV4EN = 0;   /* Set ADC clock division */
  AdcRegs.ADCCTL2.bit.ADCNONOVERLAP = 0;/* Set ADCNONOVERLAP contorl bit to  Allowed */
  AdcRegs.ADCSAMPLEMODE.bit.SIMULEN0 = 0;/* Single sample mode set for SOC1.*/
  AdcRegs.ADCSOC1CTL.bit.CHSEL = 1;    /* Set SOC1 channel select to ADCINA1*/
  AdcRegs.ADCSOC1CTL.bit.TRIGSEL = 13;
  AdcRegs.ADCSOC1CTL.bit.ACQPS = 6;    /* Set SOC1 S/H Window to 7 ADC Clock Cycles*/
  AdcRegs.ADCINTSOCSEL1.bit.SOC1 = 0;  /* SOCx No ADCINT Interrupt Trigger Select.*/
  AdcRegs.ADCOFFTRIM.bit.OFFTRIM = AdcRegs.ADCOFFTRIM.bit.OFFTRIM;/* Set Offset Error Correctino Value*/
  AdcRegs.ADCCTL1.bit.ADCREFSEL = 0 ;  /* Set Reference Voltage*/
  AdcRegs.ADCCTL1.bit.INTPULSEPOS = 1; /* Late interrupt pulse trips AdcResults latch*/
  AdcRegs.SOCPRICTL.bit.SOCPRIORITY = 0;/* All in round robin mode SOC Priority*/
  EDIS;
}

void config_ADC_SOC2()
{
  EALLOW;
  AdcRegs.ADCCTL2.bit.CLKDIV2EN = 1;   /* Set ADC clock division */
  AdcRegs.ADCCTL2.bit.CLKDIV4EN = 0;   /* Set ADC clock division */
  AdcRegs.ADCCTL2.bit.ADCNONOVERLAP = 0;/* Set ADCNONOVERLAP contorl bit to  Allowed */
  AdcRegs.ADCSAMPLEMODE.bit.SIMULEN2 = 0;/* Single sample mode set for SOC2.*/
  AdcRegs.ADCSOC2CTL.bit.CHSEL = 2;    /* Set SOC2 channel select to ADCINA2*/
  AdcRegs.ADCSOC2CTL.bit.TRIGSEL = 13;
  AdcRegs.ADCSOC2CTL.bit.ACQPS = 6;    /* Set SOC2 S/H Window to 7 ADC Clock Cycles*/
  AdcRegs.INTSEL1N2.bit.INT1E = 1;     /* Enabled/Disable ADCINT1 interrupt*/
  AdcRegs.INTSEL1N2.bit.INT1SEL = 2;   /* Setup EOC2 to trigger ADCINT1*/
  AdcRegs.INTSEL1N2.bit.INT1CONT = 0;  /* Enable/Disable ADCINT1 Continuous mode*/
  AdcRegs.ADCINTSOCSEL1.bit.SOC2 = 0;  /* SOCx No ADCINT Interrupt Trigger Select.*/
  AdcRegs.ADCOFFTRIM.bit.OFFTRIM = AdcRegs.ADCOFFTRIM.bit.OFFTRIM;/* Set Offset Error Correctino Value*/
  AdcRegs.ADCCTL1.bit.ADCREFSEL = 0 ;  /* Set Reference Voltage*/
  AdcRegs.ADCCTL1.bit.INTPULSEPOS = 1; /* Late interrupt pulse trips AdcResults latch*/
  AdcRegs.SOCPRICTL.bit.SOCPRIORITY = 0;/* All in round robin mode SOC Priority*/
  EDIS;
}
