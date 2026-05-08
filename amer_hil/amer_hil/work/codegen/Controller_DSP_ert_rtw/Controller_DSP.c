/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Controller_DSP.c
 *
 * Code generated for Simulink model 'Controller_DSP'.
 *
 * Model version                  : 1.17
 * Simulink Coder version         : 9.0 (R2018b) 24-May-2018
 * C/C++ source code generated on : Wed May  6 12:46:18 2026
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Texas Instruments->C2000
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Controller_DSP.h"
#include "Controller_DSP_private.h"

const CPLDOutput_t Controller_DSP_rtZCPLDOutput_t = {
  false,                               /* MASK4 */
  false,                               /* MASK3 */
  false,                               /* MASK2 */
  false,                               /* MASK1 */
  false,                               /* GreenLED */
  false,                               /* BlueLED */
  false,                               /* RedLED */
  false,                               /* YellowLED */
  false,                               /* GPOUT6 */
  false,                               /* GPOUT5 */
  false,                               /* GPOUT4 */
  false,                               /* GPOUT3 */
  false,                               /* GPOUT2 */
  false,                               /* GPOUT1 */
  false                                /* GPOUT0 */
} ;                                    /* CPLDOutput_t ground */

const CPLDInput_t Controller_DSP_rtZCPLDInput_t = {
  0U,                                  /* FAIL */
  false,                               /* ENC1SW */
  false,                               /* GPIN6 */
  false,                               /* GPIN5 */
  false,                               /* GPIN4 */
  false,                               /* GPIN3 */
  false,                               /* GPIN2 */
  false,                               /* GPIN1 */
  false                                /* GPIN0 */
} ;                                    /* CPLDInput_t ground */

const Meas_t Controller_DSP_rtZMeas_t = {
  {
    0.0F, 0.0F, 0.0F }
  ,                                    /* value */

  {
    0.0F, 0.0F, 0.0F }
  ,                                    /* gain */

  {
    0.0F, 0.0F, 0.0F }
  ,                                    /* offset */

  {
    0.0F, 0.0F, 0.0F }
  /* comp */
} ;                                    /* Meas_t ground */

/* Exported block signals */
uint16_T cnt_1s;                       /* '<S39>/Output' */
uint16_T cnt_100ms;                    /* '<S23>/Output' */
uint16_T CPLDOutBits;                  /* '<S28>/bit_concat_unary' */
uint16_T Status;                       /* '<S36>/bit_concat_unary' */
uint16_T Encoder;                      /* '<S34>/bit_concat_unary' */

/* Exported block parameters */
real32_T Id_Ki = 0.039747078F;         /* Variable: Id_Ki
                                        * Referenced by: '<S15>/Ki'
                                        */
real32_T Id_Kp = 1.2915436F;           /* Variable: Id_Kp
                                        * Referenced by: '<S15>/Kp'
                                        */
real32_T Id_ref = 0.0F;                /* Variable: Id_ref
                                        * Referenced by: '<Root>/DSP_Id_ref'
                                        */
real32_T Iq_Ki = 0.128909454F;         /* Variable: Iq_Ki
                                        * Referenced by: '<S17>/Ki'
                                        */
real32_T Iq_Kp = 4.18879032F;          /* Variable: Iq_Kp
                                        * Referenced by: '<S17>/Kp'
                                        */
real32_T Iq_ref = 0.0F;                /* Variable: Iq_ref
                                        * Referenced by: '<Root>/DSP_Iq_ref'
                                        */
real32_T Speed_Iq_limit = 50.0F;       /* Variable: Speed_Iq_limit
                                        * Referenced by: '<S11>/Iq_limit'
                                        */
real32_T Speed_Ki = 0.001F;            /* Variable: Speed_Ki
                                        * Referenced by: '<S11>/Ki'
                                        */
real32_T Speed_Kp = 0.6F;              /* Variable: Speed_Kp
                                        * Referenced by: '<S11>/Kp'
                                        */
real32_T Udc_min = 20.0F;              /* Variable: Udc_min
                                        * Referenced by: '<S14>/Udc_min'
                                        */
real32_T modulation_limit = 0.577350259F;/* Variable: modulation_limit
                                          * Referenced by: '<S20>/modulation_limit'
                                          */
real32_T speed_ref = 0.0F;             /* Variable: speed_ref
                                        * Referenced by: '<Root>/DSP_speed_ref'
                                        */
uint16_T delay = 0U;                   /* Variable: delay
                                        * Referenced by: '<S3>/Constant3'
                                        */
boolean_T Start = 0;                   /* Variable: Start
                                        * Referenced by: '<Root>/DSP_Start'
                                        */
uint16_T ctrl_mode = 0U;               /* Variable: ctrl_mode
                                        * Referenced by: '<Root>/DSP_ctrl_mode'
                                        */

/* Exported block states */
Meas_t AnalogChA;                      /* '<Root>/Data Store Memory3' */
CPLDOutput_t CPLDOut;                  /* '<Root>/Data Store Memory1' */
CPLDInput_t CPLDIn;                    /* '<Root>/Data Store Memory2' */
uint16_T AdcStart;                     /* '<Root>/Data Store Memory' */
uint16_T AdcStop;                      /* '<Root>/Data Store Memory4' */

/* Block signals (default storage) */
B_Controller_DSP_T Controller_DSP_B;

/* Block states (default storage) */
DW_Controller_DSP_T Controller_DSP_DW;

/* Real-time model */
RT_MODEL_Controller_DSP_T Controller_DSP_M_;
RT_MODEL_Controller_DSP_T *const Controller_DSP_M = &Controller_DSP_M_;
static void rate_monotonic_scheduler(void);
static uint16_T adcInitFlag = 0;

