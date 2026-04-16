`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:29:49 09/05/2011 
// Design Name: 
// Module Name:    Bus_Protocol 
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
module Bus_Protocol(
   input Clk,
	input Reset,
   input RxD,
	output TxD,	 
	output reg [31:0] data_from_pc_address,
	output reg [31:0] data_from_pc_data_in,
	input [31:0] data_from_pc_data_out,
	output reg data_from_pc_write_enable,
	output reg [13:0] BBX_Addr_pc,
	input [31:0] BBX_Data_out_pc
    );

`include "parameter_HiTerm.vh" 

wire [10:0] uart_cmd_pos;
wire [7:0] uart_cmd_data;
wire uart_cmd_write;
reg [10:0] cmd_mng_address;
wire [7:0] cmd_mng_data;
uart_cmd_RAM uart_receive_memory(
	.clka(Clk),
	.wea(uart_cmd_write),
	.addra(uart_cmd_pos),
	.dina(uart_cmd_data),
	.clkb(Clk),
	.addrb(cmd_mng_address),
	.doutb(cmd_mng_data));


reg [10:0] uart_send_pos;
reg [7:0] uart_send_data;
reg uart_send_write;
wire [10:0] cmd_send_read_address;
wire [7:0] cmd_send_read_data;
uart_cmd_RAM uart_send_memory(
	.clka(Clk),
	.addra(uart_send_pos),
	.dina(uart_send_data),
	.wea(uart_send_write),
	.clkb(Clk),
	.addrb(cmd_send_read_address),
	.doutb(cmd_send_read_data));
		
reg uart_cmd_write_ready = 0;
wire receive_ready;

Serial_Receive Serial_Receive(
    .Clk(Clk),
    .RxD(RxD),
    .Reset(Reset),
	 .uart_cmd_pos(uart_cmd_pos),
	 .uart_cmd_data(uart_cmd_data),
	 .uart_cmd_write(uart_cmd_write),
	 .uart_cmd_write_ready(uart_cmd_write_ready),
	 .uart_cmd_packet_ready(receive_ready)
);

wire packet_sent;
reg packet_ready = 0;

Serial_Send Serial_Send(
   .Clk(Clk),
	.Reset(Reset),
	.TxD(TxD),	
	.uart_cmd_pos(cmd_send_read_address),
	.uart_cmd_data(cmd_send_read_data),
	.packet_ready(packet_ready),
	.packet_sent(packet_sent)
    );
	 

reg [7:0] ans_state = ANS_INIC;
reg [7:0] mode;
reg [7:0] key;
reg [15:0] len;
reg [7:0] alma;

