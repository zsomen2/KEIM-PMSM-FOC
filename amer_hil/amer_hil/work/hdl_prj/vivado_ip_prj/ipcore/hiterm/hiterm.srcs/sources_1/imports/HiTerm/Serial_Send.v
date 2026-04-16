`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:40 08/18/2011 
// Design Name: 
// Module Name:    Serial_Send
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
module Serial_Send(
   input Clk,
	input Reset,
	output TxD,
	output reg [10:0] uart_cmd_pos,
	input [7:0] uart_cmd_data,
	input packet_ready,
	output reg packet_sent
    );
	 
`include "parameter_HiTerm.vh"

wire TxEmpty;
wire [15:0] cheksum_new;
wire uart_cheksum_ready;

reg [7:0] Data_Out;
reg Write_TxBuf;
reg [3:0] tmt_State = 0;
reg [15:0] packet_length;
reg [7:0] send_state;
reg [15:0] cheksum_old;
reg uart_data_ready_for_chksum;
reg [7:0] cheksum_Data_Out;


UART_Tx UART_Tx_inst(
    .Clk(Clk),
    .Reset(Reset),
    .TxD(TxD),
    .TxBuf(Data_Out),
    .TxEmpty(TxEmpty),
    .Write_TxBuf(Write_TxBuf)
);

PushCheckSum Calc_CHKSUM(
   .Clk(Clk),
	.Reset(Reset),
   .Data(cheksum_Data_Out),
	.Data_Ready(uart_data_ready_for_chksum),
	.Checksum_Old(cheksum_old),
   .Checksum(cheksum_new),
	.Ready(uart_cheksum_ready)
    );
	 
always @ (posedge Clk) begin
	if (Reset) begin
		cheksum_old <= 16'hFFFF;
		packet_sent <= 1;
		packet_length <= 0;
		Write_TxBuf <= 0;
	end
	else begin
		if (packet_ready  & (tmt_State == 0))	begin
			tmt_State <= 1;
		end
		case (tmt_State)
			0: begin	// Don't go
				cheksum_old <= 16'hFFFF;
				packet_sent <= 1;
				send_state <= 0;
			end
			1: begin
				packet_sent <= 0;
				if (Write_TxBuf) Write_TxBuf <= 0 ;// Leghamarabb 2 órajelenként írhatunk az Uart-ba
				else if (TxEmpty) begin
					if (send_state < 128) send_state <= send_state +1;
					case (send_state)
						0: begin
							Data_Out <= STX;
							Write_TxBuf <= 1; 
							uart_cmd_pos <= 0;
						end
						1: begin
							//nop
						end
						2: begin
							if (uart_cmd_data == STX || uart_cmd_data == ETX || uart_cmd_data == DLE) begin
								Data_Out <= DLE;
								Write_TxBuf <= 1 ;
							end
						end
						3: begin
							if (Data_Out == DLE) begin
								Data_Out <= uart_cmd_data ^ XDT;
							end
							else begin
								Data_Out <= uart_cmd_data;
							end
							Write_TxBuf <= 1 ;
							cheksum_Data_Out <= uart_cmd_data;
							uart_data_ready_for_chksum <=1;
						end
						4: begin
							if (uart_cheksum_ready)  begin
								uart_data_ready_for_chksum <=0;
								cheksum_old <= cheksum_new;
							end
							else begin
								send_state <= 4;
							end
						end
						5: begin
							if (uart_cmd_pos == 3) packet_length[15:8] <= uart_cmd_data;
							if (uart_cmd_pos == 4) packet_length[7:0] <= uart_cmd_data;
							uart_cmd_pos <= uart_cmd_pos + 1;
						end
						6: begin
							if (uart_cmd_pos >= 5) begin
								if ((packet_length + 5) > uart_cmd_pos ) begin
									send_state <= 1;							
								end
							end
							else begin
								send_state <= 1;	
							end
						end
						7: begin
							if (cheksum_old[7:0] == STX || cheksum_old[7:0] == ETX || cheksum_old[7:0] == DLE) begin
								Data_Out <= DLE;
								Write_TxBuf <= 1 ;
							end
						end
						8: begin
							if (Data_Out == DLE) begin
								Data_Out <= cheksum_old[7:0] ^ XDT;
								Write_TxBuf <= 1 ;
							end
							else begin
								Data_Out <= cheksum_old[7:0];
								Write_TxBuf <= 1 ;
							end
						end
						9: begin
							if (cheksum_old[15:8] == STX || cheksum_old[15:8] == ETX || cheksum_old[15:8] == DLE) begin
								Data_Out <= DLE;
								Write_TxBuf <= 1 ;
							end
						end
						10: begin
							if (Data_Out == DLE) begin
								Data_Out <= cheksum_old[15:8] ^ XDT;
								Write_TxBuf <= 1 ;
							end
							else begin
								Data_Out <= cheksum_old[15:8];
								Write_TxBuf <= 1 ;
							end
						end
						11: begin
							Data_Out <= ETX;
							Write_TxBuf <= 1; 
						end
						default: begin
							tmt_State  <= 0;
						end
					endcase
				end
			end
		endcase
	end
end
endmodule
