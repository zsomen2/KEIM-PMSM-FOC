/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Controller_DSP.h
 *
 * Code generated for Simulink model 'Controller_DSP'.
 *
 * Model version                  : 1.45
 * Simulink Coder version         : 9.0 (R2018b) 24-May-2018
 * C/C++ source code generated on : Fri Mar 27 14:23:44 2026
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Texas Instruments->C2000
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Controller_DSP_h_
#define RTW_HEADER_Controller_DSP_h_
#include <string.h>
#include <stddef.h>
#ifndef Controller_DSP_COMMON_INCLUDES_
# define Controller_DSP_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "c2000BoardSupport.h"
#include "F2806x_Device.h"
#include "F2806x_Examples.h"
#include "IQmathLib.h"
#include "F2806x_Gpio.h"
#endif                                 /* Controller_DSP_COMMON_INCLUDES_ */

#include "Controller_DSP_types.h"
#include "MW_target_hardware_resources.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmStepTask
# define rtmStepTask(rtm, idx)         ((rtm)->Timing.TaskCounters.TID[(idx)] == 0)
#endif

#ifndef rtmTaskCounter
# define rtmTaskCounter(rtm, idx)      ((rtm)->Timing.TaskCounters.TID[(idx)])
#endif

extern void config_ePWM_GPIO (void);

/* user code (top of header file) */
/* System '<Root>' */
#include "Amer.h"

/* Block signals (default storage) */
typedef struct {
  real32_T Iref_h;                     /* '<S11>/Delay1' */
  uint16_T ADC;                        /* '<S4>/ADC' */
  uint16_T ADC1;                       /* '<S4>/ADC1' */
  uint16_T ADC2;                       /* '<S4>/ADC2' */
  boolean_T Delay2;                    /* '<S11>/Delay2' */
  boolean_T start;                     /* '<S11>/Delay1' */
  boolean_T DigitalInput2[4];          /* '<S8>/Digital Input2' */
  boolean_T DigitalInput[2];           /* '<S8>/Digital Input' */
  boolean_T DigitalInput1[2];          /* '<S8>/Digital Input1' */
} B_Controller_DSP_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real32_T Delay1_1_DSTATE;            /* '<S11>/Delay1' */
  real32_T Delay3_DSTATE;              /* '<S10>/Delay3' */
  real32_T Delay1_DSTATE;              /* '<S10>/Delay1' */
  uint16_T Output_DSTATE;              /* '<S29>/Output' */
  uint16_T Output_DSTATE_f;            /* '<S13>/Output' */
  boolean_T Delay2_DSTATE[2];          /* '<S11>/Delay2' */
  boolean_T Delay1_2_DSTATE;           /* '<S11>/Delay1' */
} DW_Controller_DSP_T;

/* Constant parameters (default storage) */
typedef struct {
  /* Expression: AnalogChA_ini
   * Referenced by: '<Root>/Data Store Memory3'
   */
  Meas_t DataStoreMemory3_InitialValue;
} ConstP_Controller_DSP_T;

/* Real-time Model Data Structure */
struct tag_RTM_Controller_DSP_T {
  const char_T *errorStatus;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    struct {
      uint16_T TID[3];
    } TaskCounters;
  } Timing;
};

/* Block signals (default storage) */
extern B_Controller_DSP_T Controller_DSP_B;

/* Block states (default storage) */
extern DW_Controller_DSP_T Controller_DSP_DW;

/* External data declarations for dependent source files */
extern const CPLDOutput_t Controller_DSP_rtZCPLDOutput_t;/* CPLDOutput_t ground */
extern const CPLDInput_t Controller_DSP_rtZCPLDInput_t;/* CPLDInput_t ground */
extern const Meas_t Controller_DSP_rtZMeas_t;/* Meas_t ground */

/* Constant parameters (default storage) */
extern const ConstP_Controller_DSP_T Controller_DSP_ConstP;

/*
 * Exported Global Signals
 *
 * Note: Exported global signals are block signals with an exported global
 * storage class designation.  Code generation will declare the memory for
 * these signals and export their symbols.
 *
 */
extern uint16_T cnt_1s;                /* '<S29>/Output' */
extern uint16_T cnt_100ms;             /* '<S13>/Output' */
extern uint16_T CPLDOutBits;           /* '<S18>/bit_concat_unary' */
extern uint16_T Status;                /* '<S26>/bit_concat_unary' */
extern uint16_T Encoder;               /* '<S24>/bit_concat_unary' */

/*
 * Exported Global Parameters
 *
 * Note: Exported global parameters are tunable parameters with an exported
 * global storage class designation.  Code generation will declare the memory for
 * these parameters and exports their symbols.
 *
 */
extern real32_T A_I;                   /* Variable: A_I
                                        * Referenced by: '<S10>/Gain1'
                                        */
extern real32_T A_P;                   /* Variable: A_P
                                        * Referenced by: '<S10>/Gain'
                                        */
extern real32_T Iref;                  /* Variable: Iref
                                        * Referenced by: '<Root>/Constant'
                                        */
extern uint16_T delay;                 /* Variable: delay
                                        * Referenced by: '<S3>/Constant3'
                                        */
extern boolean_T Start;                /* Variable: Start
                                        * Referenced by: '<Root>/Constant2'
                                        */

/*
 * Exported States
 *
 * Note: Exported states are block states with an exported global
 * storage class designation.  Code generation will declare the memory for these
 * states and exports their symbols.
 *
 */