/* Hardware Interrupt Block: '<Root>/C28x Hardware Interrupt' */
void isr_int1pie1_task_fcn(void)
{
  /* Call the system: <Root>/Scheduler */
  {
    /* S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' */

    /* Output and update for function-call system: '<Root>/Scheduler' */
    {
      /* local block i/o variables */
      real32_T rtb_GainDc;
      uint16_T rtb_Gain3;
      real32_T rtb_DTheta;
      real32_T rtb_theta;
      real32_T rtb_P_plus_I;
      real32_T rtb_duty_C;
      uint32_T PMSM_FOC_ELAPS_T;
      real32_T Udc;
      boolean_T fault;
      real32_T OutportBufferForDa;
      real32_T rtb_Sum1_idx_0;
      real32_T rtb_Sum1_idx_1;
      real32_T rtb_error_tmp;

      /* Asynchronous task reads absolute time. Data (absolute time)
         transfers from low priority task (base rate) to high priority
         task (asynchronous rate). Double buffers are used to ensure
         data integrity.
         -- rtmL2HLastBufWr is the buffer index that is written last.
       */
      Controller_DSP_M->Timing.clockTick3 =
        Controller_DSP_M->Timing.rtmL2HDbBufClockTick
        [Controller_DSP_M->Timing.rtmL2HLastBufWr];

      /* Outputs for Function Call SubSystem: '<Root>/ReadAnalogInputs' */

      /* user code (Output function Body for TID3) */

      /* System '<Root>/ReadAnalogInputs' */
      GpioDataRegs.GPBSET.bit.GPIO33 = 1;
      AdcStart = EPwm5Regs.TBCTR;

      /* S-Function (c2802xadc): '<S4>/ADC' */
      {
        /*  Internal Reference Voltage : Fixed scale 0 to 3.3 V range.  */
        /*  External Reference Voltage : Allowable ranges of VREFHI(ADCINA0) = 3.3 and VREFLO(tied to ground) = 0  */
        Controller_DSP_B.ADC = (AdcResult.ADCRESULT0);
      }

      /* S-Function (c2802xadc): '<S4>/ADC1' */
      {
        /*  Internal Reference Voltage : Fixed scale 0 to 3.3 V range.  */
        /*  External Reference Voltage : Allowable ranges of VREFHI(ADCINA0) = 3.3 and VREFLO(tied to ground) = 0  */
        Controller_DSP_B.ADC1 = (AdcResult.ADCRESULT1);
      }

      /* S-Function (c2802xadc): '<S4>/ADC2' */
      {
        /*  Internal Reference Voltage : Fixed scale 0 to 3.3 V range.  */
        /*  External Reference Voltage : Allowable ranges of VREFHI(ADCINA0) = 3.3 and VREFLO(tied to ground) = 0  */
        Controller_DSP_B.ADC2 = (AdcResult.ADCRESULT2);
      }

      /* Sum: '<S4>/Sum1' incorporates:
       *  DataStoreRead: '<S4>/Data Store Read'
       *  Product: '<S4>/Product'
       *  Sum: '<S4>/Sum'
       */
      rtb_Sum1_idx_0 = ((real32_T)Controller_DSP_B.ADC * AnalogChA.gain[0] -
                        AnalogChA.offset[0]) - AnalogChA.comp[0];
      rtb_Sum1_idx_1 = ((real32_T)Controller_DSP_B.ADC1 * AnalogChA.gain[1] -
                        AnalogChA.offset[1]) - AnalogChA.comp[1];

      /* DataStoreWrite: '<S4>/Data Store Write' incorporates:
       *  DataStoreRead: '<S4>/Data Store Read'
       *  Product: '<S4>/Product'
       *  Sum: '<S4>/Sum'
       *  Sum: '<S4>/Sum1'
       */
      AnalogChA.value[0] = rtb_Sum1_idx_0;
      AnalogChA.value[1] = rtb_Sum1_idx_1;
      AnalogChA.value[2] = ((real32_T)Controller_DSP_B.ADC2 * AnalogChA.gain[2]
                            - AnalogChA.offset[2]) - AnalogChA.comp[2];

      /* S-Function (c2802xadc): '<S4>/UdcADC' */
      {
        /*  Internal Reference Voltage : Fixed scale 0 to 3.3 V range.  */
        /*  External Reference Voltage : Allowable ranges of VREFHI(ADCINA0) = 3.3 and VREFLO(tied to ground) = 0  */
        Controller_DSP_B.UdcADC = (AdcResult.ADCRESULT3);
      }

      /* SignalConversion: '<S4>/BusConversion_InsertedFor_sensor_at_inport_0' incorporates:
       *  Gain: '<S4>/UdcGain'
       */
      Udc = 0.244140625F * (real32_T)Controller_DSP_B.UdcADC;

      /* S-Function (c280xqep): '<S4>/eQEP1' */
      {
        Controller_DSP_B.eQEP1 = EQep2Regs.QPOSCNT;/*eQEP Position Counter*/
      }

      /* Gain: '<S4>/GainTheta' */
      rtb_theta = 0.00153398083F * Controller_DSP_B.eQEP1;

      /* Sum: '<S4>/DTheta' incorporates:
       *  UnitDelay: '<S4>/ThetaPrev'
       */
      rtb_DTheta = rtb_theta - Controller_DSP_DW.ThetaPrev_DSTATE;

      /* Sum: '<S4>/RpmAvgSum' incorporates:
       *  Fcn: '<S4>/WrapThetaDeltaFcn'
       *  Gain: '<S4>/GainRPM'
       *  Gain: '<S4>/GainW'
       *  Gain: '<S4>/RpmAvgGain'
       *  Sum: '<S4>/RpmAvgDiff'
       *  UnitDelay: '<S4>/RpmAvgDelay'
       */
      Controller_DSP_DW.RpmAvgDelay_DSTATE += ((rtb_DTheta - (real32_T)floor
        ((rtb_DTheta + 3.14159274F) / 6.28318548F) * 6.28318548F) * 20000.0F *
        9.54929638F - Controller_DSP_DW.RpmAvgDelay_DSTATE) * 0.125F;

      /* SignalConversion: '<S4>/BusConversion_InsertedFor_sensor_at_inport_0' incorporates:
       *  UnitDelay: '<S4>/RpmAvgDelay'
       */
      Controller_DSP_B.rpm = Controller_DSP_DW.RpmAvgDelay_DSTATE;

      /* SignalConversion: '<S4>/BusConversion_InsertedFor_sensor_at_inport_0' incorporates:
       *  DataStoreRead: '<S4>/CPLDInRead'
       *  DataTypeConversion: '<S4>/FaultFromFAIL'
       */
      fault = (CPLDIn.FAIL != 0U);

      /* Update for UnitDelay: '<S4>/ThetaPrev' */
      Controller_DSP_DW.ThetaPrev_DSTATE = rtb_theta;

      /* End of Outputs for SubSystem: '<Root>/ReadAnalogInputs' */

      /* Outputs for Function Call SubSystem: '<S2>/PMSM_FOC' */
      if (Controller_DSP_DW.PMSM_FOC_RESET_ELAPS_T) {
        PMSM_FOC_ELAPS_T = 0UL;
      } else {
        PMSM_FOC_ELAPS_T = Controller_DSP_M->Timing.clockTick3 -
          Controller_DSP_DW.PMSM_FOC_PREV_T;
      }

      Controller_DSP_DW.PMSM_FOC_PREV_T = Controller_DSP_M->Timing.clockTick3;
      Controller_DSP_DW.PMSM_FOC_RESET_ELAPS_T = false;

      /* Gain: '<S12>/one_over_sqrt3' incorporates:
       *  Gain: '<S12>/2ib'
       *  Sum: '<S12>/ia_plus_2ib'
       */
      rtb_DTheta = (2.0F * rtb_Sum1_idx_1 + rtb_Sum1_idx_0) * 0.577350259F;

      /* Gain: '<S13>/pole_pairs' */
      rtb_theta *= 3.0F;

      /* Trigonometry: '<S18>/sin' incorporates:
       *  Trigonometry: '<S16>/sin'
       */
      rtb_duty_C = (real32_T)sin(rtb_theta);

      /* Trigonometry: '<S18>/cos' incorporates:
       *  Trigonometry: '<S16>/cos'
       */
      rtb_error_tmp = (real32_T)cos(rtb_theta);

      /* Sum: '<S15>/error' incorporates:
       *  Product: '<S18>/Ialpha_cos'
       *  Product: '<S18>/Ibeta_sin'
       *  Sum: '<S18>/Id_sum'
       *  Trigonometry: '<S18>/cos'
       *  Trigonometry: '<S18>/sin'
       */
      rtb_Sum1_idx_1 = Controller_DSP_B.Id_ref_h - (rtb_Sum1_idx_0 *
        rtb_error_tmp + rtb_DTheta * rtb_duty_C);

      /* Gain: '<S15>/Ki' */
      rtb_theta = Id_Ki * rtb_Sum1_idx_1;

      /* DiscreteIntegrator: '<S15>/Integrator' */
      if (Controller_DSP_DW.Integrator_SYSTEM_ENABLE == 0U) {
        Controller_DSP_DW.Integrator_DSTATE_f += 0.001F * (real32_T)
          PMSM_FOC_ELAPS_T * Controller_DSP_DW.Integrator_PREV_U;
      }

      /* End of DiscreteIntegrator: '<S15>/Integrator' */

      /* Sum: '<S15>/P_plus_I' incorporates:
       *  Gain: '<S15>/Kp'
       */
      rtb_P_plus_I = Id_Kp * rtb_Sum1_idx_1 +
        Controller_DSP_DW.Integrator_DSTATE_f;

      /* Gain: '<S20>/modulation_limit' */
      rtb_Sum1_idx_1 = modulation_limit * Udc;

      /* Switch: '<S21>/Switch2' incorporates:
       *  Gain: '<S20>/neg_limit'
       *  RelationalOperator: '<S21>/LowerRelop1'
       *  RelationalOperator: '<S21>/UpperRelop'
       *  Switch: '<S21>/Switch'
       */
      if (rtb_P_plus_I > rtb_Sum1_idx_1) {
        rtb_P_plus_I = rtb_Sum1_idx_1;
      } else {
        if (rtb_P_plus_I < -rtb_Sum1_idx_1) {
          /* Switch: '<S21>/Switch' incorporates:
           *  Gain: '<S20>/neg_limit'
           */
          rtb_P_plus_I = -rtb_Sum1_idx_1;
        }
      }

      /* End of Switch: '<S21>/Switch2' */

      /* Sum: '<S17>/error' incorporates:
       *  Product: '<S18>/Ialpha_sin'
       *  Product: '<S18>/Ibeta_cos'
       *  Sum: '<S18>/Iq_sum'
       *  Trigonometry: '<S18>/cos'
       *  Trigonometry: '<S18>/sin'
       */
      rtb_Sum1_idx_0 = Controller_DSP_B.mode_switch - (rtb_DTheta *
        rtb_error_tmp - rtb_Sum1_idx_0 * rtb_duty_C);

      /* DiscreteIntegrator: '<S17>/Integrator' */
      if (Controller_DSP_DW.Integrator_SYSTEM_ENABLE_d == 0U) {
        Controller_DSP_DW.Integrator_DSTATE_k += 0.001F * (real32_T)
          PMSM_FOC_ELAPS_T * Controller_DSP_DW.Integrator_PREV_U_o;
      }

      /* End of DiscreteIntegrator: '<S17>/Integrator' */

      /* Sum: '<S17>/P_plus_I' incorporates:
       *  Gain: '<S17>/Kp'
       */
      rtb_DTheta = Iq_Kp * rtb_Sum1_idx_0 +
        Controller_DSP_DW.Integrator_DSTATE_k;

      /* Switch: '<S22>/Switch2' incorporates:
       *  Gain: '<S20>/neg_limit'
       *  RelationalOperator: '<S22>/LowerRelop1'
       *  RelationalOperator: '<S22>/UpperRelop'
       *  Switch: '<S22>/Switch'
       */
      if (rtb_DTheta > rtb_Sum1_idx_1) {
        rtb_DTheta = rtb_Sum1_idx_1;
      } else {
        if (rtb_DTheta < -rtb_Sum1_idx_1) {
          /* Switch: '<S22>/Switch' incorporates:
           *  Gain: '<S20>/neg_limit'
           */
          rtb_DTheta = -rtb_Sum1_idx_1;
        }
      }

      /* End of Switch: '<S22>/Switch2' */

      /* Sum: '<S16>/Valpha_sum' incorporates:
       *  Product: '<S16>/Vd_cos'
       *  Product: '<S16>/Vq_sin'
       */
      rtb_Sum1_idx_1 = rtb_P_plus_I * rtb_error_tmp - rtb_DTheta * rtb_duty_C;

      /* Sum: '<S19>/duty_A' incorporates:
       *  Constant: '<S19>/half_A'
       *  Product: '<S19>/divide_A'
       *  Sum: '<S19>/phase_A'
       */
      OutportBufferForDa = rtb_Sum1_idx_1 / Udc + 0.5F;

      /* Saturate: '<S19>/clamp_A' */
      if (OutportBufferForDa > 1.0F) {
        /* SignalConversion: '<S10>/OutportBufferForDa' */
        OutportBufferForDa = 1.0F;
      } else {
        if (OutportBufferForDa < 0.0F) {
          /* SignalConversion: '<S10>/OutportBufferForDa' */
          OutportBufferForDa = 0.0F;
        }
      }

      /* End of Saturate: '<S19>/clamp_A' */

      /* Sum: '<S16>/Vbeta_sum' incorporates:
       *  Product: '<S16>/Vd_sin'
       *  Product: '<S16>/Vq_cos'
       */
      rtb_duty_C = rtb_P_plus_I * rtb_duty_C + rtb_DTheta * rtb_error_tmp;

      /* Sum: '<S19>/duty_B' incorporates:
       *  Constant: '<S19>/half_B'
       *  Gain: '<S19>/minus_half_alpha_B'
       *  Gain: '<S19>/sqrt3_half_beta_B'
       *  Product: '<S19>/divide_B'
       *  Sum: '<S19>/phase_B'
       */
      rtb_DTheta = (-0.5F * rtb_Sum1_idx_1 + 0.866025388F * rtb_duty_C) / Udc +
        0.5F;

      /* Saturate: '<S19>/clamp_B' */
      if (rtb_DTheta > 1.0F) {
        rtb_DTheta = 1.0F;
      } else {
        if (rtb_DTheta < 0.0F) {
          rtb_DTheta = 0.0F;
        }
      }

      /* End of Saturate: '<S19>/clamp_B' */

      /* Sum: '<S19>/duty_C' incorporates:
       *  Constant: '<S19>/half_C'
       *  Gain: '<S19>/minus_half_alpha_C'
       *  Gain: '<S19>/neg_sqrt3_half_beta_C'
       *  Product: '<S19>/divide_C'
       *  Sum: '<S19>/phase_C'
       */
      rtb_Sum1_idx_1 = (-0.5F * rtb_Sum1_idx_1 + -0.866025388F * rtb_duty_C) /
        Udc + 0.5F;

      /* Saturate: '<S19>/clamp_C' */
      if (rtb_Sum1_idx_1 > 1.0F) {
        rtb_Sum1_idx_1 = 1.0F;
      } else {
        if (rtb_Sum1_idx_1 < 0.0F) {
          rtb_Sum1_idx_1 = 0.0F;
        }
      }

      /* End of Saturate: '<S19>/clamp_C' */

      /* Logic: '<S14>/gate_and' incorporates:
       *  Constant: '<S14>/Udc_min'
       *  Logic: '<S14>/fault_or'
       *  Logic: '<S14>/not_fault'
       *  RelationalOperator: '<S14>/Udc_low'
       */
      fault = (Controller_DSP_B.Start_c && ((!fault) && (!(Udc < Udc_min))));

      /* Update for DiscreteIntegrator: '<S15>/Integrator' */
      Controller_DSP_DW.Integrator_SYSTEM_ENABLE = 0U;
      Controller_DSP_DW.Integrator_PREV_U = rtb_theta;

      /* Update for DiscreteIntegrator: '<S17>/Integrator' incorporates:
       *  Gain: '<S17>/Ki'
       */
      Controller_DSP_DW.Integrator_SYSTEM_ENABLE_d = 0U;
      Controller_DSP_DW.Integrator_PREV_U_o = Iq_Ki * rtb_Sum1_idx_0;

      /* End of Outputs for SubSystem: '<S2>/PMSM_FOC' */

      /* Outputs for Function Call SubSystem: '<Root>/PWM' */

      /* Gain: '<S3>/Gain3' */
      rtb_Gain3 = (uint16_T)(4000.0F * OutportBufferForDa);

      /* S-Function (c2802xpwm): '<S3>/ePWM' */

      /*-- Update CMPA value for ePWM1 --*/
      {
        EPwm1Regs.CMPA.half.CMPA = (uint16_T)(rtb_Gain3);
      }

      /* Gain: '<S3>/GainDb' */
      rtb_GainDc = 4000.0F * rtb_DTheta;

      /* S-Function (c2802xpwm): '<S3>/ePWM1' */

      /*-- Update CMPA value for ePWM2 --*/
      {
        EPwm2Regs.CMPA.half.CMPA = (uint16_T)(rtb_GainDc);
      }

      /* Gain: '<S3>/GainDc' */
      rtb_GainDc = 4000.0F * rtb_Sum1_idx_1;

      /* S-Function (c2802xpwm): '<S3>/ePWM2' */

      /*-- Update CMPA value for ePWM3 --*/
      {
        EPwm3Regs.CMPA.half.CMPA = (uint16_T)(rtb_GainDc);
      }

      /* S-Function (c2802xpwm): '<S3>/ePWM4' incorporates:
       *  Constant: '<S3>/Constant3'
       */

      /*-- Update CMPA value for ePWM5 --*/
      {
        EPwm5Regs.CMPA.half.CMPA = (uint16_T)(delay);
      }

      /* S-Function (c2802xpwm): '<S3>/ePWM3' incorporates:
       *  Constant: '<S3>/Constant4'
       */

      /*-- Update CMPA value for ePWM4 --*/
      {
        EPwm4Regs.CMPA.half.CMPA = (uint16_T)(0U);
      }

      /* DataStoreWrite: '<S3>/Data Store Write1' */
      CPLDOut.GPOUT0 = fault;

      /* user code (Update function Body for TID3) */

      /* System '<Root>/PWM' */
      AMER_task_adc();
      GpioDataRegs.GPBCLEAR.bit.GPIO33 = 1;
      AdcStop = EPwm5Regs.TBCTR;

      /* End of Outputs for SubSystem: '<Root>/PWM' */
    }

    /* End of Outputs for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' */

    /* RateTransition: '<S2>/RT_rpm_speed' */
    Controller_DSP_DW.RT_rpm_speed_Buffer[Controller_DSP_DW.RT_rpm_speed_semaphoreTaken
      == 0] = Controller_DSP_B.rpm;
    Controller_DSP_DW.RT_rpm_speed_ActiveBufIdx =
      (Controller_DSP_DW.RT_rpm_speed_semaphoreTaken == 0);
  }
}

/* Idle Task Block: '<Root>/Idle Task' */
void idle_num1_task_fcn(void)
{
  /* Call the system: <Root>/Background */
  {
    /* S-Function (idletask): '<Root>/Idle Task' */

    /* Output and update for function-call system: '<Root>/Background' */

    /* user code (Update function Body for TID4) */

    /* System '<Root>/Background' */
    AMER_task_background();

    /* End of Outputs for S-Function (idletask): '<Root>/Idle Task' */
  }
}

/*
 * Set which subrates need to run this base step (base rate always runs).
 * This function must be called prior to calling the model step function
 * in order to "remember" which rates need to run this base step.  The
 * buffering of events allows for overlapping preemption.
 */
void Controller_DSP_SetEventsForThisBaseStep(boolean_T *eventFlags)
{
  /* Task runs when its counter is zero, computed via rtmStepTask macro */
  eventFlags[1] = ((boolean_T)rtmStepTask(Controller_DSP_M, 1));
  eventFlags[2] = ((boolean_T)rtmStepTask(Controller_DSP_M, 2));
}

/*
 *   This function updates active task flag for each subrate
 * and rate transition flags for tasks that exchange data.
 * The function assumes rate-monotonic multitasking scheduler.
 * The function must be called at model base rate so that
 * the generated code self-manages all its subrates and rate
 * transition flags.
 */
static void rate_monotonic_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (Controller_DSP_M->Timing.TaskCounters.TID[1])++;
  if ((Controller_DSP_M->Timing.TaskCounters.TID[1]) > 99) {/* Sample time: [0.1s, 0.0s] */
    Controller_DSP_M->Timing.TaskCounters.TID[1] = 0;
  }

  (Controller_DSP_M->Timing.TaskCounters.TID[2])++;
  if ((Controller_DSP_M->Timing.TaskCounters.TID[2]) > 999) {/* Sample time: [1.0s, 0.0s] */
    Controller_DSP_M->Timing.TaskCounters.TID[2] = 0;
  }
}

