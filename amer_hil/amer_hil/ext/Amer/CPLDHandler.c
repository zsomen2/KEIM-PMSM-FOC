/*
 * CPLDHandler.c
 *
 *  Created on: 2016 márc. 14
 *      Author: Szako
 */

#include "CPLDHandler.h"

CPLDDataIn_t CPLDInput;
CPLDDataOut_t CPLDOutput;
BridgeFault_t Bridge1_Fault;
BridgeFault_t Bridge2_Fault;
BridgeFault_t Bridge3_Fault;
BridgeFault_t Bridge4_Fault;

uint16_t cpld_cnt;

SPIStruct_t CPLDSPI = {&SpibRegs, 1000000L, SPI_MODE_A, DATALENGTH_16BIT}; //Nincs minden szál....

void CPLD_Init(void)
{
  SPI_Init(&CPLDSPI);

  CPLDInput.all = 0x0000;
  CPLDOutput.all = 0x0000;
  CPLDOutput.bit.MASK1 = 1 ;
  CPLDOutput.bit.MASK2 = 1 ;
  CPLDOutput.bit.MASK3 = 1 ;
  CPLDOutput.bit.MASK4 = 1 ;

  CPLD_DataExchange();
}



void CPLD_DataExchange(void)
{
  uint16_t dummy = 0;
  uint16_t Fault;
  
  cpld_cnt++;

  SPI_CS_Assert(LOW);
/*
  SPI_Transmit_16bit(&CPLDSPI, dummy);
  SPI_Receive_16bit(&CPLDSPI, &Fault1);
  SPI_Transmit_16bit(&CPLDSPI, dummy);
  SPI_Receive_16bit(&CPLDSPI, &Fault2);
  SPI_Transmit_16bit(&CPLDSPI, CPLDOutput.all);
  SPI_Receive_16bit(&CPLDSPI, &CPLDInput.all);
*/
  SPI_TransmitReceive_16bit(&CPLDSPI, dummy, &Fault);
  Bridge4_Fault.all = Fault >> 8;
  Bridge3_Fault.all = Fault & 0xFF;
  SPI_TransmitReceive_16bit(&CPLDSPI, dummy, &Fault);
  Bridge2_Fault.all = Fault >> 8;
  Bridge1_Fault.all = Fault & 0xFF;
  SPI_TransmitReceive_16bit(&CPLDSPI, CPLDOutput.all, &CPLDInput.all);

  //SPI_TransmitReceive_16bit(&CPLDSPI, CPLDOutput.all, &CPLDInput.all);

  SPI_CS_Assert(HIGH);
}