extern Meas_t AnalogChA;               /* '<Root>/Data Store Memory3' */
extern CPLDOutput_t CPLDOut;           /* '<Root>/Data Store Memory1' */
extern CPLDInput_t CPLDIn;             /* '<Root>/Data Store Memory2' */
extern uint16_T AdcStart;              /* '<Root>/Data Store Memory' */
extern uint16_T AdcStop;               /* '<Root>/Data Store Memory4' */

/* External function called from main */
extern void Controller_DSP_SetEventsForThisBaseStep(boolean_T *eventFlags);

/* Model entry point functions */
extern void Controller_DSP_SetEventsForThisBaseStep(boolean_T *eventFlags);
extern void Controller_DSP_initialize(void);
extern void Controller_DSP_step0(void);
extern void Controller_DSP_step1(void);
extern void Controller_DSP_step2(void);
extern void Controller_DSP_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Controller_DSP_T *const Controller_DSP_M;

/*-
 * These blocks were eliminated from the model due to optimizations:
 *
 * Block '<S12>/Data Type Duplicate' : Unused code path elimination
 * Block '<S12>/Data Type Propagation' : Unused code path elimination
 * Block '<S13>/FixPt Data Type Propagation' : Unused code path elimination
 * Block '<S14>/FixPt Data Type Duplicate' : Unused code path elimination
 * Block '<S15>/FixPt Data Type Duplicate1' : Unused code path elimination
 * Block '<S17>/FixPt Data Type Propagation' : Unused code path elimination
 * Block '<S20>/FixPt Constant' : Unused code path elimination
 * Block '<S20>/FixPt Data Type Duplicate' : Unused code path elimination
 * Block '<S20>/FixPt Sum1' : Unused code path elimination
 * Block '<S17>/Output' : Unused code path elimination
 * Block '<S21>/Constant' : Unused code path elimination
 * Block '<S21>/FixPt Data Type Duplicate1' : Unused code path elimination
 * Block '<S21>/FixPt Switch' : Unused code path elimination
 * Block '<S28>/DTProp1' : Unused code path elimination
 * Block '<S28>/DTProp2' : Unused code path elimination
 * Block '<S29>/FixPt Data Type Propagation' : Unused code path elimination
 * Block '<S30>/FixPt Data Type Duplicate' : Unused code path elimination
 * Block '<S31>/FixPt Data Type Duplicate1' : Unused code path elimination
 * Block '<S2>/Rate Transition' : Eliminated since input and output rates are identical
 * Block '<S2>/Rate Transition1' : Eliminated since input and output rates are identical
 * Block '<S2>/Rate Transition2' : Eliminated since input and output rates are identical
 * Block '<S28>/Modify Scaling Only' : Eliminate redundant data type conversion
 */

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Controller_DSP'
 * '<S1>'   : 'Controller_DSP/Background'
 * '<S2>'   : 'Controller_DSP/Controller'
 * '<S3>'   : 'Controller_DSP/PWM'
 * '<S4>'   : 'Controller_DSP/ReadAnalogInputs'
 * '<S5>'   : 'Controller_DSP/Scheduler'
 * '<S6>'   : 'Controller_DSP/Task_100ms_post'
 * '<S7>'   : 'Controller_DSP/Task_1ms_post'
 * '<S8>'   : 'Controller_DSP/Task_1ms_pre'
 * '<S9>'   : 'Controller_DSP/Task_1s_post'
 * '<S10>'  : 'Controller_DSP/Controller/CurrentControl'
 * '<S11>'  : 'Controller_DSP/Controller/StateMachine'
 * '<S12>'  : 'Controller_DSP/Controller/CurrentControl/Saturation Dynamic'
 * '<S13>'  : 'Controller_DSP/Task_100ms_post/counter_1ms'
 * '<S14>'  : 'Controller_DSP/Task_100ms_post/counter_1ms/Increment Real World'
 * '<S15>'  : 'Controller_DSP/Task_100ms_post/counter_1ms/Wrap To Zero'
 * '<S16>'  : 'Controller_DSP/Task_1ms_post/Bit Concat4'
 * '<S17>'  : 'Controller_DSP/Task_1ms_post/counter_1ms'
 * '<S18>'  : 'Controller_DSP/Task_1ms_post/Bit Concat4/bc4'
 * '<S19>'  : 'Controller_DSP/Task_1ms_post/Bit Concat4/bc4/bit_concat_unary'
 * '<S20>'  : 'Controller_DSP/Task_1ms_post/counter_1ms/Increment Real World'
 * '<S21>'  : 'Controller_DSP/Task_1ms_post/counter_1ms/Wrap To Zero'
 * '<S22>'  : 'Controller_DSP/Task_1ms_pre/Bit Concat1'
 * '<S23>'  : 'Controller_DSP/Task_1ms_pre/Bit Concat2'
 * '<S24>'  : 'Controller_DSP/Task_1ms_pre/Bit Concat1/bc4'
 * '<S25>'  : 'Controller_DSP/Task_1ms_pre/Bit Concat1/bc4/bit_concat_unary'
 * '<S26>'  : 'Controller_DSP/Task_1ms_pre/Bit Concat2/bc4'
 * '<S27>'  : 'Controller_DSP/Task_1ms_pre/Bit Concat2/bc4/bit_concat_unary'
 * '<S28>'  : 'Controller_DSP/Task_1s_post/Extract Bits'
 * '<S29>'  : 'Controller_DSP/Task_1s_post/counter_1s'
 * '<S30>'  : 'Controller_DSP/Task_1s_post/counter_1s/Increment Real World'
 * '<S31>'  : 'Controller_DSP/Task_1s_post/counter_1s/Wrap To Zero'
 */
#endif                                 /* RTW_HEADER_Controller_DSP_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
