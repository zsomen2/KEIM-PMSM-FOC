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
#endif

