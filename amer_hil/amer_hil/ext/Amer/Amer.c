#include "Amer.h"     

uint8_t MUCI_Data;                        
uint32_t MUCI_DataCount;                  
MUCI_Packet_t Rec_Packet, Send_Packet;

void AMER_init(void) {
    EALLOW;
    DeviceInit();  
    InitTermVars();
    Rec_Packet.State = MUCI_PACKET_RECEIVE_WAIT_FOR_STX;
    Send_Packet.State = MUCI_PACKET_SEND_FINISHED;
    MUCI_Recorder_Init();
    MUCI_SetDeviceAddress(0u);
    MUCI_SetApplicationState(MUCI_DEVICESTATE_APP_RUN);
}

void AMER_task_background(void) { 
    
    // Check for SCI errors
    // Break detect -> SW reset for SCIo
    if (sci_ptr_terminal->SCIRXST.bit.BRKDT) {
      sci_ptr_terminal->SCICTL1.bit.SWRESET = 0;
      sci_ptr_terminal->SCICTL1.bit.SWRESET = 1;
    }
    // RX FIFO overflow -> RX FIFO reset
    if (sci_ptr_terminal->SCIFFRX.bit.RXFFOVF) {
        sci_ptr_terminal->SCIFFRX.bit.RXFIFORESET = 0;
        sci_ptr_terminal->SCIFFRX.bit.RXFIFORESET = 1;
        sci_ptr_terminal->SCIFFRX.bit.RXFFOVRCLR = 1;
    }
        
    // If Receive FIFO is not empty, read the data to MUCI_Data
    if (sci_ptr_terminal->SCIFFRX.bit.RXFFST) {
        MUCI_DataCount = 1;
        MUCI_Data = sci_ptr_terminal->SCIRXBUF.bit.RXDT & 0xFF;
        MUCI_ReceivePacket(&Rec_Packet, &MUCI_Data, MUCI_DataCount);
    }

    //Check it is for own processing
    MUCI_ProcessPacket(&Rec_Packet, &Send_Packet);

    //Drop package because not mine address and no route to other DSP
    MUCI_PacketRouterNoMoreRoute(&Rec_Packet);

    // If there is place in the Transmit FIFO, write MUCI_Data to TXBUF
    if (sci_ptr_terminal->SCIFFTX.bit.TXFFST!= 4) {
        MUCI_DataCount = 1;
        MUCI_SendPacket(&Send_Packet, &MUCI_Data, &MUCI_DataCount);
        if (0 != MUCI_DataCount) {
            sci_ptr_terminal->SCITXBUF = MUCI_Data;
        }
    }

    MUCI_Recorder_Background();        
}

/* void AMER_task_background1(void) {
// Check for SCI errors
    // Break detect -> SW reset for SCIo
    if (SCI_getRxStatus(SCIA_BASE) & SCI_RXSTATUS_BREAK) {
        SCI_performSoftwareReset(SCIA_BASE);
    }
    // RX FIFO overflow -> RX FIFO reset
    if (SCI_getOverflowStatus(SCIA_BASE)) {
        SCI_resetRxFIFO(SCIA_BASE);
    }
    MUCI_Recorder_Background();
    if (SCI_FIFO_RX0 < SCI_getRxFIFOStatus(SCIA_BASE)) {
        MUCI_DataCount = 1;
        MUCI_Data = SCI_readCharNonBlocking(SCIA_BASE);
        MUCI_ReceivePacket(&Rec_Packet, &MUCI_Data, MUCI_DataCount);
    }
    //Check it is for own processing
    MUCI_ProcessPacket(&Rec_Packet, &Send_Packet);
    //Drop package because not mine address and no route to other DSP
    MUCI_PacketRouterNoMoreRoute(&Rec_Packet);
    if (SCI_FIFO_TX16 > SCI_getTxFIFOStatus(SCIA_BASE)) {
        MUCI_DataCount = 1;
        MUCI_SendPacket(&Send_Packet, &MUCI_Data, &MUCI_DataCount);
        if (0 != MUCI_DataCount) {
            SCI_writeCharNonBlocking(SCIA_BASE, MUCI_Data);
        }
    }
} */

void AMER_task_adc(void) {
    MUCI_Recorder_Trigger();
}
    
void AMER_task_1ms(void) {
    CPLD_DataExchange();    
}

void AMER_task_1s(void) {
}
