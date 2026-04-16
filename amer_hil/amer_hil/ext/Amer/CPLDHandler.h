/*
 * CPLDHandler.h
 *
 *  Created on: 2016 márc. 14
 *      Author: Szako
 */

#ifndef INCLUDE_CPLDHANDLER_H_
  #define INCLUDE_CPLDHANDLER_H_

 // #include "gen_types.h"
  #include "SPI.h"

  struct CPLDDataInBITS
  {
    uint16_t GPIN0:1;
    uint16_t GPIN1:1;
    uint16_t GPIN2:1;
    uint16_t GPIN3:1;
    uint16_t GPIN4:1;
    uint16_t GPIN5:1;
    uint16_t GPIN6:1;
    uint16_t ENC1SW:1;
    uint16_t FAIL:4;
    uint16_t DUMMY:4;
  };

  typedef union
  {
    uint16_t all;
    struct CPLDDataInBITS bit;
  } CPLDDataIn_t;

  struct BridgeFaultBITS
  {
    uint16_t errorL:1;
    uint16_t errorH:1;
    uint16_t Udc_overvolt:1;
    uint16_t N_overcurrORH_overtemp:1;
    uint16_t P_overcurrORH_overtemp:1;
    uint16_t errorOvL:1;
    uint16_t errorOvH:1;
    uint16_t L_overtemp:1;
    uint16_t DUMMY:1;
  };

  typedef union
  {
    uint16_t all;
    struct BridgeFaultBITS bit;
  } BridgeFault_t;

  struct CPLDDataOutBITS
  {
    uint16_t GPOUT0:1;
    uint16_t GPOUT1:1;
    uint16_t GPOUT2:1;
    uint16_t GPOUT3:1;
    uint16_t GPOUT4:1;
    uint16_t GPOUT5:1;
    uint16_t GPOUT6:1;
    uint16_t LED1:1;	//yellow
    uint16_t LED2:1;	//red
    uint16_t LED3:1;	//blue
    uint16_t LED4:1;	//green
    uint16_t MASK1:1;
    uint16_t MASK2:1;
    uint16_t MASK3:1;
    uint16_t MASK4:1;
    uint16_t TMP:1;
  };

  typedef union
  {
    uint16_t all;
    struct CPLDDataOutBITS bit;
  } CPLDDataOut_t;

  extern CPLDDataIn_t CPLDInput;
  extern CPLDDataOut_t CPLDOutput;

  void CPLD_Init(void);
  void CPLD_DataExchange(void);

  #endif /* INCLUDE_CPLDHANDLER_H_ */
