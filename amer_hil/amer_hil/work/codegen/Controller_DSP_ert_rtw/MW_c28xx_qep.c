#include "c2000BoardSupport.h"
#include "F2806x_Device.h"
#include "F2806x_Examples.h"
#include "F2806x_GlobalPrototypes.h"
#include "rtwtypes.h"
#include "Controller_DSP.h"
#include "Controller_DSP_private.h"

void config_QEP_eQEP2(uint32_T pcmaximumvalue, uint32_T pcInitialvalue, uint32_T
                      unittimerperiod, uint32_T comparevalue, uint16_T
                      watchdogtimer, uint16_T qdecctl, uint16_T qepctl, uint16_T
                      qposctl, uint16_T qcapctl, uint16_T qeint)
{
  EALLOW;                              /* Enable EALLOW*/

  /* Enable internal pull-up for the selected pins */
  GpioCtrlRegs.GPAPUD.bit.GPIO24 = 0;  /* Enable pull-up on GPIO24 (EQEP2A)*/
  GpioCtrlRegs.GPAPUD.bit.GPIO25 = 0;  /* Enable pull-up on GPIO25 (EQEP2B)*/
  GpioCtrlRegs.GPAPUD.bit.GPIO27 = 0;  /* Enable pull-up on GPIO27 (EQEP2S)*/
  GpioCtrlRegs.GPAPUD.bit.GPIO26 = 0;  /* Enable pull-up on GPIO26 (EQEP2I)*/

  /* Configure eQEP-2 pins using GPIO regs*/
  GpioCtrlRegs.GPAMUX2.bit.GPIO24 = 2; /* Configure GPIO24 as EQEP2A*/
  GpioCtrlRegs.GPAMUX2.bit.GPIO25 = 2; /* Configure GPIO25 as EQEP2B  */
  GpioCtrlRegs.GPAMUX2.bit.GPIO27 = 2; /* Configure GPIO27 as EQEP2S*/
  GpioCtrlRegs.GPAMUX2.bit.GPIO26 = 2; /* Configure GPIO26 as EQEP2I*/
  EDIS;
  EQep2Regs.QPOSINIT = pcInitialvalue; /*eQEP Initialization Position Count*/
  EQep2Regs.QPOSMAX = pcmaximumvalue;  /*eQEP Maximum Position Count*/
  EQep2Regs.QUPRD = unittimerperiod;   /*eQEP Unit Period Register*/
  EQep2Regs.QWDPRD = watchdogtimer;    /*eQEP watchdog timer Register*/
  EQep2Regs.QDECCTL.all = qdecctl;     /*eQEP Decoder Control (QDECCTL) Register*/
  EQep2Regs.QEPCTL.all = qepctl;       /*eQEP Control (QEPCTL) Register*/
  EQep2Regs.QPOSCTL.all = qposctl;     /*eQEP Position-compare Control (QPOSCTL) Register*/
  EQep2Regs.QCAPCTL.all = qcapctl;     /*eQEP Capture Control (QCAPCTL) Register*/
  EQep2Regs.QEPCTL.bit.FREE_SOFT = 2;  /*unaffected by emulation suspend*/
  EQep2Regs.QPOSCMP = comparevalue;    /*eQEP Position-compare*/
  EQep2Regs.QEINT.all = qeint;         /*eQEPx interrupt enable register*/
}
