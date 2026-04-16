`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:50:56 10/12/2009 
// Design Name: 
// Module Name:    UART 
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
module UART_Rx(
   input Clk,
   input Reset,
   input RxD,
	input Read_RxBuf,
   output reg [7:0] RxBuf,
   output reg RxRdy = 0,
   output reg RxErr
	);
	
`include "parameter_HiTerm.vh"

reg [7:0] RxShift_Reg ;
reg [15:0] rec_counter;
reg [3:0] rec_bit_num;
reg RxShift_Rdy ;
reg RxD_sync ;
wire [15:0] rec_counter_next;

assign rec_counter_next = rec_counter + baud_rate_step ;
assign rec_clk_en = !rec_counter_next[15] & rec_counter[15] ;

always@ (posedge Clk) begin
	if (Reset == 1'b1)
	begin
		RxD_sync<=1 ;
		rec_counter <= 0;
		rec_bit_num <= 0;
		RxBuf <= 0 ;
		RxRdy <= 0 ;
		RxErr <= 0 ;
		RxShift_Rdy <= 0 ;
	end
	else
	begin
		RxD_sync<=RxD ;
		if (Read_RxBuf) begin
			RxRdy <= 0 ;
			RxErr <= 0 ;
		end
		if (RxShift_Rdy && !RxRdy) begin // a shiftregiszter áttölthetõ a bufferbe
			RxRdy <= 1 ;
			RxShift_Rdy <= 0 ;
			RxBuf <= RxShift_Reg ;
		end
		
		if (rec_bit_num==0) begin
			if (!RxD_sync) begin // Start bit lefutó éle (vagy zaj)
				rec_bit_num <= 1 ;
				rec_counter <= 16'h8000 ;
			end
		end
		else begin
			rec_counter <= rec_counter_next ;
			if (rec_clk_en)
				case (rec_bit_num)
					4'd1 : 
						if (RxD_sync)
							rec_bit_num <= 0 ; // Csak zaj volt, nincs start bit
						else if (RxShift_Rdy) begin
							RxErr <= 1 ; // Túlcsordulás hiba
							rec_bit_num <= 0 ;
						end
						else
							rec_bit_num <= 2 ; 
					4'd10 : begin
						RxShift_Rdy <= 1 ;
						rec_bit_num <= 0 ;
						if (!RxD_sync)
							RxErr <= 1 ; // Keretezés hiba
					end
					default: begin
						rec_bit_num <= rec_bit_num + 1 ;
						RxShift_Reg <= {RxD_sync,RxShift_Reg[7:1]} ;
						end
				endcase
			end // Receive started		 
	end // Not in reset
end // always for receive


endmodule
