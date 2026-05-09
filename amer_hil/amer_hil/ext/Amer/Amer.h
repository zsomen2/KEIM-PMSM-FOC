#ifndef _AMER_H_
	#define _AMER_H_

    #include "inic.h"     
    #include "MUCI.h"
    #include "MUCI_Recorder.h"
    #include "Term_Defs.h"
    #include "CPLDHandler.h"

    void AMER_init(void);
    void AMER_task_background(void);
    void AMER_task_adc(void);    
    void AMER_task_1ms(void);
    void AMER_task_1s(void);

    /* eQEP2 diagnostics (persistent across Simulink re-generation) */
    extern uint16_t amer_eqep2_qposcnt;
    extern uint16_t amer_eqep2_qpos_prev;
    extern int16_t amer_eqep2_qpos_delta;
    extern uint16_t amer_eqep2_qpos_abs_delta;
    extern uint32_t amer_eqep2_step_cnt;
    extern uint32_t amer_eqep2_glitch_cnt;
    extern uint16_t amer_eqep2_a;
    extern uint16_t amer_eqep2_b;
    extern uint16_t amer_eqep2_i;
    extern uint16_t amer_eqep2_qepsts;
    extern uint16_t amer_eqep2_qflg;
    extern uint16_t amer_eqep2_diag_clear;
#endif

