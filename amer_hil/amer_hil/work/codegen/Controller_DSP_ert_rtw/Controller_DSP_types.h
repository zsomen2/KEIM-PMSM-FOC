/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Controller_DSP_types.h
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

#ifndef RTW_HEADER_Controller_DSP_types_h_
#define RTW_HEADER_Controller_DSP_types_h_
#include "rtwtypes.h"
#ifndef DEFINED_TYPEDEF_FOR_CPLDOutput_t_
#define DEFINED_TYPEDEF_FOR_CPLDOutput_t_

typedef struct {
  boolean_T MASK4;
  boolean_T MASK3;
  boolean_T MASK2;
  boolean_T MASK1;
  boolean_T GreenLED;
  boolean_T BlueLED;
  boolean_T RedLED;
  boolean_T YellowLED;
  boolean_T GPOUT6;
  boolean_T GPOUT5;
  boolean_T GPOUT4;
  boolean_T GPOUT3;
  boolean_T GPOUT2;
  boolean_T GPOUT1;
  boolean_T GPOUT0;
} CPLDOutput_t;

#endif

#ifndef DEFINED_TYPEDEF_FOR_CPLDInput_t_
#define DEFINED_TYPEDEF_FOR_CPLDInput_t_

typedef struct {
  uint16_T FAIL;
  boolean_T ENC1SW;
  boolean_T GPIN6;
  boolean_T GPIN5;
  boolean_T GPIN4;
  boolean_T GPIN3;
  boolean_T GPIN2;
  boolean_T GPIN1;
  boolean_T GPIN0;
} CPLDInput_t;

#endif

#ifndef DEFINED_TYPEDEF_FOR_Meas_t_
#define DEFINED_TYPEDEF_FOR_Meas_t_

typedef struct {
  real32_T value[3];
  real32_T gain[3];
  real32_T offset[3];
  real32_T comp[3];
} Meas_t;

#endif

/* Forward declaration for rtModel */
typedef struct tag_RTM_Controller_DSP_T RT_MODEL_Controller_DSP_T;

#endif                                 /* RTW_HEADER_Controller_DSP_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
