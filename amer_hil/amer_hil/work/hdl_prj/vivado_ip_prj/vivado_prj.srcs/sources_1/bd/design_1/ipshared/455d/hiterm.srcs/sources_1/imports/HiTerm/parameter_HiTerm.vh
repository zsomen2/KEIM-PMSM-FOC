//UART modul param�terei

//parameter baud_rate_step=16'd377;			//10 MHz-re   // baud_rate_step = baud_rate(57.600) * 2^16 / 10MHz
//parameter baud_rate_step=16'd6040;		//10 MHz-re   // baud_rate_step = baud_rate(921.600) * 2^16 / 10MHz
parameter baud_rate_step=16'd3020;			//20 MHz-re   // baud_rate_step = baud_rate(921.600) * 2^16 / 20MHz
//parameter baud_rate_step=16'd94;			//40 MHz-re   // baud_rate_step = baud_rate(57.600) * 2^16 / 40MHz
//parameter baud_rate_step=16'd189;			//40 MHz-re   // baud_rate_step = baud_rate(115.200) * 2^16 /40MHz
//parameter baud_rate_step=16'd377;			//40 MHz-re   // baud_rate_step = baud_rate(230.400) * 2^16 /40MHz
//parameter baud_rate_step=16'd151;			//25 MHz-re   // baud_rate_step = baud_rate(57.600) * 2^16 / 25MHz
//parameter baud_rate_step=16'd76;			//50 MHz-re   // baud_rate_step = baud_rate(57.600) * 2^16 / 50MHz
//parameter baud_rate_step=16'd1208;		//50 MHz-re   // baud_rate_step = baud_rate(921.600) * 2^16 / 50MHz
//parameter baud_rate_step=16'd38;			//100 MHz-re   // baud_rate_step = baud_rate(57.600) * 2^16 / 100MHz
//parameter baud_rate_step=16'd19;			//200 MHz-re   // baud_rate_step = baud_rate(57.600) * 2^16 / 200MHz	
//parameter baud_rate_step=16'd152;			//100 MHz-re   // baud_rate_step = baud_rate(230.400) * 2^16 / 100MHz
//parameter baud_rate_step=16'd76;			//200 MHz-re   // baud_rate_step = baud_rate(230.400) * 2^16 / 200MHz

//FPGA c�me
parameter FPGA_ADDRESS = 0;

//UART REC SM
parameter SER_BASE = 				0;
parameter SER_RECING = 				1;
parameter SER_WAIT_DATA_STORE_AND_CHKSUM = 	2;
//parameter SER_WAIT_ANSWER_RDY	=	3;


//UART ANS SM
parameter ANS_INIC = 0;
parameter ANS_GET_MODE = 1;
parameter ANS_GET_KEY = 2;
parameter ANS_GET_LEN_HIGH = 3;
parameter ANS_GET_LEN_LOW = 4;
parameter ANS_GET_LEN_LOW_LOW = 5;
parameter ANS_ANSWER = 6;

//El�re defini�lt konstansok
parameter STX = 8'h3C;		/*!< Start of message character*/
parameter DLE = 8'h3D;		/*!< Escape of message character*/
parameter ETX = 8'h3E;		/*!< End of message character*/
parameter XDT = 8'h30;		/*!< Start of message character*/

parameter MON_RD =            8'h10;		/*!< Read single/multple variables */
parameter MON_WR =           	8'h23;		/*!< Write single/multple variables */
parameter MON_TABS =     		8'h40;		/*!< Read the 0-th tab descriptor*/
parameter MON_TABNAMES =      8'h55;		/*!< Read the name of the tabs in user mode (only for 0th address DSP)*/
parameter MON_TABVALUES = 		8'hA0;		/*!< not implemented */
parameter MON_RDUNITS =       8'h79;		/*!< read unit table */
parameter MON_RD_ERRH =       8'h51;		/*!< read error history */
parameter MON_RD_BBX =        8'h75;		/*!< read black box content */
parameter MON_RD_SPI_RAM =    8'h24;		/*!< read spi ram (bbx, error history */
parameter MON_REBOOT =        8'h80;		/*!< Reboot DSP */
parameter MON_PING =          8'h99;		/*!< ping DSP */

parameter TYP_32BIT =      16'h0000;        /*!< Variable is 32bit */
parameter TYP_16BIT =     	16'h0001;       /*!< Variable is 16bit */
parameter TYP_SIGNED =     16'h0000;        /*!< Variable is signed */
parameter TYP_UNSIGNED =   16'h0002;        /*!< Variable is unsigned */
//parameter TYP_IQ(n)       (4*n)       /*!< Variable is _IQn type 0-30.*/
parameter TYP_HEX =        16'h0080;        /*!< Variable is hexadecimal */
parameter TYP_FLOAT =      16'h0100;       /*!< Variable is floating type */
parameter TYP_ENWR =       16'h0200;       /*!< Variable is writable */
//parameter TYP_SHIFT(n)    (0x400 * n) /*!< Variable is needs to be shifted with n for the recorder n <= 16 */

/*
parameter TYP_U32         (TYP_UNSIGNED+TYP_32BIT)
parameter TYP_S32         (TYP_SIGNED+TYP_32BIT)
parameter TYP_U16         (TYP_UNSIGNED+TYP_16BIT)
parameter TYP_S16         (TYP_SIGNED+TYP_16BIT)
*/

parameter BBX_TV_SIGNED =    16'h0001;   /*!< blackbox triggered value signed */
parameter BBX_TV_UNSIGNED =  16'h0000;   /*!< blackbox triggered value unsigned */
parameter BBX_TV_16BIT =     16'h0002;   /*!< blackbox triggered value 16bit */
parameter BBX_TV_32BIT =     16'h0000;   /*!< blackbox triggered value 32bit */
parameter BBX_TV_16B_UPPER = 16'h0004;   /*!< blackbox triggered value at upper16 bit (only valid for 16 bit variable) */
parameter BBX_TV_FLOAT =     16'h0008;   /*!< blackbox triggered value float */


parameter TABTITLE_START_ADDRESS = 32'h800;
parameter UNITS_START_ADDRESS = 32'hA00;
parameter VARS_START_ADDRESS = 32'hC00;
//parameter BBX_START_ADDRESS =	32'hC00;