/* Model step function for TID0 */
void Controller_DSP_step0(void)        /* Sample time: [0.001s, 0.0s] */
{
  int16_T y[15];
  int16_T ii;
  boolean_T rtb_active;
  real32_T rtb_speed_error;
  real32_T rtb_Ki_gate;
  boolean_T rtb_TmpSignalConversionAtSFunct[15];

  {                                    /* Sample time: [0.001s, 0.0s] */
    rate_monotonic_scheduler();
  }

  /* Constant: '<Root>/DSP_Start' */
  Controller_DSP_B.Start_c = Start;

  /* Logic: '<S11>/active' incorporates:
   *  Constant: '<Root>/DSP_ctrl_mode'
   *  RelationalOperator: '<S11>/is_speed_mode'
   */
  rtb_active = ((ctrl_mode == 1U) && Controller_DSP_B.Start_c);

  /* Sum: '<S11>/speed_error' incorporates:
   *  Constant: '<Root>/DSP_speed_ref'
   *  UnitDelay: '<S2>/RPM_feedback_z1'
   */
  rtb_speed_error = speed_ref - Controller_DSP_DW.RPM_feedback_z1_DSTATE;

  /* Product: '<S11>/Ki_gate' incorporates:
   *  DataTypeConversion: '<S11>/active_single'
   *  Gain: '<S11>/Ki'
   */
  rtb_Ki_gate = Speed_Ki * rtb_speed_error * (real32_T)rtb_active;

  /* Switch: '<S11>/mode_switch' incorporates:
   *  DataTypeConversion: '<S11>/active_single'
   */
  if ((real32_T)rtb_active >= 0.5F) {
    /* Sum: '<S11>/add_feedforward' incorporates:
     *  Constant: '<Root>/DSP_Iq_ref'
     *  DiscreteIntegrator: '<S11>/Integrator'
     *  Gain: '<S11>/Kp'
     *  Sum: '<S11>/PI_sum'
     */
    Controller_DSP_B.mode_switch = (Speed_Kp * rtb_speed_error +
      Controller_DSP_DW.Integrator_DSTATE) + Iq_ref;

    /* Saturate: '<S11>/Iq_limit' */
    if (Controller_DSP_B.mode_switch > Speed_Iq_limit) {
      /* Sum: '<S11>/add_feedforward' */
      Controller_DSP_B.mode_switch = Speed_Iq_limit;
    } else {
      if (Controller_DSP_B.mode_switch < -Speed_Iq_limit) {
        /* Sum: '<S11>/add_feedforward' */
        Controller_DSP_B.mode_switch = -Speed_Iq_limit;
      }
    }

    /* End of Saturate: '<S11>/Iq_limit' */
  } else {
    /* Sum: '<S11>/add_feedforward' incorporates:
     *  Constant: '<Root>/DSP_Iq_ref'
     */
    Controller_DSP_B.mode_switch = Iq_ref;
  }

  /* End of Switch: '<S11>/mode_switch' */

  /* Constant: '<Root>/DSP_Id_ref' */
  Controller_DSP_B.Id_ref_h = Id_ref;

  /* S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_pre'
   */

  /* user code (Output function Body) */

  /* System '<Root>/Task_1ms_pre' */
  GpioDataRegs.GPBSET.bit.GPIO32 = 1;

  /* S-Function (c280xgpio_di): '<S8>/Digital Input' */
  {
    Controller_DSP_B.DigitalInput[0] = GpioDataRegs.GPBDAT.bit.GPIO54;
    Controller_DSP_B.DigitalInput[1] = GpioDataRegs.GPBDAT.bit.GPIO55;
  }

  /* S-Function (c280xgpio_di): '<S8>/Digital Input1' */
  {
    Controller_DSP_B.DigitalInput1[0] = GpioDataRegs.GPBDAT.bit.GPIO56;
    Controller_DSP_B.DigitalInput1[1] = GpioDataRegs.GPBDAT.bit.GPIO57;
  }

  /* S-Function (c280xgpio_di): '<S8>/Digital Input2' */
  {
    Controller_DSP_B.DigitalInput2[0] = GpioDataRegs.GPBDAT.bit.GPIO40;
    Controller_DSP_B.DigitalInput2[1] = GpioDataRegs.GPBDAT.bit.GPIO41;
    Controller_DSP_B.DigitalInput2[2] = GpioDataRegs.GPBDAT.bit.GPIO42;
    Controller_DSP_B.DigitalInput2[3] = GpioDataRegs.GPBDAT.bit.GPIO43;
  }

  /* Outputs for Atomic SubSystem: '<S8>/Bit Concat1' */
  /* Outputs for Atomic SubSystem: '<S32>/bc4' */
  /* MATLAB Function: '<S34>/bit_concat_unary' incorporates:
   *  SignalConversion: '<S35>/TmpSignal ConversionAt SFunction Inport1'
   */
  Encoder = (uint16_T)Controller_DSP_B.DigitalInput2[1] << 1 |
    Controller_DSP_B.DigitalInput2[0] | (uint16_T)
    Controller_DSP_B.DigitalInput2[2] << 2 | (uint16_T)
    Controller_DSP_B.DigitalInput2[3] << 3;

  /* End of Outputs for SubSystem: '<S32>/bc4' */
  /* End of Outputs for SubSystem: '<S8>/Bit Concat1' */

  /* Outputs for Atomic SubSystem: '<S8>/Bit Concat2' */
  /* Outputs for Atomic SubSystem: '<S33>/bc4' */
  /* MATLAB Function: '<S36>/bit_concat_unary' incorporates:
   *  SignalConversion: '<S37>/TmpSignal ConversionAt SFunction Inport1'
   */
  Status = (uint16_T)Controller_DSP_B.DigitalInput1[0] << 1 |
    Controller_DSP_B.DigitalInput1[1] | (uint16_T)Controller_DSP_B.DigitalInput
    [1] << 2 | (uint16_T)Controller_DSP_B.DigitalInput[0] << 3;

  /* End of Outputs for SubSystem: '<S33>/bc4' */
  /* End of Outputs for SubSystem: '<S8>/Bit Concat2' */

  /* DataTypeConversion: '<S8>/StatusToUint16' incorporates:
   *  DataStoreWrite: '<S8>/WriteSensorStatus'
   */
  Controller_DSP_DW.SensorStatus = Status;

  /* DataStoreWrite: '<S8>/Data Store Write' incorporates:
   *  DataStoreRead: '<S8>/Data Store Read1'
   */
  CPLDOut.YellowLED = CPLDIn.ENC1SW;

  /* DataStoreWrite: '<S8>/Data Store Write2' incorporates:
   *  DataStoreRead: '<S8>/Data Store Read2'
   */
  CPLDOut.BlueLED = CPLDIn.GPIN0;

  /* S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_post'
   */

  /* Outputs for Atomic SubSystem: '<S7>/Bit Concat4' */
  /* Outputs for Atomic SubSystem: '<S26>/bc4' */
  /* SignalConversion: '<S29>/TmpSignal ConversionAt SFunction Inport1' incorporates:
   *  DataStoreRead: '<S7>/Data Store Read'
   *  MATLAB Function: '<S28>/bit_concat_unary'
   */
  rtb_TmpSignalConversionAtSFunct[0] = CPLDOut.MASK4;
  rtb_TmpSignalConversionAtSFunct[1] = CPLDOut.MASK3;
  rtb_TmpSignalConversionAtSFunct[2] = CPLDOut.MASK2;
  rtb_TmpSignalConversionAtSFunct[3] = CPLDOut.MASK1;
  rtb_TmpSignalConversionAtSFunct[4] = CPLDOut.GreenLED;
  rtb_TmpSignalConversionAtSFunct[5] = CPLDOut.BlueLED;
  rtb_TmpSignalConversionAtSFunct[6] = CPLDOut.RedLED;
  rtb_TmpSignalConversionAtSFunct[7] = CPLDOut.YellowLED;
  rtb_TmpSignalConversionAtSFunct[8] = CPLDOut.GPOUT6;
  rtb_TmpSignalConversionAtSFunct[9] = CPLDOut.GPOUT5;
  rtb_TmpSignalConversionAtSFunct[10] = CPLDOut.GPOUT4;
  rtb_TmpSignalConversionAtSFunct[11] = CPLDOut.GPOUT3;
  rtb_TmpSignalConversionAtSFunct[12] = CPLDOut.GPOUT2;
  rtb_TmpSignalConversionAtSFunct[13] = CPLDOut.GPOUT1;
  rtb_TmpSignalConversionAtSFunct[14] = CPLDOut.GPOUT0;

  /* MATLAB Function: '<S28>/bit_concat_unary' */
  for (ii = 0; ii < 15; ii++) {
    y[ii] = (int16_T)rtb_TmpSignalConversionAtSFunct[ii];
  }

  CPLDOutBits = (uint16_T)y[13] << 1 | y[14] | (uint16_T)y[12] << 2 | (uint16_T)
    y[11] << 3 | (uint16_T)y[10] << 4 | (uint16_T)y[9] << 5 | (uint16_T)y[8] <<
    6 | (uint16_T)y[7] << 7 | (uint16_T)y[6] << 8 | (uint16_T)y[5] << 9 |
    (uint16_T)y[4] << 10 | (uint16_T)y[3] << 11 | (uint16_T)y[2] << 12 |
    (uint16_T)y[1] << 13 | (uint16_T)y[0] << 14;

  /* End of Outputs for SubSystem: '<S26>/bc4' */
  /* End of Outputs for SubSystem: '<S7>/Bit Concat4' */

  /* user code (Update function Body) */

  /* System '<Root>/Task_1ms_post' */
  AMER_task_1ms();
  CPLDOutput.all = CPLDOutBits;
  CPLDIn.GPIN0 = CPLDInput.bit.GPIN0;
  CPLDIn.GPIN1 = CPLDInput.bit.GPIN1;
  CPLDIn.GPIN2 = CPLDInput.bit.GPIN2;
  CPLDIn.GPIN3 = CPLDInput.bit.GPIN3;
  CPLDIn.GPIN4 = CPLDInput.bit.GPIN4;
  CPLDIn.GPIN5 = CPLDInput.bit.GPIN5;
  CPLDIn.GPIN6 = CPLDInput.bit.GPIN6;
  CPLDIn.ENC1SW = CPLDInput.bit.ENC1SW;
  CPLDIn.FAIL = CPLDInput.bit.FAIL;
  GpioDataRegs.GPBCLEAR.bit.GPIO32 = 1;

  /* End of Outputs for S-Function (fcncallgen): '<Root>/Function-Call Generator' */

  /* RateTransition: '<S2>/RT_rpm_speed' */
  Controller_DSP_DW.RT_rpm_speed_semaphoreTaken =
    Controller_DSP_DW.RT_rpm_speed_ActiveBufIdx;
  Controller_DSP_DW.RPM_feedback_z1_DSTATE =
    Controller_DSP_DW.RT_rpm_speed_Buffer[Controller_DSP_DW.RT_rpm_speed_semaphoreTaken];

  /* Update for DiscreteIntegrator: '<S11>/Integrator' */
  Controller_DSP_DW.Integrator_DSTATE += 0.001F * rtb_Ki_gate;

  /* Update absolute time */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The resolution of this integer timer is 0.001, which is the step size
   * of the task. Size of "clockTick0" ensures timer will not overflow during the
   * application lifespan selected.
   */
  Controller_DSP_M->Timing.clockTick0++;

  {
    /* Base rate updates double buffers of absolute time for
       asynchronous task. Double buffers are used to ensure
       data integrity when asynchronous task reads absolute
       time.
       -- rtmL2HLastBufWr is the buffer index that is written last.
     */
    boolean_T bufIdx = !Controller_DSP_M->Timing.rtmL2HLastBufWr;
    Controller_DSP_M->Timing.rtmL2HDbBufClockTick[bufIdx] =
      Controller_DSP_M->Timing.clockTick0;
    Controller_DSP_M->Timing.rtmL2HLastBufWr = bufIdx;
  }
}

/* Model step function for TID1 */
void Controller_DSP_step1(void)        /* Sample time: [0.1s, 0.0s] */
{
  /* S-Function (fcncallgen): '<Root>/Function-Call Generator1' incorporates:
   *  SubSystem: '<Root>/Task_100ms_post'
   */
  /* UnitDelay: '<S23>/Output' */
  cnt_100ms = Controller_DSP_DW.Output_DSTATE_f;

  /* Switch: '<S25>/FixPt Switch' incorporates:
   *  Constant: '<S24>/FixPt Constant'
   *  Sum: '<S24>/FixPt Sum1'
   *  UnitDelay: '<S23>/Output'
   */
  Controller_DSP_DW.Output_DSTATE_f = cnt_100ms + 1U;

  /* End of Outputs for S-Function (fcncallgen): '<Root>/Function-Call Generator1' */
}

/* Model step function for TID2 */
void Controller_DSP_step2(void)        /* Sample time: [1.0s, 0.0s] */
{
  /* S-Function (fcncallgen): '<Root>/Function-Call Generator2' incorporates:
   *  SubSystem: '<Root>/Task_1s_post'
   */

  /* UnitDelay: '<S39>/Output' */
  cnt_1s = Controller_DSP_DW.Output_DSTATE;

  /* DataTypeConversion: '<S9>/Data Type Conversion' incorporates:
   *  DataStoreWrite: '<S9>/Data Store Write'
   *  DataTypeConversion: '<S38>/Extract Desired Bits'
   */
  CPLDOut.GreenLED = ((cnt_1s & 1U) != 0U);

  /* Switch: '<S41>/FixPt Switch' incorporates:
   *  Constant: '<S40>/FixPt Constant'
   *  Sum: '<S40>/FixPt Sum1'
   *  UnitDelay: '<S39>/Output'
   */
  Controller_DSP_DW.Output_DSTATE = cnt_1s + 1U;

  /* user code (Update function Body) */

  /* System '<Root>/Task_1s_post' */
  AMER_task_1s();

  /* End of Outputs for S-Function (fcncallgen): '<Root>/Function-Call Generator2' */
}