reg [15:0] tabtitle_len;
reg [15:0] units_len;
reg [15:0] vars_len;
reg [15:0] vars_counter;
reg [15:0] data_len;
reg [15:0] data_counter;
reg [31:0] bbx_start_address;		
reg [13:0] bbx_address;			//Ezeket kell atirni, ha nagyobb/kisebb bbx ram van a rendszerben
wire[15:0] bbx_send_data_counter ={data_counter[14:0],1'b0} + 4 + 2;
reg [31:0] data_from_pc_address_tmp;

always @ (posedge Clk) begin
	//Store UART command to uart_cmd_memory	
	if (uart_cmd_write && !uart_cmd_write_ready) begin
		uart_cmd_write_ready <= 1;
	end
	else if (uart_cmd_write_ready) begin
		uart_cmd_write_ready <= 0;
	end
	if (packet_ready && !packet_sent) begin
		packet_ready <= 0;
	end
	
	if (data_from_pc_write_enable) data_from_pc_write_enable <= 0;
	
	//Make answer
	if (!receive_ready) begin
		ans_state <= ANS_INIC;
	end
	else begin
		case(ans_state)
			ANS_INIC: begin
				cmd_mng_address <= 1;
				ans_state <= ANS_GET_MODE;
			end
			ANS_GET_MODE: begin
				cmd_mng_address <= 2;
				ans_state <= ANS_GET_KEY;
			end
			ANS_GET_KEY: begin
				mode <= cmd_mng_data;
				cmd_mng_address <= 3;
				ans_state <= ANS_GET_LEN_HIGH;
			end
			ANS_GET_LEN_HIGH: begin
				key <= cmd_mng_data;
				cmd_mng_address <= 4;
				ans_state <= ANS_GET_LEN_LOW;
			end
			ANS_GET_LEN_LOW: begin
				len[15:8] <= cmd_mng_data;
				alma <=0;
				ans_state <= ANS_GET_LEN_LOW_LOW;
			end
			ANS_GET_LEN_LOW_LOW: begin
				len[7:0] <= cmd_mng_data;			
				ans_state <= ANS_ANSWER;
			end
			ANS_ANSWER: begin
				if (mode == MON_PING) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;	
							end
							3: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= 8'h00;
								uart_send_write <= 1;	
							end
							4: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= 8'h01;
								uart_send_write <= 1;	
							end
							5: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <=8'h00;
								uart_send_write <= 1;	
							end
							6: begin
								packet_ready <=1;
							end							
							default: begin

							end
						endcase		
					end
				end
				else if (mode == MON_TABNAMES) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								data_from_pc_address <= TABTITLE_START_ADDRESS;								
							end
							3: begin
								//nop
							end
							4: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[7:0];
								uart_send_write <= 1;							
							end
							5: begin
								data_from_pc_address <= data_from_pc_address + 1;
								if (data_from_pc_address == TABTITLE_START_ADDRESS + 0) tabtitle_len[15:8] <= data_from_pc_data_out[7:0];
								if (data_from_pc_address == TABTITLE_START_ADDRESS + 1) tabtitle_len[7:0] <= data_from_pc_data_out[7:0];
								if (data_from_pc_address > (TABTITLE_START_ADDRESS + 1)) begin
									if ((tabtitle_len + TABTITLE_START_ADDRESS + 1) > data_from_pc_address  ) begin
										alma <= 3;							
									end
								end
								else begin
									alma <= 3;	
								end
							end
							6: begin
								packet_ready <=1;
							end	
							default: begin

							end
						endcase						
					end
				end
				if (mode == MON_RDUNITS) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								data_from_pc_address <= UNITS_START_ADDRESS;									
							end
							3: begin
								//nop
							end
							4: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[7:0];
								uart_send_write <= 1;							
							end
							5: begin
								data_from_pc_address <= data_from_pc_address + 1;
								if (data_from_pc_address == UNITS_START_ADDRESS + 0) units_len[15:8] <= data_from_pc_data_out[7:0];
								if (data_from_pc_address == UNITS_START_ADDRESS + 1) units_len[7:0] <= data_from_pc_data_out[7:0];
								if (data_from_pc_address > (UNITS_START_ADDRESS + 1)) begin
									if ((units_len + UNITS_START_ADDRESS + 1) > data_from_pc_address  ) begin
										alma <= 3;							
									end
								end
								else begin
									alma <= 3;	
								end
							end
							6: begin
								packet_ready <=1;
							end	
							default: begin

							end
						endcase						
					end
				end
				else if ((mode >= MON_TABS) && (mode <= (MON_TABS + 9))) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								data_from_pc_address <= VARS_START_ADDRESS + {mode - MON_TABS,10'h0};					
							end
							3: begin
								//nop
							end
							4: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[15:8];
								uart_send_write <= 1;							
							end
							5: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[7:0];
								uart_send_write <= 1;							
							end							
							6: begin
								data_from_pc_address <= data_from_pc_address + 1;
								if (data_from_pc_address == (VARS_START_ADDRESS + {mode - MON_TABS,10'h0})) vars_len <= {1'b0,data_from_pc_data_out[15:1]};
								if (data_from_pc_address > (VARS_START_ADDRESS + {mode - MON_TABS,10'h0})) begin
									if ((vars_len + VARS_START_ADDRESS + {mode - MON_TABS,10'h0} ) > data_from_pc_address  ) begin
										alma <= 3;							
									end
								end
								else begin
									alma <= 3;	
								end
							end
							7: begin
								packet_ready <=1;
							end	
							default: begin
			
							end
						endcase						
					end
				end		
				else if ((mode >= MON_TABVALUES) && (mode <= (MON_TABVALUES + 9))) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								data_from_pc_address <= VARS_START_ADDRESS + {mode - MON_TABVALUES,10'h0};						
							end
							3: begin
								//nop
								uart_send_pos <= uart_send_pos + 2; //Datalen kihagyása miatt
							end
							4: begin
								vars_len <= {1'h0,data_from_pc_data_out[15:1]} ;
								data_from_pc_address <= VARS_START_ADDRESS + {mode - MON_TABVALUES,10'h0} + 14;
								vars_counter <= 0;
							end
							5: begin
								//nop ide kell visszaugrani
							end
							6: begin
								data_len <= data_from_pc_data_out[15:0];
								data_from_pc_address <= data_from_pc_address + 1;
							end							
							7: begin
								data_from_pc_address_tmp <= data_from_pc_address; //save vars address
							end
							8: begin
								data_from_pc_address <= data_from_pc_data_out[15:0];
							end
							9: begin
							//nop
							end						
							10: begin 
								if (data_len & TYP_16BIT) begin
									uart_send_pos <= uart_send_pos + 1;
									uart_send_data <= 8'h0;
									uart_send_write <= 1;								
								end
								else begin
									uart_send_pos <= uart_send_pos + 1;
									uart_send_data <= data_from_pc_data_out[31:24];
									uart_send_write <= 1;	
								end
							end							
							11: begin 
								if (data_len & TYP_16BIT) begin
									uart_send_pos <= uart_send_pos + 1;
									uart_send_data <= 8'h0;
									uart_send_write <= 1;	
								end
								else begin
									uart_send_pos <= uart_send_pos + 1;
									uart_send_data <= data_from_pc_data_out[23:16];
									uart_send_write <= 1;	
								end							
							end
							12: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[15:8];
								uart_send_write <= 1;								
							end
							14: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[7:0];
								uart_send_write <= 1;	
							end
							15: begin
								data_from_pc_address <= data_from_pc_address_tmp + 19;	
								if ((vars_len + VARS_START_ADDRESS) > (data_from_pc_address_tmp)) begin							
								//if ((vars_len + {mode - MON_TABS,9'h0} ) > vars_address  ) begin
									vars_counter <= vars_counter + 4;
									alma <= 5;	
								end
							end							
							16: begin
								uart_send_pos <= 3;
								uart_send_data <= vars_counter[15:8];
								uart_send_write <= 1;	
							end
							17: begin
								uart_send_pos <= 4;
								uart_send_data <= vars_counter[7:0];
								uart_send_write <= 1;	
							end
							18: begin
								packet_ready <=1;
							end	
							default: begin
		
							end
						endcase						
					end
				end	

				else if (mode == MON_RD) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
								data_counter <= 0;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								cmd_mng_address <= 5;
							end
							3: begin
								uart_send_pos <= uart_send_pos + 2; //Datalen kihagyása miatt
							end
							4: begin
								//nop ide kell visszaugrani
							end
							5: begin
								data_from_pc_address[31:24] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							6: begin
								//nop
							end
							7: begin
								data_from_pc_address[23:16] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							8: begin
								//nop
							end
							9: begin
								data_from_pc_address[15:8] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
								cmd_mng_address <= cmd_mng_address + 1;							
							end
							10: begin
								//nop
							end
							11: begin
								data_from_pc_address[7:0] <= cmd_mng_data;		
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;	
								cmd_mng_address <= cmd_mng_address + 1;									
							end
							12: begin
								//nop
							end	
							13: begin
								data_len <= cmd_mng_data;			
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;						
							end										
							14: begin
								if (data_len == 2) begin
									uart_send_pos <= uart_send_pos + 1;
									uart_send_data <= data_from_pc_data_out[31:24];
									uart_send_write <= 1;	
								end
							end							
							15: begin
								if (data_len == 2) begin							
									uart_send_pos <= uart_send_pos + 1;
									uart_send_data <= data_from_pc_data_out[23:16];
									uart_send_write <= 1;
								end
							end							
							16: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[15:8];
								uart_send_write <= 1;		
							end
							17: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_from_pc_data_out[7:0];
								uart_send_write <= 1;	
							end
							18: begin
								cmd_mng_address <= cmd_mng_address + 1;	
								if ((len + 5) > cmd_mng_address  ) begin							
								//if ((vars_len + {mode - MON_TABS,9'h0} ) > vars_address  ) begin
									data_counter <= data_counter + 5 + {data_len, 1'h0};
									alma <= 4;	
								end
							end							
							19: begin
								uart_send_pos <= 3;
								uart_send_data <= data_counter[15:8];
								uart_send_write <= 1;	
							end
							20: begin
								uart_send_pos <= 4;
								uart_send_data <= data_counter[7:0];
								uart_send_write <= 1;	
							end
							21: begin
								packet_ready <=1;
							end	
							default: begin
							end
						endcase						
					end
				end
				
				else if (mode == MON_WR) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								cmd_mng_address <= 5;
							end
							3: begin
								//nop ide kell visszaugrani
							end
							4:begin
								data_from_pc_address[31:24] <= cmd_mng_data;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							5: begin
								//nop
							end
							6: begin
								data_from_pc_address[23:16] <= cmd_mng_data;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							7: begin
								//nop
							end
							8: begin
								data_from_pc_address[15:8] <= cmd_mng_data;
								cmd_mng_address <= cmd_mng_address + 1;							
							end
							9: begin
								//nop
							end
							10: begin
								data_from_pc_address[7:0] <= cmd_mng_data;		
								cmd_mng_address <= cmd_mng_address + 1;									
							end
							11: begin
								//nop
							end
							12: begin
								data_len <= cmd_mng_data;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							13: begin
								//nop
							end
							14: begin
								if (data_len == 2) begin
									data_from_pc_data_in[31:24] <= cmd_mng_data;					
									cmd_mng_address <= cmd_mng_address + 1;	
								end
							end
							15: begin
								//nop
							end
							16: begin 
								if (data_len == 2) begin						
									data_from_pc_data_in[23:16] <= cmd_mng_data;	
									cmd_mng_address <= cmd_mng_address + 1;
								end
							end							
							17: begin
							//nop
							end
							18: begin	 
								data_from_pc_data_in[15:8]	<=	cmd_mng_data;					
								cmd_mng_address <= cmd_mng_address + 1;	
							end
							19: begin
								//nop
							end
							20: begin 							
								data_from_pc_data_in[7:0]	<=	cmd_mng_data;	
								data_from_pc_write_enable <= 1;
								if ((len + 4) > cmd_mng_address  ) begin									
									cmd_mng_address <= cmd_mng_address + 1;	
									alma <= 3;
								end
							end					
							21: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= 8'h00;
								uart_send_write <= 1;	
							end
							22: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= 8'h00;
								uart_send_write <= 1;	
							end
							23: begin
								packet_ready <=1;
							end	
							default: begin
							end
						endcase						
					end
				end

				else if (mode == MON_RD_SPI_RAM) begin
					if (uart_send_write) begin
						uart_send_write <= 0;
					end
					else begin
						if (alma < 255) alma <= alma + 1;
						case(alma)
							0: begin
								uart_send_pos <= 0;
								uart_send_data <= 8'h80 | FPGA_ADDRESS;
								uart_send_write <= 1;
							end
							1: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= mode;
								uart_send_write <= 1;							
							end
							2: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= key;
								uart_send_write <= 1;
								cmd_mng_address <= 9;
							end
							3: begin
								//nop
							end
							4: begin
								data_counter[15:8] <= cmd_mng_data;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							5: begin
								//nop
							end
							6: begin
								data_counter[7:0] <= cmd_mng_data;
								cmd_mng_address <= 5;
							end
							7: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= bbx_send_data_counter[15:8];
								uart_send_write <= 1;
							end
							8: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= bbx_send_data_counter[7:0];
								uart_send_write <= 1;
							end						
							9: begin
								bbx_start_address[31:24] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							10: begin
								//nop
							end
							11: begin
								bbx_start_address[23:16] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							12: begin
								//nop
							end
							13: begin
								bbx_start_address[15:8] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
								cmd_mng_address <= cmd_mng_address + 1;
							end
							14: begin
								//nop
							end
							15: begin
								bbx_start_address[7:0] <= cmd_mng_data;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= cmd_mng_data;
								uart_send_write <= 1;
							end
							16: begin
								bbx_address <= {1'b0,bbx_start_address[31:1]};
							end
							17: begin
								BBX_Addr_pc <= bbx_address;
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_counter[15:8];
								uart_send_write <= 1;								
							end
							18: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= data_counter[7:0];
								uart_send_write <= 1;
							end
							19: begin
								//nop ide kell majd visszaugrani
							end
							20: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= BBX_Data_out_pc[15:8];	
								uart_send_write <= 1;
							end
							21: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= BBX_Data_out_pc[7:0];	
								uart_send_write <= 1;
							end								
							22: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= BBX_Data_out_pc[31:24];	
								uart_send_write <= 1;
							end
							23: begin
								uart_send_pos <= uart_send_pos + 1;
								uart_send_data <= BBX_Data_out_pc[23:16];	
								uart_send_write <= 1;
								bbx_address <= bbx_address + 1;
							end
							24: begin 							
								data_counter <= data_counter - 2;
								if (data_counter > 1) begin									
									BBX_Addr_pc <=  bbx_address;
									alma <= 19;
								end
							end							
							25: begin
								packet_ready <=1;
							end	
							default: begin
							end
						endcase						
					end
				end

			end
		endcase
	end
end
endmodule
