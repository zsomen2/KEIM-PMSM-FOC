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
module UART_Tx(
    input Clk,
    input Reset,
    output TxD,
    input [7:0] TxBuf,
    output reg TxEmpty,
    input Write_TxBuf
);

`include "parameter_HiTerm.vh"

reg [8:0] TxShift_Reg;
reg [7:0] TxBuf_Reg ;
reg [15:0] tr_counter;
reg [3:0] tr_bit_num;
wire [15:0] tr_counter_next;

assign TxD = TxShift_Reg[0];

assign tr_counter_next = tr_counter + baud_rate_step ;
assign tx_clk_en = !tr_counter_next[15] & tr_counter[15] ;

always@ (posedge Clk) begin
	if (Reset == 1'b1) begin
		tr_counter <= 0;
		tr_bit_num <= 0;
		TxShift_Reg[0] <= 1;
		TxEmpty <= 1 ;
	end
	else begin
		tr_counter <= tr_counter_next ;
		if (TxEmpty && Write_TxBuf) begin
			TxBuf_Reg <= TxBuf ;
			TxEmpty <= 0 ;
			tr_bit_num[3:0]<=4'd0;
		end
		else if (tx_clk_en)
			case (tr_bit_num)
				4'd0 : if (!TxEmpty)
							begin
								tr_bit_num <= 1 ;
								TxShift_Reg[8:0]<={TxBuf_Reg[7:0], 1'b0};
							end
				4'd10 : begin
								TxEmpty <= 1 ;				
								TxShift_Reg[8:0] <= {1'b1, TxShift_Reg[8:1]};
						end
				default : begin
								tr_bit_num[3:0] <= tr_bit_num[3:0]+4'd1;
								TxShift_Reg[8:0] <= {1'b1, TxShift_Reg[8:1]};
							end
			endcase		 
	end // Not in reset
end // always for transmit
endmodule