/* Model initialize function */
void Controller_DSP_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)Controller_DSP_M, 0,
                sizeof(RT_MODEL_Controller_DSP_T));

  /* block I/O */
  (void) memset(((void *) &Controller_DSP_B), 0,
                sizeof(B_Controller_DSP_T));

  /* exported global signals */
  cnt_1s = 0U;
  cnt_100ms = 0U;
  CPLDOutBits = 0U;
  Status = 0U;
  Encoder = 0U;

  /* states (dwork) */
  (void) memset((void *)&Controller_DSP_DW, 0,
                sizeof(DW_Controller_DSP_T));

  /* exported global states */
  AnalogChA = Controller_DSP_rtZMeas_t;
  CPLDOut = Controller_DSP_rtZCPLDOutput_t;
  CPLDIn = Controller_DSP_rtZCPLDInput_t;
  AdcStart = 0U;
  AdcStop = 0U;

  /* SetupRuntimeResources for S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_pre'
   */

  /* Start for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' incorporates:
   *  Chart: '<Root>/Scheduler'
   */

  /* Start for Chart: '<Root>/Scheduler' */
  /* Start for function-call system: '<Root>/Scheduler' */

  /* Start for Function Call SubSystem: '<Root>/PWM' */

  /* Start for S-Function (c2802xpwm): '<S3>/ePWM' */

  /*** Initialize ePWM1 modules ***/
  {
    /*  // Time Base Control Register
       EPwm1Regs.TBCTL.bit.CTRMODE              = 2;          // Counter Mode
       EPwm1Regs.TBCTL.bit.SYNCOSEL             = 1;          // Sync Output Select
       EPwm1Regs.TBCTL.bit.PRDLD                = 0;          // Shadow select
       EPwm1Regs.TBCTL.bit.PHSEN                = 0;          // Phase Load Enable
       EPwm1Regs.TBCTL.bit.PHSDIR               = 0;          // Phase Direction Bit
       EPwm1Regs.TBCTL.bit.HSPCLKDIV            = 0;          // High Speed TBCLK Pre-scaler
       EPwm1Regs.TBCTL.bit.CLKDIV               = 0;          // Time Base Clock Pre-scaler
       EPwm1Regs.TBCTL.bit.SWFSYNC              = 0;          // Software Force Sync Pulse
     */
    EPwm1Regs.TBCTL.all = (EPwm1Regs.TBCTL.all & ~0x3FFF) | 0x12;

    /*-- Setup Time-Base (TB) Submodule --*/
    EPwm1Regs.TBPRD = 4000;            // Time Base Period Register

    /* // Time-Base Phase Register
       EPwm1Regs.TBPHS.half.TBPHS               = 0;          // Phase offset register
     */
    EPwm1Regs.TBPHS.all = (EPwm1Regs.TBPHS.all & ~0xFFFF0000) | 0x0;

    // Time Base Counter Register
    EPwm1Regs.TBCTR = 0x0000;          /* Clear counter*/

    /*-- Setup Counter_Compare (CC) Submodule --*/
    /*	// Counter Compare Control Register
       EPwm1Regs.CMPCTL.bit.SHDWAMODE           = 0;  // Compare A Register Block Operating Mode
       EPwm1Regs.CMPCTL.bit.SHDWBMODE           = 0;  // Compare B Register Block Operating Mode
       EPwm1Regs.CMPCTL.bit.LOADAMODE           = 0;          // Active Compare A Load
       EPwm1Regs.CMPCTL.bit.LOADBMODE           = 0;          // Active Compare B Load
     */
    EPwm1Regs.CMPCTL.all = (EPwm1Regs.CMPCTL.all & ~0x5F) | 0x0;
    EPwm1Regs.CMPA.half.CMPA = 0;      // Counter Compare A Register
    EPwm1Regs.CMPB = 32000;            // Counter Compare B Register

    /*-- Setup Action-Qualifier (AQ) Submodule --*/
    EPwm1Regs.AQCTLA.all = 144;        // Action Qualifier Control Register For Output A
    EPwm1Regs.AQCTLB.all = 2310;       // Action Qualifier Control Register For Output B

    /*	// Action Qualifier Software Force Register
       EPwm1Regs.AQSFRC.bit.RLDCSF              = 0;          // Reload from Shadow Options
     */
    EPwm1Regs.AQSFRC.all = (EPwm1Regs.AQSFRC.all & ~0xC0) | 0x0;

    /*	// Action Qualifier Continuous S/W Force Register
       EPwm1Regs.AQCSFRC.bit.CSFA               = 0;          // Continuous Software Force on output A
       EPwm1Regs.AQCSFRC.bit.CSFB               = 0;          // Continuous Software Force on output B
     */
    EPwm1Regs.AQCSFRC.all = (EPwm1Regs.AQCSFRC.all & ~0xF) | 0x0;

    /*-- Setup Dead-Band Generator (DB) Submodule --*/
    /*	// Dead-Band Generator Control Register
       EPwm1Regs.DBCTL.bit.OUT_MODE             = 3;          // Dead Band Output Mode Control
       EPwm1Regs.DBCTL.bit.IN_MODE              = 0;          // Dead Band Input Select Mode Control
       EPwm1Regs.DBCTL.bit.POLSEL               = 2;          // Polarity Select Control
       EPwm1Regs.DBCTL.bit.HALFCYCLE            = 0;          // Half Cycle Clocking Enable
     */
    EPwm1Regs.DBCTL.all = (EPwm1Regs.DBCTL.all & ~0x803F) | 0xB;
    EPwm1Regs.DBRED = 0;               // Dead-Band Generator Rising Edge Delay Count Register
    EPwm1Regs.DBFED = 0;               // Dead-Band Generator Falling Edge Delay Count Register

    /*-- Setup Event-Trigger (ET) Submodule --*/
    /*	// Event Trigger Selection and Pre-Scale Register
       EPwm1Regs.ETSEL.bit.SOCAEN               = 0;          // Start of Conversion A Enable
       EPwm1Regs.ETSEL.bit.SOCASEL              = 3;          // Start of Conversion A Select
       EPwm1Regs.ETPS.bit.SOCAPRD               = 1;          // EPWM1SOCA Period Select

       EPwm1Regs.ETSEL.bit.SOCBEN               = 0;          // Start of Conversion B Enable

       EPwm1Regs.ETSEL.bit.SOCBSEL              = 1;          // Start of Conversion B Select
       EPwm1Regs.ETPS.bit.SOCBPRD               = 1;          // EPWM1SOCB Period Select
       EPwm1Regs.ETSEL.bit.INTEN                = 0;          // EPWM1INTn Enable
       EPwm1Regs.ETSEL.bit.INTSEL               = 1;          // EPWM1INTn Select

       EPwm1Regs.ETPS.bit.INTPRD                = 1;          // EPWM1INTn Period Select
     */
    EPwm1Regs.ETSEL.all = (EPwm1Regs.ETSEL.all & ~0xFF0F) | 0x1301;
    EPwm1Regs.ETPS.all = (EPwm1Regs.ETPS.all & ~0x3303) | 0x1101;

    /*-- Setup PWM-Chopper (PC) Submodule --*/
    /*	// PWM Chopper Control Register
       EPwm1Regs.PCCTL.bit.CHPEN                = 0;          // PWM chopping enable
       EPwm1Regs.PCCTL.bit.CHPFREQ              = 0;          // Chopping clock frequency
       EPwm1Regs.PCCTL.bit.OSHTWTH              = 0;          // One-shot pulse width
       EPwm1Regs.PCCTL.bit.CHPDUTY              = 0;          // Chopping clock Duty cycle
     */
    EPwm1Regs.PCCTL.all = (EPwm1Regs.PCCTL.all & ~0x7FF) | 0x0;

    /*-- Set up Trip-Zone (TZ) Submodule --*/
    EALLOW;
    EPwm1Regs.TZSEL.all = 0;           // Trip Zone Select Register

    /*	// Trip Zone Control Register
       EPwm1Regs.TZCTL.bit.TZA                  = 3;          // TZ1 to TZ6 Trip Action On EPWM1A
       EPwm1Regs.TZCTL.bit.TZB                  = 3;          // TZ1 to TZ6 Trip Action On EPWM1B
       EPwm1Regs.TZCTL.bit.DCAEVT1              = 3;          // EPWM1A action on DCAEVT1
       EPwm1Regs.TZCTL.bit.DCAEVT2              = 3;          // EPWM1A action on DCAEVT2
       EPwm1Regs.TZCTL.bit.DCBEVT1              = 3;          // EPWM1B action on DCBEVT1
       EPwm1Regs.TZCTL.bit.DCBEVT2              = 3;          // EPWM1B action on DCBEVT2
     */
    EPwm1Regs.TZCTL.all = (EPwm1Regs.TZCTL.all & ~0xFFF) | 0xFFF;

    /*	// Trip Zone Enable Interrupt Register
       EPwm1Regs.TZEINT.bit.OST                 = 0;          // Trip Zones One Shot Int Enable
       EPwm1Regs.TZEINT.bit.CBC                 = 0;          // Trip Zones Cycle By Cycle Int Enable
       EPwm1Regs.TZEINT.bit.DCAEVT1             = 0;          // Digital Compare A Event 1 Int Enable
       EPwm1Regs.TZEINT.bit.DCAEVT2             = 0;          // Digital Compare A Event 2 Int Enable
       EPwm1Regs.TZEINT.bit.DCBEVT1             = 0;          // Digital Compare B Event 1 Int Enable
       EPwm1Regs.TZEINT.bit.DCBEVT2             = 0;          // Digital Compare B Event 2 Int Enable
     */
    EPwm1Regs.TZEINT.all = (EPwm1Regs.TZEINT.all & ~0x7E) | 0x0;

    /*	// Digital Compare A Control Register
       EPwm1Regs.DCACTL.bit.EVT1SYNCE           = 0;          // DCAEVT1 SYNC Enable
       EPwm1Regs.DCACTL.bit.EVT1SOCE            = 0;          // DCAEVT1 SOC Enable
       EPwm1Regs.DCACTL.bit.EVT1FRCSYNCSEL      = 0;          // DCAEVT1 Force Sync Signal
       EPwm1Regs.DCACTL.bit.EVT1SRCSEL          = 0;          // DCAEVT1 Source Signal
       EPwm1Regs.DCACTL.bit.EVT2FRCSYNCSEL      = 0;          // DCAEVT2 Force Sync Signal
       EPwm1Regs.DCACTL.bit.EVT2SRCSEL          = 0;          // DCAEVT2 Source Signal
     */
    EPwm1Regs.DCACTL.all = (EPwm1Regs.DCACTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare B Control Register
       EPwm1Regs.DCBCTL.bit.EVT1SYNCE           = 0;          // DCBEVT1 SYNC Enable
       EPwm1Regs.DCBCTL.bit.EVT1SOCE            = 0;          // DCBEVT1 SOC Enable
       EPwm1Regs.DCBCTL.bit.EVT1FRCSYNCSEL      = 0;          // DCBEVT1 Force Sync Signal
       EPwm1Regs.DCBCTL.bit.EVT1SRCSEL          = 0;          // DCBEVT1 Source Signal
       EPwm1Regs.DCBCTL.bit.EVT2FRCSYNCSEL      = 0;          // DCBEVT2 Force Sync Signal
       EPwm1Regs.DCBCTL.bit.EVT2SRCSEL          = 0;          // DCBEVT2 Source Signal
     */
    EPwm1Regs.DCBCTL.all = (EPwm1Regs.DCBCTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare Trip Select Register
       EPwm1Regs.DCTRIPSEL.bit.DCAHCOMPSEL      = 0;          // Digital Compare A High COMP Input Select

       EPwm1Regs.DCTRIPSEL.bit.DCALCOMPSEL      = 1;          // Digital Compare A Low COMP Input Select
       EPwm1Regs.DCTRIPSEL.bit.DCBHCOMPSEL      = 0;          // Digital Compare B High COMP Input Select
       EPwm1Regs.DCTRIPSEL.bit.DCBLCOMPSEL      = 1;          // Digital Compare B Low COMP Input Select
     */
    EPwm1Regs.DCTRIPSEL.all = (EPwm1Regs.DCTRIPSEL.all & ~ 0xFFFF) | 0x1010;

    /*	// Trip Zone Digital Comparator Select Register
       EPwm1Regs.TZDCSEL.bit.DCAEVT1            = 0;          // Digital Compare Output A Event 1
       EPwm1Regs.TZDCSEL.bit.DCAEVT2            = 0;          // Digital Compare Output A Event 2
       EPwm1Regs.TZDCSEL.bit.DCBEVT1            = 0;          // Digital Compare Output B Event 1
       EPwm1Regs.TZDCSEL.bit.DCBEVT2            = 0;          // Digital Compare Output B Event 2
     */
    EPwm1Regs.TZDCSEL.all = (EPwm1Regs.TZDCSEL.all & ~0xFFF) | 0x0;

    /*	// Digital Compare Filter Control Register
       EPwm1Regs.DCFCTL.bit.BLANKE              = 0;          // Blanking Enable/Disable
       EPwm1Regs.DCFCTL.bit.PULSESEL            = 1;          // Pulse Select for Blanking & Capture Alignment
       EPwm1Regs.DCFCTL.bit.BLANKINV            = 0;          // Blanking Window Inversion
       EPwm1Regs.DCFCTL.bit.SRCSEL              = 0;          // Filter Block Signal Source Select
     */
    EPwm1Regs.DCFCTL.all = (EPwm1Regs.DCFCTL.all & ~0x3F) | 0x10;
    EPwm1Regs.DCFOFFSET = 0;           // Digital Compare Filter Offset Register
    EPwm1Regs.DCFWINDOW = 0;           // Digital Compare Filter Window Register

    /*	// Digital Compare Capture Control Register
       EPwm1Regs.DCCAPCTL.bit.CAPE              = 0;          // Counter Capture Enable
     */
    EPwm1Regs.DCCAPCTL.all = (EPwm1Regs.DCCAPCTL.all & ~0x1) | 0x0;

    /*	// HRPWM Configuration Register
       EPwm1Regs.HRCNFG.bit.SWAPAB              = 0;          // Swap EPWMA and EPWMB Outputs Bit
       EPwm1Regs.HRCNFG.bit.SELOUTB             = 0;          // EPWMB Output Selection Bit
     */
    EPwm1Regs.HRCNFG.all = (EPwm1Regs.HRCNFG.all & ~0xA0) | 0x0;
    EDIS;
  }

  /* Start for S-Function (c2802xpwm): '<S3>/ePWM1' */

  /*** Initialize ePWM2 modules ***/
  {
    /*  // Time Base Control Register
       EPwm2Regs.TBCTL.bit.CTRMODE              = 2;          // Counter Mode
       EPwm2Regs.TBCTL.bit.SYNCOSEL             = 0;          // Sync Output Select
       EPwm2Regs.TBCTL.bit.PRDLD                = 0;          // Shadow select
       EPwm2Regs.TBCTL.bit.PHSEN                = 1;          // Phase Load Enable
       EPwm2Regs.TBCTL.bit.PHSDIR               = 0;          // Phase Direction Bit
       EPwm2Regs.TBCTL.bit.HSPCLKDIV            = 0;          // High Speed TBCLK Pre-scaler
       EPwm2Regs.TBCTL.bit.CLKDIV               = 0;          // Time Base Clock Pre-scaler
       EPwm2Regs.TBCTL.bit.SWFSYNC              = 0;          // Software Force Sync Pulse
     */
    EPwm2Regs.TBCTL.all = (EPwm2Regs.TBCTL.all & ~0x3FFF) | 0x6;

    /*-- Setup Time-Base (TB) Submodule --*/
    EPwm2Regs.TBPRD = 4000;            // Time Base Period Register

    /* // Time-Base Phase Register
       EPwm2Regs.TBPHS.half.TBPHS               = 0;          // Phase offset register
     */
    EPwm2Regs.TBPHS.all = (EPwm2Regs.TBPHS.all & ~0xFFFF0000) | 0x0;

    // Time Base Counter Register
    EPwm2Regs.TBCTR = 0x0000;          /* Clear counter*/

    /*-- Setup Counter_Compare (CC) Submodule --*/
    /*	// Counter Compare Control Register
       EPwm2Regs.CMPCTL.bit.SHDWAMODE           = 0;  // Compare A Register Block Operating Mode
       EPwm2Regs.CMPCTL.bit.SHDWBMODE           = 0;  // Compare B Register Block Operating Mode
       EPwm2Regs.CMPCTL.bit.LOADAMODE           = 0;          // Active Compare A Load
       EPwm2Regs.CMPCTL.bit.LOADBMODE           = 0;          // Active Compare B Load
     */
    EPwm2Regs.CMPCTL.all = (EPwm2Regs.CMPCTL.all & ~0x5F) | 0x0;
    EPwm2Regs.CMPA.half.CMPA = 0;      // Counter Compare A Register
    EPwm2Regs.CMPB = 32000;            // Counter Compare B Register

    /*-- Setup Action-Qualifier (AQ) Submodule --*/
    EPwm2Regs.AQCTLA.all = 144;        // Action Qualifier Control Register For Output A
    EPwm2Regs.AQCTLB.all = 2310;       // Action Qualifier Control Register For Output B

    /*	// Action Qualifier Software Force Register
       EPwm2Regs.AQSFRC.bit.RLDCSF              = 0;          // Reload from Shadow Options
     */
    EPwm2Regs.AQSFRC.all = (EPwm2Regs.AQSFRC.all & ~0xC0) | 0x0;

    /*	// Action Qualifier Continuous S/W Force Register
       EPwm2Regs.AQCSFRC.bit.CSFA               = 0;          // Continuous Software Force on output A
       EPwm2Regs.AQCSFRC.bit.CSFB               = 0;          // Continuous Software Force on output B
     */
    EPwm2Regs.AQCSFRC.all = (EPwm2Regs.AQCSFRC.all & ~0xF) | 0x0;

    /*-- Setup Dead-Band Generator (DB) Submodule --*/
    /*	// Dead-Band Generator Control Register
       EPwm2Regs.DBCTL.bit.OUT_MODE             = 3;          // Dead Band Output Mode Control
       EPwm2Regs.DBCTL.bit.IN_MODE              = 0;          // Dead Band Input Select Mode Control
       EPwm2Regs.DBCTL.bit.POLSEL               = 2;          // Polarity Select Control
       EPwm2Regs.DBCTL.bit.HALFCYCLE            = 0;          // Half Cycle Clocking Enable
     */
    EPwm2Regs.DBCTL.all = (EPwm2Regs.DBCTL.all & ~0x803F) | 0xB;
    EPwm2Regs.DBRED = 0;               // Dead-Band Generator Rising Edge Delay Count Register
    EPwm2Regs.DBFED = 0;               // Dead-Band Generator Falling Edge Delay Count Register

    /*-- Setup Event-Trigger (ET) Submodule --*/
    /*	// Event Trigger Selection and Pre-Scale Register
       EPwm2Regs.ETSEL.bit.SOCAEN               = 0;          // Start of Conversion A Enable
       EPwm2Regs.ETSEL.bit.SOCASEL              = 0;          // Start of Conversion A Select
       EPwm2Regs.ETPS.bit.SOCAPRD               = 1;          // EPWM2SOCA Period Select

       EPwm2Regs.ETSEL.bit.SOCBEN               = 0;          // Start of Conversion B Enable

       EPwm2Regs.ETSEL.bit.SOCBSEL              = 1;          // Start of Conversion B Select
       EPwm2Regs.ETPS.bit.SOCBPRD               = 1;          // EPWM2SOCB Period Select
       EPwm2Regs.ETSEL.bit.INTEN                = 0;          // EPWM2INTn Enable
       EPwm2Regs.ETSEL.bit.INTSEL               = 1;          // EPWM2INTn Select

       EPwm2Regs.ETPS.bit.INTPRD                = 1;          // EPWM2INTn Period Select
     */
    EPwm2Regs.ETSEL.all = (EPwm2Regs.ETSEL.all & ~0xFF0F) | 0x1001;
    EPwm2Regs.ETPS.all = (EPwm2Regs.ETPS.all & ~0x3303) | 0x1101;

    /*-- Setup PWM-Chopper (PC) Submodule --*/
    /*	// PWM Chopper Control Register
       EPwm2Regs.PCCTL.bit.CHPEN                = 0;          // PWM chopping enable
       EPwm2Regs.PCCTL.bit.CHPFREQ              = 0;          // Chopping clock frequency
       EPwm2Regs.PCCTL.bit.OSHTWTH              = 0;          // One-shot pulse width
       EPwm2Regs.PCCTL.bit.CHPDUTY              = 0;          // Chopping clock Duty cycle
     */
    EPwm2Regs.PCCTL.all = (EPwm2Regs.PCCTL.all & ~0x7FF) | 0x0;

    /*-- Set up Trip-Zone (TZ) Submodule --*/
    EALLOW;
    EPwm2Regs.TZSEL.all = 0;           // Trip Zone Select Register

    /*	// Trip Zone Control Register
       EPwm2Regs.TZCTL.bit.TZA                  = 3;          // TZ1 to TZ6 Trip Action On EPWM2A
       EPwm2Regs.TZCTL.bit.TZB                  = 3;          // TZ1 to TZ6 Trip Action On EPWM2B
       EPwm2Regs.TZCTL.bit.DCAEVT1              = 3;          // EPWM2A action on DCAEVT1
       EPwm2Regs.TZCTL.bit.DCAEVT2              = 3;          // EPWM2A action on DCAEVT2
       EPwm2Regs.TZCTL.bit.DCBEVT1              = 3;          // EPWM2B action on DCBEVT1
       EPwm2Regs.TZCTL.bit.DCBEVT2              = 3;          // EPWM2B action on DCBEVT2
     */
    EPwm2Regs.TZCTL.all = (EPwm2Regs.TZCTL.all & ~0xFFF) | 0xFFF;

    /*	// Trip Zone Enable Interrupt Register
       EPwm2Regs.TZEINT.bit.OST                 = 0;          // Trip Zones One Shot Int Enable
       EPwm2Regs.TZEINT.bit.CBC                 = 0;          // Trip Zones Cycle By Cycle Int Enable
       EPwm2Regs.TZEINT.bit.DCAEVT1             = 0;          // Digital Compare A Event 1 Int Enable
       EPwm2Regs.TZEINT.bit.DCAEVT2             = 0;          // Digital Compare A Event 2 Int Enable
       EPwm2Regs.TZEINT.bit.DCBEVT1             = 0;          // Digital Compare B Event 1 Int Enable
       EPwm2Regs.TZEINT.bit.DCBEVT2             = 0;          // Digital Compare B Event 2 Int Enable
     */
    EPwm2Regs.TZEINT.all = (EPwm2Regs.TZEINT.all & ~0x7E) | 0x0;

    /*	// Digital Compare A Control Register
       EPwm2Regs.DCACTL.bit.EVT1SYNCE           = 0;          // DCAEVT1 SYNC Enable
       EPwm2Regs.DCACTL.bit.EVT1SOCE            = 1;          // DCAEVT1 SOC Enable
       EPwm2Regs.DCACTL.bit.EVT1FRCSYNCSEL      = 0;          // DCAEVT1 Force Sync Signal
       EPwm2Regs.DCACTL.bit.EVT1SRCSEL          = 0;          // DCAEVT1 Source Signal
       EPwm2Regs.DCACTL.bit.EVT2FRCSYNCSEL      = 0;          // DCAEVT2 Force Sync Signal
       EPwm2Regs.DCACTL.bit.EVT2SRCSEL          = 0;          // DCAEVT2 Source Signal
     */
    EPwm2Regs.DCACTL.all = (EPwm2Regs.DCACTL.all & ~0x30F) | 0x4;

    /*	// Digital Compare B Control Register
       EPwm2Regs.DCBCTL.bit.EVT1SYNCE           = 0;          // DCBEVT1 SYNC Enable
       EPwm2Regs.DCBCTL.bit.EVT1SOCE            = 0;          // DCBEVT1 SOC Enable
       EPwm2Regs.DCBCTL.bit.EVT1FRCSYNCSEL      = 0;          // DCBEVT1 Force Sync Signal
       EPwm2Regs.DCBCTL.bit.EVT1SRCSEL          = 0;          // DCBEVT1 Source Signal
       EPwm2Regs.DCBCTL.bit.EVT2FRCSYNCSEL      = 0;          // DCBEVT2 Force Sync Signal
       EPwm2Regs.DCBCTL.bit.EVT2SRCSEL          = 0;          // DCBEVT2 Source Signal
     */
    EPwm2Regs.DCBCTL.all = (EPwm2Regs.DCBCTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare Trip Select Register
       EPwm2Regs.DCTRIPSEL.bit.DCAHCOMPSEL      = 0;          // Digital Compare A High COMP Input Select

       EPwm2Regs.DCTRIPSEL.bit.DCALCOMPSEL      = 1;          // Digital Compare A Low COMP Input Select
       EPwm2Regs.DCTRIPSEL.bit.DCBHCOMPSEL      = 0;          // Digital Compare B High COMP Input Select
       EPwm2Regs.DCTRIPSEL.bit.DCBLCOMPSEL      = 1;          // Digital Compare B Low COMP Input Select
     */
    EPwm2Regs.DCTRIPSEL.all = (EPwm2Regs.DCTRIPSEL.all & ~ 0xFFFF) | 0x1010;

    /*	// Trip Zone Digital Comparator Select Register
       EPwm2Regs.TZDCSEL.bit.DCAEVT1            = 0;          // Digital Compare Output A Event 1
       EPwm2Regs.TZDCSEL.bit.DCAEVT2            = 0;          // Digital Compare Output A Event 2
       EPwm2Regs.TZDCSEL.bit.DCBEVT1            = 0;          // Digital Compare Output B Event 1
       EPwm2Regs.TZDCSEL.bit.DCBEVT2            = 0;          // Digital Compare Output B Event 2
     */
    EPwm2Regs.TZDCSEL.all = (EPwm2Regs.TZDCSEL.all & ~0xFFF) | 0x0;

    /*	// Digital Compare Filter Control Register
       EPwm2Regs.DCFCTL.bit.BLANKE              = 0;          // Blanking Enable/Disable
       EPwm2Regs.DCFCTL.bit.PULSESEL            = 1;          // Pulse Select for Blanking & Capture Alignment
       EPwm2Regs.DCFCTL.bit.BLANKINV            = 0;          // Blanking Window Inversion
       EPwm2Regs.DCFCTL.bit.SRCSEL              = 0;          // Filter Block Signal Source Select
     */
    EPwm2Regs.DCFCTL.all = (EPwm2Regs.DCFCTL.all & ~0x3F) | 0x10;
    EPwm2Regs.DCFOFFSET = 0;           // Digital Compare Filter Offset Register
    EPwm2Regs.DCFWINDOW = 0;           // Digital Compare Filter Window Register

    /*	// Digital Compare Capture Control Register
       EPwm2Regs.DCCAPCTL.bit.CAPE              = 0;          // Counter Capture Enable
     */
    EPwm2Regs.DCCAPCTL.all = (EPwm2Regs.DCCAPCTL.all & ~0x1) | 0x0;

    /*	// HRPWM Configuration Register
       EPwm2Regs.HRCNFG.bit.SWAPAB              = 0;          // Swap EPWMA and EPWMB Outputs Bit
       EPwm2Regs.HRCNFG.bit.SELOUTB             = 0;          // EPWMB Output Selection Bit
     */
    EPwm2Regs.HRCNFG.all = (EPwm2Regs.HRCNFG.all & ~0xA0) | 0x0;
    EDIS;
  }

  /* Start for S-Function (c2802xpwm): '<S3>/ePWM2' */

  /*** Initialize ePWM3 modules ***/
  {
    /*  // Time Base Control Register
       EPwm3Regs.TBCTL.bit.CTRMODE              = 2;          // Counter Mode
       EPwm3Regs.TBCTL.bit.SYNCOSEL             = 0;          // Sync Output Select
       EPwm3Regs.TBCTL.bit.PRDLD                = 0;          // Shadow select
       EPwm3Regs.TBCTL.bit.PHSEN                = 1;          // Phase Load Enable
       EPwm3Regs.TBCTL.bit.PHSDIR               = 0;          // Phase Direction Bit
       EPwm3Regs.TBCTL.bit.HSPCLKDIV            = 0;          // High Speed TBCLK Pre-scaler
       EPwm3Regs.TBCTL.bit.CLKDIV               = 0;          // Time Base Clock Pre-scaler
       EPwm3Regs.TBCTL.bit.SWFSYNC              = 0;          // Software Force Sync Pulse
     */
    EPwm3Regs.TBCTL.all = (EPwm3Regs.TBCTL.all & ~0x3FFF) | 0x6;

    /*-- Setup Time-Base (TB) Submodule --*/
    EPwm3Regs.TBPRD = 4000;            // Time Base Period Register

    /* // Time-Base Phase Register
       EPwm3Regs.TBPHS.half.TBPHS               = 0;          // Phase offset register
     */
    EPwm3Regs.TBPHS.all = (EPwm3Regs.TBPHS.all & ~0xFFFF0000) | 0x0;

    // Time Base Counter Register
    EPwm3Regs.TBCTR = 0x0000;          /* Clear counter*/

    /*-- Setup Counter_Compare (CC) Submodule --*/
    /*	// Counter Compare Control Register
       EPwm3Regs.CMPCTL.bit.SHDWAMODE           = 0;  // Compare A Register Block Operating Mode
       EPwm3Regs.CMPCTL.bit.SHDWBMODE           = 0;  // Compare B Register Block Operating Mode
       EPwm3Regs.CMPCTL.bit.LOADAMODE           = 0;          // Active Compare A Load
       EPwm3Regs.CMPCTL.bit.LOADBMODE           = 0;          // Active Compare B Load
     */
    EPwm3Regs.CMPCTL.all = (EPwm3Regs.CMPCTL.all & ~0x5F) | 0x0;
    EPwm3Regs.CMPA.half.CMPA = 0;      // Counter Compare A Register
    EPwm3Regs.CMPB = 32000;            // Counter Compare B Register

    /*-- Setup Action-Qualifier (AQ) Submodule --*/
    EPwm3Regs.AQCTLA.all = 144;        // Action Qualifier Control Register For Output A
    EPwm3Regs.AQCTLB.all = 2310;       // Action Qualifier Control Register For Output B

    /*	// Action Qualifier Software Force Register
       EPwm3Regs.AQSFRC.bit.RLDCSF              = 0;          // Reload from Shadow Options
     */
    EPwm3Regs.AQSFRC.all = (EPwm3Regs.AQSFRC.all & ~0xC0) | 0x0;

    /*	// Action Qualifier Continuous S/W Force Register
       EPwm3Regs.AQCSFRC.bit.CSFA               = 0;          // Continuous Software Force on output A
       EPwm3Regs.AQCSFRC.bit.CSFB               = 0;          // Continuous Software Force on output B
     */
    EPwm3Regs.AQCSFRC.all = (EPwm3Regs.AQCSFRC.all & ~0xF) | 0x0;

    /*-- Setup Dead-Band Generator (DB) Submodule --*/
    /*	// Dead-Band Generator Control Register
       EPwm3Regs.DBCTL.bit.OUT_MODE             = 3;          // Dead Band Output Mode Control
       EPwm3Regs.DBCTL.bit.IN_MODE              = 0;          // Dead Band Input Select Mode Control
       EPwm3Regs.DBCTL.bit.POLSEL               = 2;          // Polarity Select Control
       EPwm3Regs.DBCTL.bit.HALFCYCLE            = 0;          // Half Cycle Clocking Enable
     */
    EPwm3Regs.DBCTL.all = (EPwm3Regs.DBCTL.all & ~0x803F) | 0xB;
    EPwm3Regs.DBRED = 0;               // Dead-Band Generator Rising Edge Delay Count Register
    EPwm3Regs.DBFED = 0;               // Dead-Band Generator Falling Edge Delay Count Register

    /*-- Setup Event-Trigger (ET) Submodule --*/
    /*	// Event Trigger Selection and Pre-Scale Register
       EPwm3Regs.ETSEL.bit.SOCAEN               = 0;          // Start of Conversion A Enable
       EPwm3Regs.ETSEL.bit.SOCASEL              = 0;          // Start of Conversion A Select
       EPwm3Regs.ETPS.bit.SOCAPRD               = 1;          // EPWM3SOCA Period Select

       EPwm3Regs.ETSEL.bit.SOCBEN               = 0;          // Start of Conversion B Enable

       EPwm3Regs.ETSEL.bit.SOCBSEL              = 1;          // Start of Conversion B Select
       EPwm3Regs.ETPS.bit.SOCBPRD               = 1;          // EPWM3SOCB Period Select
       EPwm3Regs.ETSEL.bit.INTEN                = 0;          // EPWM3INTn Enable
       EPwm3Regs.ETSEL.bit.INTSEL               = 1;          // EPWM3INTn Select

       EPwm3Regs.ETPS.bit.INTPRD                = 1;          // EPWM3INTn Period Select
     */
    EPwm3Regs.ETSEL.all = (EPwm3Regs.ETSEL.all & ~0xFF0F) | 0x1001;
    EPwm3Regs.ETPS.all = (EPwm3Regs.ETPS.all & ~0x3303) | 0x1101;

    /*-- Setup PWM-Chopper (PC) Submodule --*/
    /*	// PWM Chopper Control Register
       EPwm3Regs.PCCTL.bit.CHPEN                = 0;          // PWM chopping enable
       EPwm3Regs.PCCTL.bit.CHPFREQ              = 0;          // Chopping clock frequency
       EPwm3Regs.PCCTL.bit.OSHTWTH              = 0;          // One-shot pulse width
       EPwm3Regs.PCCTL.bit.CHPDUTY              = 0;          // Chopping clock Duty cycle
     */
    EPwm3Regs.PCCTL.all = (EPwm3Regs.PCCTL.all & ~0x7FF) | 0x0;

    /*-- Set up Trip-Zone (TZ) Submodule --*/
    EALLOW;
    EPwm3Regs.TZSEL.all = 0;           // Trip Zone Select Register

    /*	// Trip Zone Control Register
       EPwm3Regs.TZCTL.bit.TZA                  = 3;          // TZ1 to TZ6 Trip Action On EPWM3A
       EPwm3Regs.TZCTL.bit.TZB                  = 3;          // TZ1 to TZ6 Trip Action On EPWM3B
       EPwm3Regs.TZCTL.bit.DCAEVT1              = 3;          // EPWM3A action on DCAEVT1
       EPwm3Regs.TZCTL.bit.DCAEVT2              = 3;          // EPWM3A action on DCAEVT2
       EPwm3Regs.TZCTL.bit.DCBEVT1              = 3;          // EPWM3B action on DCBEVT1
       EPwm3Regs.TZCTL.bit.DCBEVT2              = 3;          // EPWM3B action on DCBEVT2
     */
    EPwm3Regs.TZCTL.all = (EPwm3Regs.TZCTL.all & ~0xFFF) | 0xFFF;

    /*	// Trip Zone Enable Interrupt Register
       EPwm3Regs.TZEINT.bit.OST                 = 0;          // Trip Zones One Shot Int Enable
       EPwm3Regs.TZEINT.bit.CBC                 = 0;          // Trip Zones Cycle By Cycle Int Enable
       EPwm3Regs.TZEINT.bit.DCAEVT1             = 0;          // Digital Compare A Event 1 Int Enable
       EPwm3Regs.TZEINT.bit.DCAEVT2             = 0;          // Digital Compare A Event 2 Int Enable
       EPwm3Regs.TZEINT.bit.DCBEVT1             = 0;          // Digital Compare B Event 1 Int Enable
       EPwm3Regs.TZEINT.bit.DCBEVT2             = 0;          // Digital Compare B Event 2 Int Enable
     */
    EPwm3Regs.TZEINT.all = (EPwm3Regs.TZEINT.all & ~0x7E) | 0x0;

    /*	// Digital Compare A Control Register
       EPwm3Regs.DCACTL.bit.EVT1SYNCE           = 0;          // DCAEVT1 SYNC Enable
       EPwm3Regs.DCACTL.bit.EVT1SOCE            = 1;          // DCAEVT1 SOC Enable
       EPwm3Regs.DCACTL.bit.EVT1FRCSYNCSEL      = 0;          // DCAEVT1 Force Sync Signal
       EPwm3Regs.DCACTL.bit.EVT1SRCSEL          = 0;          // DCAEVT1 Source Signal
       EPwm3Regs.DCACTL.bit.EVT2FRCSYNCSEL      = 0;          // DCAEVT2 Force Sync Signal
       EPwm3Regs.DCACTL.bit.EVT2SRCSEL          = 0;          // DCAEVT2 Source Signal
     */
    EPwm3Regs.DCACTL.all = (EPwm3Regs.DCACTL.all & ~0x30F) | 0x4;

    /*	// Digital Compare B Control Register
       EPwm3Regs.DCBCTL.bit.EVT1SYNCE           = 0;          // DCBEVT1 SYNC Enable
       EPwm3Regs.DCBCTL.bit.EVT1SOCE            = 0;          // DCBEVT1 SOC Enable
       EPwm3Regs.DCBCTL.bit.EVT1FRCSYNCSEL      = 0;          // DCBEVT1 Force Sync Signal
       EPwm3Regs.DCBCTL.bit.EVT1SRCSEL          = 0;          // DCBEVT1 Source Signal
       EPwm3Regs.DCBCTL.bit.EVT2FRCSYNCSEL      = 0;          // DCBEVT2 Force Sync Signal
       EPwm3Regs.DCBCTL.bit.EVT2SRCSEL          = 0;          // DCBEVT2 Source Signal
     */
    EPwm3Regs.DCBCTL.all = (EPwm3Regs.DCBCTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare Trip Select Register
       EPwm3Regs.DCTRIPSEL.bit.DCAHCOMPSEL      = 0;          // Digital Compare A High COMP Input Select

       EPwm3Regs.DCTRIPSEL.bit.DCALCOMPSEL      = 1;          // Digital Compare A Low COMP Input Select
       EPwm3Regs.DCTRIPSEL.bit.DCBHCOMPSEL      = 0;          // Digital Compare B High COMP Input Select
       EPwm3Regs.DCTRIPSEL.bit.DCBLCOMPSEL      = 1;          // Digital Compare B Low COMP Input Select
     */
    EPwm3Regs.DCTRIPSEL.all = (EPwm3Regs.DCTRIPSEL.all & ~ 0xFFFF) | 0x1010;

    /*	// Trip Zone Digital Comparator Select Register
       EPwm3Regs.TZDCSEL.bit.DCAEVT1            = 0;          // Digital Compare Output A Event 1
       EPwm3Regs.TZDCSEL.bit.DCAEVT2            = 0;          // Digital Compare Output A Event 2
       EPwm3Regs.TZDCSEL.bit.DCBEVT1            = 0;          // Digital Compare Output B Event 1
       EPwm3Regs.TZDCSEL.bit.DCBEVT2            = 0;          // Digital Compare Output B Event 2
     */
    EPwm3Regs.TZDCSEL.all = (EPwm3Regs.TZDCSEL.all & ~0xFFF) | 0x0;

    /*	// Digital Compare Filter Control Register
       EPwm3Regs.DCFCTL.bit.BLANKE              = 0;          // Blanking Enable/Disable
       EPwm3Regs.DCFCTL.bit.PULSESEL            = 1;          // Pulse Select for Blanking & Capture Alignment
       EPwm3Regs.DCFCTL.bit.BLANKINV            = 0;          // Blanking Window Inversion
       EPwm3Regs.DCFCTL.bit.SRCSEL              = 0;          // Filter Block Signal Source Select
     */
    EPwm3Regs.DCFCTL.all = (EPwm3Regs.DCFCTL.all & ~0x3F) | 0x10;
    EPwm3Regs.DCFOFFSET = 0;           // Digital Compare Filter Offset Register
    EPwm3Regs.DCFWINDOW = 0;           // Digital Compare Filter Window Register

    /*	// Digital Compare Capture Control Register
       EPwm3Regs.DCCAPCTL.bit.CAPE              = 0;          // Counter Capture Enable
     */
    EPwm3Regs.DCCAPCTL.all = (EPwm3Regs.DCCAPCTL.all & ~0x1) | 0x0;

    /*	// HRPWM Configuration Register
       EPwm3Regs.HRCNFG.bit.SWAPAB              = 0;          // Swap EPWMA and EPWMB Outputs Bit
       EPwm3Regs.HRCNFG.bit.SELOUTB             = 0;          // EPWMB Output Selection Bit
     */
    EPwm3Regs.HRCNFG.all = (EPwm3Regs.HRCNFG.all & ~0xA0) | 0x0;
    EDIS;
  }

  /* Start for S-Function (c2802xpwm): '<S3>/ePWM4' incorporates:
   *  Constant: '<S3>/Constant3'
   */

  /*** Initialize ePWM5 modules ***/
  {
    /*  // Time Base Control Register
       EPwm5Regs.TBCTL.bit.CTRMODE              = 0;          // Counter Mode
       EPwm5Regs.TBCTL.bit.SYNCOSEL             = 3;          // Sync Output Select
       EPwm5Regs.TBCTL.bit.PRDLD                = 0;          // Shadow select
       EPwm5Regs.TBCTL.bit.PHSEN                = 1;          // Phase Load Enable
       EPwm5Regs.TBCTL.bit.PHSDIR               = 0;          // Phase Direction Bit
       EPwm5Regs.TBCTL.bit.HSPCLKDIV            = 0;          // High Speed TBCLK Pre-scaler
       EPwm5Regs.TBCTL.bit.CLKDIV               = 0;          // Time Base Clock Pre-scaler
       EPwm5Regs.TBCTL.bit.SWFSYNC              = 0;          // Software Force Sync Pulse
     */
    EPwm5Regs.TBCTL.all = (EPwm5Regs.TBCTL.all & ~0x3FFF) | 0x34;

    /*-- Setup Time-Base (TB) Submodule --*/
    EPwm5Regs.TBPRD = 3999;            // Time Base Period Register

    /* // Time-Base Phase Register
       EPwm5Regs.TBPHS.half.TBPHS               = 0;          // Phase offset register
     */
    EPwm5Regs.TBPHS.all = (EPwm5Regs.TBPHS.all & ~0xFFFF0000) | 0x0;

    // Time Base Counter Register
    EPwm5Regs.TBCTR = 0x0000;          /* Clear counter*/

    /*-- Setup Counter_Compare (CC) Submodule --*/
    /*	// Counter Compare Control Register
       EPwm5Regs.CMPCTL.bit.SHDWAMODE           = 0;  // Compare A Register Block Operating Mode
       EPwm5Regs.CMPCTL.bit.SHDWBMODE           = 0;  // Compare B Register Block Operating Mode
       EPwm5Regs.CMPCTL.bit.LOADAMODE           = 0;          // Active Compare A Load
       EPwm5Regs.CMPCTL.bit.LOADBMODE           = 0;          // Active Compare B Load
     */
    EPwm5Regs.CMPCTL.all = (EPwm5Regs.CMPCTL.all & ~0x5F) | 0x0;
    EPwm5Regs.CMPA.half.CMPA = 0;      // Counter Compare A Register
    EPwm5Regs.CMPB = 32000;            // Counter Compare B Register

    /*-- Setup Action-Qualifier (AQ) Submodule --*/
    EPwm5Regs.AQCTLA.all = 0;          // Action Qualifier Control Register For Output A
    EPwm5Regs.AQCTLB.all = 2310;       // Action Qualifier Control Register For Output B

    /*	// Action Qualifier Software Force Register
       EPwm5Regs.AQSFRC.bit.RLDCSF              = 0;          // Reload from Shadow Options
     */
    EPwm5Regs.AQSFRC.all = (EPwm5Regs.AQSFRC.all & ~0xC0) | 0x0;

    /*	// Action Qualifier Continuous S/W Force Register
       EPwm5Regs.AQCSFRC.bit.CSFA               = 0;          // Continuous Software Force on output A
       EPwm5Regs.AQCSFRC.bit.CSFB               = 0;          // Continuous Software Force on output B
     */
    EPwm5Regs.AQCSFRC.all = (EPwm5Regs.AQCSFRC.all & ~0xF) | 0x0;

    /*-- Setup Dead-Band Generator (DB) Submodule --*/
    /*	// Dead-Band Generator Control Register
       EPwm5Regs.DBCTL.bit.OUT_MODE             = 0;          // Dead Band Output Mode Control
       EPwm5Regs.DBCTL.bit.IN_MODE              = 0;          // Dead Band Input Select Mode Control
       EPwm5Regs.DBCTL.bit.POLSEL               = 0;          // Polarity Select Control
       EPwm5Regs.DBCTL.bit.HALFCYCLE            = 0;          // Half Cycle Clocking Enable
     */
    EPwm5Regs.DBCTL.all = (EPwm5Regs.DBCTL.all & ~0x803F) | 0x0;
    EPwm5Regs.DBRED = 0;               // Dead-Band Generator Rising Edge Delay Count Register
    EPwm5Regs.DBFED = 0;               // Dead-Band Generator Falling Edge Delay Count Register

    /*-- Setup Event-Trigger (ET) Submodule --*/
    /*	// Event Trigger Selection and Pre-Scale Register
       EPwm5Regs.ETSEL.bit.SOCAEN               = 1;          // Start of Conversion A Enable
       EPwm5Regs.ETSEL.bit.SOCASEL              = 4;          // Start of Conversion A Select
       EPwm5Regs.ETPS.bit.SOCAPRD               = 1;          // EPWM5SOCA Period Select

       EPwm5Regs.ETSEL.bit.SOCBEN               = 0;          // Start of Conversion B Enable

       EPwm5Regs.ETSEL.bit.SOCBSEL              = 1;          // Start of Conversion B Select
       EPwm5Regs.ETPS.bit.SOCBPRD               = 1;          // EPWM5SOCB Period Select
       EPwm5Regs.ETSEL.bit.INTEN                = 0;          // EPWM5INTn Enable
       EPwm5Regs.ETSEL.bit.INTSEL               = 1;          // EPWM5INTn Select

       EPwm5Regs.ETPS.bit.INTPRD                = 1;          // EPWM5INTn Period Select
     */
    EPwm5Regs.ETSEL.all = (EPwm5Regs.ETSEL.all & ~0xFF0F) | 0x1C01;
    EPwm5Regs.ETPS.all = (EPwm5Regs.ETPS.all & ~0x3303) | 0x1101;

    /*-- Setup PWM-Chopper (PC) Submodule --*/
    /*	// PWM Chopper Control Register
       EPwm5Regs.PCCTL.bit.CHPEN                = 0;          // PWM chopping enable
       EPwm5Regs.PCCTL.bit.CHPFREQ              = 0;          // Chopping clock frequency
       EPwm5Regs.PCCTL.bit.OSHTWTH              = 0;          // One-shot pulse width
       EPwm5Regs.PCCTL.bit.CHPDUTY              = 0;          // Chopping clock Duty cycle
     */
    EPwm5Regs.PCCTL.all = (EPwm5Regs.PCCTL.all & ~0x7FF) | 0x0;

    /*-- Set up Trip-Zone (TZ) Submodule --*/
    EALLOW;
    EPwm5Regs.TZSEL.all = 0;           // Trip Zone Select Register

    /*	// Trip Zone Control Register
       EPwm5Regs.TZCTL.bit.TZA                  = 3;          // TZ1 to TZ6 Trip Action On EPWM5A
       EPwm5Regs.TZCTL.bit.TZB                  = 3;          // TZ1 to TZ6 Trip Action On EPWM5B
       EPwm5Regs.TZCTL.bit.DCAEVT1              = 3;          // EPWM5A action on DCAEVT1
       EPwm5Regs.TZCTL.bit.DCAEVT2              = 3;          // EPWM5A action on DCAEVT2
       EPwm5Regs.TZCTL.bit.DCBEVT1              = 3;          // EPWM5B action on DCBEVT1
       EPwm5Regs.TZCTL.bit.DCBEVT2              = 3;          // EPWM5B action on DCBEVT2
     */
    EPwm5Regs.TZCTL.all = (EPwm5Regs.TZCTL.all & ~0xFFF) | 0xFFF;

    /*	// Trip Zone Enable Interrupt Register
       EPwm5Regs.TZEINT.bit.OST                 = 0;          // Trip Zones One Shot Int Enable
       EPwm5Regs.TZEINT.bit.CBC                 = 0;          // Trip Zones Cycle By Cycle Int Enable
       EPwm5Regs.TZEINT.bit.DCAEVT1             = 0;          // Digital Compare A Event 1 Int Enable
       EPwm5Regs.TZEINT.bit.DCAEVT2             = 0;          // Digital Compare A Event 2 Int Enable
       EPwm5Regs.TZEINT.bit.DCBEVT1             = 0;          // Digital Compare B Event 1 Int Enable
       EPwm5Regs.TZEINT.bit.DCBEVT2             = 0;          // Digital Compare B Event 2 Int Enable
     */
    EPwm5Regs.TZEINT.all = (EPwm5Regs.TZEINT.all & ~0x7E) | 0x0;

    /*	// Digital Compare A Control Register
       EPwm5Regs.DCACTL.bit.EVT1SYNCE           = 0;          // DCAEVT1 SYNC Enable
       EPwm5Regs.DCACTL.bit.EVT1SOCE            = 0;          // DCAEVT1 SOC Enable
       EPwm5Regs.DCACTL.bit.EVT1FRCSYNCSEL      = 0;          // DCAEVT1 Force Sync Signal
       EPwm5Regs.DCACTL.bit.EVT1SRCSEL          = 0;          // DCAEVT1 Source Signal
       EPwm5Regs.DCACTL.bit.EVT2FRCSYNCSEL      = 0;          // DCAEVT2 Force Sync Signal
       EPwm5Regs.DCACTL.bit.EVT2SRCSEL          = 0;          // DCAEVT2 Source Signal
     */
    EPwm5Regs.DCACTL.all = (EPwm5Regs.DCACTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare B Control Register
       EPwm5Regs.DCBCTL.bit.EVT1SYNCE           = 0;          // DCBEVT1 SYNC Enable
       EPwm5Regs.DCBCTL.bit.EVT1SOCE            = 0;          // DCBEVT1 SOC Enable
       EPwm5Regs.DCBCTL.bit.EVT1FRCSYNCSEL      = 0;          // DCBEVT1 Force Sync Signal
       EPwm5Regs.DCBCTL.bit.EVT1SRCSEL          = 0;          // DCBEVT1 Source Signal
       EPwm5Regs.DCBCTL.bit.EVT2FRCSYNCSEL      = 0;          // DCBEVT2 Force Sync Signal
       EPwm5Regs.DCBCTL.bit.EVT2SRCSEL          = 0;          // DCBEVT2 Source Signal
     */
    EPwm5Regs.DCBCTL.all = (EPwm5Regs.DCBCTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare Trip Select Register
       EPwm5Regs.DCTRIPSEL.bit.DCAHCOMPSEL      = 0;          // Digital Compare A High COMP Input Select

       EPwm5Regs.DCTRIPSEL.bit.DCALCOMPSEL      = 1;          // Digital Compare A Low COMP Input Select
       EPwm5Regs.DCTRIPSEL.bit.DCBHCOMPSEL      = 0;          // Digital Compare B High COMP Input Select
       EPwm5Regs.DCTRIPSEL.bit.DCBLCOMPSEL      = 1;          // Digital Compare B Low COMP Input Select
     */
    EPwm5Regs.DCTRIPSEL.all = (EPwm5Regs.DCTRIPSEL.all & ~ 0xFFFF) | 0x1010;

    /*	// Trip Zone Digital Comparator Select Register
       EPwm5Regs.TZDCSEL.bit.DCAEVT1            = 0;          // Digital Compare Output A Event 1
       EPwm5Regs.TZDCSEL.bit.DCAEVT2            = 0;          // Digital Compare Output A Event 2
       EPwm5Regs.TZDCSEL.bit.DCBEVT1            = 0;          // Digital Compare Output B Event 1
       EPwm5Regs.TZDCSEL.bit.DCBEVT2            = 0;          // Digital Compare Output B Event 2
     */
    EPwm5Regs.TZDCSEL.all = (EPwm5Regs.TZDCSEL.all & ~0xFFF) | 0x0;

    /*	// Digital Compare Filter Control Register
       EPwm5Regs.DCFCTL.bit.BLANKE              = 0;          // Blanking Enable/Disable
       EPwm5Regs.DCFCTL.bit.PULSESEL            = 1;          // Pulse Select for Blanking & Capture Alignment
       EPwm5Regs.DCFCTL.bit.BLANKINV            = 0;          // Blanking Window Inversion
       EPwm5Regs.DCFCTL.bit.SRCSEL              = 0;          // Filter Block Signal Source Select
     */
    EPwm5Regs.DCFCTL.all = (EPwm5Regs.DCFCTL.all & ~0x3F) | 0x10;
    EPwm5Regs.DCFOFFSET = 0;           // Digital Compare Filter Offset Register
    EPwm5Regs.DCFWINDOW = 0;           // Digital Compare Filter Window Register

    /*	// Digital Compare Capture Control Register
       EPwm5Regs.DCCAPCTL.bit.CAPE              = 0;          // Counter Capture Enable
     */
    EPwm5Regs.DCCAPCTL.all = (EPwm5Regs.DCCAPCTL.all & ~0x1) | 0x0;

    /*	// HRPWM Configuration Register
       EPwm5Regs.HRCNFG.bit.SWAPAB              = 0;          // Swap EPWMA and EPWMB Outputs Bit
       EPwm5Regs.HRCNFG.bit.SELOUTB             = 0;          // EPWMB Output Selection Bit
     */
    EPwm5Regs.HRCNFG.all = (EPwm5Regs.HRCNFG.all & ~0xA0) | 0x0;
    EDIS;
  }

  /* Start for S-Function (c2802xpwm): '<S3>/ePWM3' incorporates:
   *  Constant: '<S3>/Constant4'
   */

  /*** Initialize ePWM4 modules ***/
  {
    /*  // Time Base Control Register
       EPwm4Regs.TBCTL.bit.CTRMODE              = 2;          // Counter Mode
       EPwm4Regs.TBCTL.bit.SYNCOSEL             = 0;          // Sync Output Select
       EPwm4Regs.TBCTL.bit.PRDLD                = 0;          // Shadow select
       EPwm4Regs.TBCTL.bit.PHSEN                = 1;          // Phase Load Enable
       EPwm4Regs.TBCTL.bit.PHSDIR               = 0;          // Phase Direction Bit
       EPwm4Regs.TBCTL.bit.HSPCLKDIV            = 0;          // High Speed TBCLK Pre-scaler
       EPwm4Regs.TBCTL.bit.CLKDIV               = 0;          // Time Base Clock Pre-scaler
       EPwm4Regs.TBCTL.bit.SWFSYNC              = 0;          // Software Force Sync Pulse
     */
    EPwm4Regs.TBCTL.all = (EPwm4Regs.TBCTL.all & ~0x3FFF) | 0x6;

    /*-- Setup Time-Base (TB) Submodule --*/
    EPwm4Regs.TBPRD = 4000;            // Time Base Period Register

    /* // Time-Base Phase Register
       EPwm4Regs.TBPHS.half.TBPHS               = 0;          // Phase offset register
     */
    EPwm4Regs.TBPHS.all = (EPwm4Regs.TBPHS.all & ~0xFFFF0000) | 0x0;

    // Time Base Counter Register
    EPwm4Regs.TBCTR = 0x0000;          /* Clear counter*/

    /*-- Setup Counter_Compare (CC) Submodule --*/
    /*	// Counter Compare Control Register
       EPwm4Regs.CMPCTL.bit.SHDWAMODE           = 0;  // Compare A Register Block Operating Mode
       EPwm4Regs.CMPCTL.bit.SHDWBMODE           = 0;  // Compare B Register Block Operating Mode
       EPwm4Regs.CMPCTL.bit.LOADAMODE           = 0;          // Active Compare A Load
       EPwm4Regs.CMPCTL.bit.LOADBMODE           = 0;          // Active Compare B Load
     */
    EPwm4Regs.CMPCTL.all = (EPwm4Regs.CMPCTL.all & ~0x5F) | 0x0;
    EPwm4Regs.CMPA.half.CMPA = 0;      // Counter Compare A Register
    EPwm4Regs.CMPB = 32000;            // Counter Compare B Register

    /*-- Setup Action-Qualifier (AQ) Submodule --*/
    EPwm4Regs.AQCTLA.all = 144;        // Action Qualifier Control Register For Output A
    EPwm4Regs.AQCTLB.all = 2310;       // Action Qualifier Control Register For Output B

    /*	// Action Qualifier Software Force Register
       EPwm4Regs.AQSFRC.bit.RLDCSF              = 0;          // Reload from Shadow Options
     */
    EPwm4Regs.AQSFRC.all = (EPwm4Regs.AQSFRC.all & ~0xC0) | 0x0;

    /*	// Action Qualifier Continuous S/W Force Register
       EPwm4Regs.AQCSFRC.bit.CSFA               = 0;          // Continuous Software Force on output A
       EPwm4Regs.AQCSFRC.bit.CSFB               = 0;          // Continuous Software Force on output B
     */
    EPwm4Regs.AQCSFRC.all = (EPwm4Regs.AQCSFRC.all & ~0xF) | 0x0;

    /*-- Setup Dead-Band Generator (DB) Submodule --*/
    /*	// Dead-Band Generator Control Register
       EPwm4Regs.DBCTL.bit.OUT_MODE             = 3;          // Dead Band Output Mode Control
       EPwm4Regs.DBCTL.bit.IN_MODE              = 0;          // Dead Band Input Select Mode Control
       EPwm4Regs.DBCTL.bit.POLSEL               = 2;          // Polarity Select Control
       EPwm4Regs.DBCTL.bit.HALFCYCLE            = 0;          // Half Cycle Clocking Enable
     */
    EPwm4Regs.DBCTL.all = (EPwm4Regs.DBCTL.all & ~0x803F) | 0xB;
    EPwm4Regs.DBRED = 0;               // Dead-Band Generator Rising Edge Delay Count Register
    EPwm4Regs.DBFED = 0;               // Dead-Band Generator Falling Edge Delay Count Register

    /*-- Setup Event-Trigger (ET) Submodule --*/
    /*	// Event Trigger Selection and Pre-Scale Register
       EPwm4Regs.ETSEL.bit.SOCAEN               = 0;          // Start of Conversion A Enable
       EPwm4Regs.ETSEL.bit.SOCASEL              = 0;          // Start of Conversion A Select
       EPwm4Regs.ETPS.bit.SOCAPRD               = 1;          // EPWM4SOCA Period Select

       EPwm4Regs.ETSEL.bit.SOCBEN               = 0;          // Start of Conversion B Enable

       EPwm4Regs.ETSEL.bit.SOCBSEL              = 1;          // Start of Conversion B Select
       EPwm4Regs.ETPS.bit.SOCBPRD               = 1;          // EPWM4SOCB Period Select
       EPwm4Regs.ETSEL.bit.INTEN                = 0;          // EPWM4INTn Enable
       EPwm4Regs.ETSEL.bit.INTSEL               = 1;          // EPWM4INTn Select

       EPwm4Regs.ETPS.bit.INTPRD                = 1;          // EPWM4INTn Period Select
     */
    EPwm4Regs.ETSEL.all = (EPwm4Regs.ETSEL.all & ~0xFF0F) | 0x1001;
    EPwm4Regs.ETPS.all = (EPwm4Regs.ETPS.all & ~0x3303) | 0x1101;

    /*-- Setup PWM-Chopper (PC) Submodule --*/
    /*	// PWM Chopper Control Register
       EPwm4Regs.PCCTL.bit.CHPEN                = 0;          // PWM chopping enable
       EPwm4Regs.PCCTL.bit.CHPFREQ              = 0;          // Chopping clock frequency
       EPwm4Regs.PCCTL.bit.OSHTWTH              = 0;          // One-shot pulse width
       EPwm4Regs.PCCTL.bit.CHPDUTY              = 0;          // Chopping clock Duty cycle
     */
    EPwm4Regs.PCCTL.all = (EPwm4Regs.PCCTL.all & ~0x7FF) | 0x0;

    /*-- Set up Trip-Zone (TZ) Submodule --*/
    EALLOW;
    EPwm4Regs.TZSEL.all = 0;           // Trip Zone Select Register

    /*	// Trip Zone Control Register
       EPwm4Regs.TZCTL.bit.TZA                  = 3;          // TZ1 to TZ6 Trip Action On EPWM4A
       EPwm4Regs.TZCTL.bit.TZB                  = 3;          // TZ1 to TZ6 Trip Action On EPWM4B
       EPwm4Regs.TZCTL.bit.DCAEVT1              = 3;          // EPWM4A action on DCAEVT1
       EPwm4Regs.TZCTL.bit.DCAEVT2              = 3;          // EPWM4A action on DCAEVT2
       EPwm4Regs.TZCTL.bit.DCBEVT1              = 3;          // EPWM4B action on DCBEVT1
       EPwm4Regs.TZCTL.bit.DCBEVT2              = 3;          // EPWM4B action on DCBEVT2
     */
    EPwm4Regs.TZCTL.all = (EPwm4Regs.TZCTL.all & ~0xFFF) | 0xFFF;

    /*	// Trip Zone Enable Interrupt Register
       EPwm4Regs.TZEINT.bit.OST                 = 0;          // Trip Zones One Shot Int Enable
       EPwm4Regs.TZEINT.bit.CBC                 = 0;          // Trip Zones Cycle By Cycle Int Enable
       EPwm4Regs.TZEINT.bit.DCAEVT1             = 0;          // Digital Compare A Event 1 Int Enable
       EPwm4Regs.TZEINT.bit.DCAEVT2             = 0;          // Digital Compare A Event 2 Int Enable
       EPwm4Regs.TZEINT.bit.DCBEVT1             = 0;          // Digital Compare B Event 1 Int Enable
       EPwm4Regs.TZEINT.bit.DCBEVT2             = 0;          // Digital Compare B Event 2 Int Enable
     */
    EPwm4Regs.TZEINT.all = (EPwm4Regs.TZEINT.all & ~0x7E) | 0x0;

    /*	// Digital Compare A Control Register
       EPwm4Regs.DCACTL.bit.EVT1SYNCE           = 0;          // DCAEVT1 SYNC Enable
       EPwm4Regs.DCACTL.bit.EVT1SOCE            = 1;          // DCAEVT1 SOC Enable
       EPwm4Regs.DCACTL.bit.EVT1FRCSYNCSEL      = 0;          // DCAEVT1 Force Sync Signal
       EPwm4Regs.DCACTL.bit.EVT1SRCSEL          = 0;          // DCAEVT1 Source Signal
       EPwm4Regs.DCACTL.bit.EVT2FRCSYNCSEL      = 0;          // DCAEVT2 Force Sync Signal
       EPwm4Regs.DCACTL.bit.EVT2SRCSEL          = 0;          // DCAEVT2 Source Signal
     */
    EPwm4Regs.DCACTL.all = (EPwm4Regs.DCACTL.all & ~0x30F) | 0x4;

    /*	// Digital Compare B Control Register
       EPwm4Regs.DCBCTL.bit.EVT1SYNCE           = 0;          // DCBEVT1 SYNC Enable
       EPwm4Regs.DCBCTL.bit.EVT1SOCE            = 0;          // DCBEVT1 SOC Enable
       EPwm4Regs.DCBCTL.bit.EVT1FRCSYNCSEL      = 0;          // DCBEVT1 Force Sync Signal
       EPwm4Regs.DCBCTL.bit.EVT1SRCSEL          = 0;          // DCBEVT1 Source Signal
       EPwm4Regs.DCBCTL.bit.EVT2FRCSYNCSEL      = 0;          // DCBEVT2 Force Sync Signal
       EPwm4Regs.DCBCTL.bit.EVT2SRCSEL          = 0;          // DCBEVT2 Source Signal
     */
    EPwm4Regs.DCBCTL.all = (EPwm4Regs.DCBCTL.all & ~0x30F) | 0x0;

    /*	// Digital Compare Trip Select Register
       EPwm4Regs.DCTRIPSEL.bit.DCAHCOMPSEL      = 0;          // Digital Compare A High COMP Input Select

       EPwm4Regs.DCTRIPSEL.bit.DCALCOMPSEL      = 1;          // Digital Compare A Low COMP Input Select
       EPwm4Regs.DCTRIPSEL.bit.DCBHCOMPSEL      = 0;          // Digital Compare B High COMP Input Select
       EPwm4Regs.DCTRIPSEL.bit.DCBLCOMPSEL      = 1;          // Digital Compare B Low COMP Input Select
     */
    EPwm4Regs.DCTRIPSEL.all = (EPwm4Regs.DCTRIPSEL.all & ~ 0xFFFF) | 0x1010;

    /*	// Trip Zone Digital Comparator Select Register
       EPwm4Regs.TZDCSEL.bit.DCAEVT1            = 0;          // Digital Compare Output A Event 1
       EPwm4Regs.TZDCSEL.bit.DCAEVT2            = 0;          // Digital Compare Output A Event 2
       EPwm4Regs.TZDCSEL.bit.DCBEVT1            = 0;          // Digital Compare Output B Event 1
       EPwm4Regs.TZDCSEL.bit.DCBEVT2            = 0;          // Digital Compare Output B Event 2
     */
    EPwm4Regs.TZDCSEL.all = (EPwm4Regs.TZDCSEL.all & ~0xFFF) | 0x0;

    /*	// Digital Compare Filter Control Register
       EPwm4Regs.DCFCTL.bit.BLANKE              = 0;          // Blanking Enable/Disable
       EPwm4Regs.DCFCTL.bit.PULSESEL            = 1;          // Pulse Select for Blanking & Capture Alignment
       EPwm4Regs.DCFCTL.bit.BLANKINV            = 0;          // Blanking Window Inversion
       EPwm4Regs.DCFCTL.bit.SRCSEL              = 0;          // Filter Block Signal Source Select
     */
    EPwm4Regs.DCFCTL.all = (EPwm4Regs.DCFCTL.all & ~0x3F) | 0x10;
    EPwm4Regs.DCFOFFSET = 0;           // Digital Compare Filter Offset Register
    EPwm4Regs.DCFWINDOW = 0;           // Digital Compare Filter Window Register

    /*	// Digital Compare Capture Control Register
       EPwm4Regs.DCCAPCTL.bit.CAPE              = 0;          // Counter Capture Enable
     */
    EPwm4Regs.DCCAPCTL.all = (EPwm4Regs.DCCAPCTL.all & ~0x1) | 0x0;

    /*	// HRPWM Configuration Register
       EPwm4Regs.HRCNFG.bit.SWAPAB              = 0;          // Swap EPWMA and EPWMB Outputs Bit
       EPwm4Regs.HRCNFG.bit.SELOUTB             = 0;          // EPWMB Output Selection Bit
     */
    EPwm4Regs.HRCNFG.all = (EPwm4Regs.HRCNFG.all & ~0xA0) | 0x0;
    EDIS;
  }

  /* End of Start for SubSystem: '<Root>/PWM' */

  /* Start for Function Call SubSystem: '<Root>/ReadAnalogInputs' */

  /* Start for S-Function (c2802xadc): '<S4>/ADC' */
  if (adcInitFlag == 0) {
    InitAdc();
    adcInitFlag = 1;
  }

  config_ADC_SOC0 ();

  /* Start for S-Function (c2802xadc): '<S4>/ADC1' */
  if (adcInitFlag == 0) {
    InitAdc();
    adcInitFlag = 1;
  }

  config_ADC_SOC1 ();

  /* Start for S-Function (c2802xadc): '<S4>/ADC2' */
  if (adcInitFlag == 0) {
    InitAdc();
    adcInitFlag = 1;
  }

  config_ADC_SOC2 ();

  /* Start for S-Function (c2802xadc): '<S4>/UdcADC' */
  if (adcInitFlag == 0) {
    InitAdc();
    adcInitFlag = 1;
  }

  config_ADC_SOC3 ();

  /* Start for S-Function (c280xqep): '<S4>/eQEP1' */
  config_QEP_eQEP2(4095U, 0, 0, 0, 0, 0, 8, 32768, 119, 0);

  /* End of Start for SubSystem: '<Root>/ReadAnalogInputs' */

  /* End of Start for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' */

  /* Start for S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_pre'
   */

  /* Start for S-Function (c280xgpio_di): '<S8>/Digital Input' */
  EALLOW;
  GpioCtrlRegs.GPBMUX2.all &= 0xFFFF0FFF;
  GpioCtrlRegs.GPBDIR.all &= 0xFF3FFFFF;
  EDIS;

  /* Start for S-Function (c280xgpio_di): '<S8>/Digital Input1' */
  EALLOW;
  GpioCtrlRegs.GPBMUX2.all &= 0xFFF0FFFF;
  GpioCtrlRegs.GPBDIR.all &= 0xFCFFFFFF;
  EDIS;

  /* Start for S-Function (c280xgpio_di): '<S8>/Digital Input2' */
  EALLOW;
  GpioCtrlRegs.GPBMUX1.all &= 0xFF00FFFF;
  GpioCtrlRegs.GPBDIR.all &= 0xFFFFF0FF;
  EDIS;

  /* Start for DataStoreMemory: '<Root>/Data Store Memory3' */
  AnalogChA = Controller_DSP_ConstP.DataStoreMemory3_InitialValue;

  /* user code (Initialize function Body) */

  /* System '<Root>' */
  AMER_init();

  /* SystemInitialize for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' incorporates:
   *  Chart: '<Root>/Scheduler'
   */

  /* SystemInitialize for Chart: '<Root>/Scheduler' */
  /* System initialize for function-call system: '<Root>/Scheduler' */

  /* Asynchronous task reads absolute time. Data (absolute time)
     transfers from low priority task (base rate) to high priority
     task (asynchronous rate). Double buffers are used to ensure
     data integrity.
     -- rtmL2HLastBufWr is the buffer index that is written last.
   */
  Controller_DSP_M->Timing.clockTick3 =
    Controller_DSP_M->Timing.rtmL2HDbBufClockTick
    [Controller_DSP_M->Timing.rtmL2HLastBufWr];

  /* SystemInitialize for Function Call SubSystem: '<S2>/PMSM_FOC' */
  /* InitializeConditions for DiscreteIntegrator: '<S15>/Integrator' */
  Controller_DSP_DW.Integrator_PREV_U = 0.0F;

  /* InitializeConditions for DiscreteIntegrator: '<S17>/Integrator' */
  Controller_DSP_DW.Integrator_PREV_U_o = 0.0F;

  /* End of SystemInitialize for SubSystem: '<S2>/PMSM_FOC' */

  /* End of SystemInitialize for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' */

  /* SystemInitialize for S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_pre'
   */

  /* Enable for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' incorporates:
   *  Chart: '<Root>/Scheduler'
   */

  /* Enable for Chart: '<Root>/Scheduler' */
  /* Enable for function-call system: '<Root>/Scheduler' */

  /* Asynchronous task reads absolute time. Data (absolute time)
     transfers from low priority task (base rate) to high priority
     task (asynchronous rate). Double buffers are used to ensure
     data integrity.
     -- rtmL2HLastBufWr is the buffer index that is written last.
   */
  Controller_DSP_M->Timing.clockTick3 =
    Controller_DSP_M->Timing.rtmL2HDbBufClockTick
    [Controller_DSP_M->Timing.rtmL2HLastBufWr];

  /* Enable for Function Call SubSystem: '<S2>/PMSM_FOC' */
  Controller_DSP_DW.PMSM_FOC_RESET_ELAPS_T = true;

  /* Enable for DiscreteIntegrator: '<S15>/Integrator' */
  Controller_DSP_DW.Integrator_SYSTEM_ENABLE = 1U;

  /* Enable for DiscreteIntegrator: '<S17>/Integrator' */
  Controller_DSP_DW.Integrator_SYSTEM_ENABLE_d = 1U;

  /* End of Enable for SubSystem: '<S2>/PMSM_FOC' */

  /* End of Enable for S-Function (c28xisr_c2000): '<Root>/C28x Hardware Interrupt' */
}

/* Model terminate function */
void Controller_DSP_terminate(void)
{
  /* Terminate for S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_pre'
   */

  /* CleanupRuntimeResources for S-Function (fcncallgen): '<Root>/Function-Call Generator' incorporates:
   *  SubSystem: '<Root>/Task_1ms_pre'
   */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
