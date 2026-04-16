#ifndef __INIC_H_
  #define __INIC_H_
  #include "F2806x_Device.h"
  #include "F2806x_GlobalPrototypes.h"

  #define Device_cal (void   (*)(void))0x3D7C80
  extern volatile struct SCI_REGS *sci_ptr_terminal;

  /* Function declarations */
  void DeviceInit(void);
  void SetSCITMSmon(volatile struct SCI_REGS *ptr);
#endif
