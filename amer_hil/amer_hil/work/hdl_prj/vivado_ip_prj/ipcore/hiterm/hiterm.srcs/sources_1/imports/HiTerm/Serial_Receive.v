`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:46:54 08/19/2011 
// Design Name: 
// Module Name:    Serial_Receive 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Serial_Receive(
    input Clk,
	 input Reset,
    input RxD,
	 output reg [10:0] uart_cmd_pos,
	 output reg [7:0] uart_cmd_data,
	 output reg uart_cmd_write,
	 input uart_cmd_write_ready,
	 output reg uart_cmd_packet_ready
    );

`include "parameter_HiTerm.vh" 

wire RxErr;
wire RxRdy;
reg Read_RxBuf;

reg [7:0] uart_state;
reg uart_dlewas;
wire [7:0] uart_data;

reg [15:0] packet_len;
reg [7:0] uart_address;

reg [15:0] uart_crc;
reg uart_cmd_calc_chksum;
wire [15:0] new_uart_crc;
wire new_uart_crc_ready;

UART_Rx UART_Rx_inst(
   .Clk(Clk),
   .Reset(Reset),
   .RxD(RxD),
	.RxBuf(uart_data),
   .RxRdy(RxRdy),
   .RxErr(RxErr),
   .Read_RxBuf(Read_RxBuf)
	);

PushCheckSum Calc_CHKSUM(
   .Clk(Clk),
	.Reset(Reset),
   .Data(uart_cmd_data),
	.Data_Ready(uart_cmd_calc_chksum),
	.Checksum_Old(uart_crc),
   .Checksum(new_uart_crc),
	.Ready(new_uart_crc_ready)
    );

always@ (posedge Clk) begin
	if (Reset) begin
		Read_RxBuf <= 0;
		uart_cmd_pos <= 0;	
		uart_cmd_data <= 0;
		uart_cmd_write <= 0;
		uart_cmd_calc_chksum <= 0;
		uart_state <= SER_BASE;
		uart_cmd_packet_ready <= 0;
		packet_len <= 0;
		uart_address <= 0;	
	end
	else begin
		if (Read_RxBuf)				//ha olvasható az rx buf
				Read_RxBuf <= 0 ;
		else begin		
			case(uart_state)
				SER_BASE: begin
					if (RxRdy) begin			//ha uart üzente h kész az rx adat
						Read_RxBuf <= 1 ;
						if (uart_data == STX) begin
							uart_crc <= 16'hFFFF;
							uart_dlewas <= 0;
							uart_cmd_pos <= 0;
							uart_cmd_calc_chksum <= 0;
							uart_cmd_packet_ready <= 0;
							uart_state <= SER_RECING;
						end
					end
				end
				SER_RECING: begin
					if (RxRdy) begin			//ha uart üzente h kész az rx adat
						Read_RxBuf <= 1 ;
						if (uart_dlewas) begin
							uart_cmd_data <= uart_data ^ XDT;
							uart_cmd_write <= 1;
							uart_cmd_calc_chksum <= 1;
							uart_state <= SER_WAIT_DATA_STORE_AND_CHKSUM;
							uart_dlewas <= 0;
						end
						else begin 
							if (uart_data == DLE) begin
								uart_dlewas <= 1;
							end
							else if (uart_data == ETX) begin
								if (uart_crc == 16'h0) begin
									if ((packet_len + 7) == uart_cmd_pos) begin //{6'h00,uart_pos}) begin
										if (uart_address == FPGA_ADDRESS) begin
											uart_cmd_packet_ready <= 1;
										end
									end
								end
								uart_state <= SER_BASE;								
							end
							else begin
								uart_cmd_data <= uart_data;
								uart_cmd_write <= 1;
								uart_cmd_calc_chksum <= 1;
								uart_state <= SER_WAIT_DATA_STORE_AND_CHKSUM;
							end
						end
					end
				end
				SER_WAIT_DATA_STORE_AND_CHKSUM: begin
					if (uart_cmd_write_ready) begin
						uart_cmd_write <= 0;
						uart_cmd_pos <= uart_cmd_pos + 1;
					end
					else begin
						if (uart_cmd_pos == 1) uart_address <= uart_cmd_data;
						if (uart_cmd_pos == 4) packet_len[15:8] <= uart_cmd_data;
						if (uart_cmd_pos == 5) packet_len[7:0] <= uart_cmd_data;
					end
					if (new_uart_crc_ready) begin
						uart_crc <= new_uart_crc;
						uart_cmd_calc_chksum <=0;
					end
					if (!uart_cmd_write && !uart_cmd_calc_chksum) begin
						uart_state <= SER_RECING;
					end
				end
			endcase
		end
	end		
end
endmodule
