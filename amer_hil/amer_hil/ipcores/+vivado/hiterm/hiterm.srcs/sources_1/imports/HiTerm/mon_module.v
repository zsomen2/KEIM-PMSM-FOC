`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:18:08 09/06/2011 
// Design Name: 
// Module Name:    Mon_Module 
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
module mon_module(
	input clk,
	input reset,
	input RxD,
	output TxD,
	input [31:0] data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,
	input [31:0] data16,data17,data18,data19,data20,data21,data22,data23,data24,data25,data26,data27,data28,data29,data30,data31,
	input [31:0] data32,data33,data34,data35,data36,data37,data38,data39,data40,data41,data42,data43,data44,data45,data46,data47,
	input [31:0] data48,data49,data50,data51,data52,data53,data54,data55,data56,data57,data58,data59,data60,data61,data62,data63,
	input [31:0] data64,data65,data66,data67,data68,data69,data70,data71,data72,data73,data74,data75,data76,data77,data78,data79,
    input [31:0] data80,data81,data82,data83,data84,data85,data86,data87,data88,data89,data90,data91,data92,data93,data94,data95,
    input [31:0] data96,data97,data98,data99,data100,data101,data102,data103,data104,data105,data106,data107,data108,data109,data110,data111,
    input [31:0] data112,data113,data114,data115,data116,data117,data118,data119,data120,data121,data122,data123,data124,data125,data126,data127,
	
	output reg [31:0] param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,
	output reg [31:0] param16,param17,param18,param19,param20,param21,param22,param23,param24,param25,param26,param27,param28,param29,param30,param31,
	output reg [31:0] param32,param33,param34,param35,param36,param37,param38,param39,param40,param41,param42,param43,param44,param45,param46,param47,
	output reg [31:0] param48,param49,param50,param51,param52,param53,param54,param55,param56,param57,param58,param59,param60,param61,param62,param63,
	output reg [31:0] param64,param65,param66,param67,param68,param69,param70,param71,param72,param73,param74,param75,param76,param77,param78,param79,
    output reg [31:0] param80,param81,param82,param83,param84,param85,param86,param87,param88,param89,param90,param91,param92,param93,param94,param95,
    output reg [31:0] param96,param97,param98,param99,param100,param101,param102,param103,param104,param105,param106,param107,param108,param109,param110,param111,
    output reg [31:0] param112,param113,param114,param115,param116,param117,param118,param119,param120,param121,param122,param123,param124,param125,param126,param127
    );
	 
`include "parameter_HiTerm.vh" 

reg [15:0] FPGA_Addr_next;
reg [15:0] FPGA_Addr;
reg [15:0] FPGA_Addr_prev;

reg [31:0] FPGA_Data_In;
wire [31:0] FPGA_Data_Out;
reg FPGA_Data_Write;

wire [31:0] data_from_pc_address;
wire [31:0] data_from_pc_data_in;
wire [31:0] data_from_pc_data_out;
wire data_from_pc_write_enable;

//BBX változók
reg [31:0] bbx_val_addr [7:0];
wire [31:0] bbx_val [3:0];
reg [31:0] bbx_sampled_date;
reg [31:0] bbx_sampled_time;
reg [31:0] bbx_sample_time;

reg [31:0] bbx_trig_level;
wire signed[15:0] bbx_trig_level_signed_16;
assign bbx_trig_level_signed_16 = bbx_trig_level[15:0];
wire signed[31:0] bbx_trig_level_signed_32;
assign bbx_trig_level_signed_32 = bbx_trig_level;

reg [15:0] bbx_state;
reg [15:0] bbx_state_tmp;

reg [11:0] bbx_start_idx;	//Ezeket kell atirni, ha nagyobb/kisebb bbx ram van a rendszerben
reg [11:0] bbx_pretrigger;
reg [11:0] bbx_idx;
reg [11:0] bbx_end_idx;   

reg [15:0] bbx_trigger_ch;
reg [15:0] bbx_trig_slope;
reg [15:0] bbx_tnow;
reg [15:0] bbx_tlevel_type;
reg [31:0] bbx_div;

reg [31:0] bbx_trig_ch_val_old;
wire signed [15:0] bbx_trig_ch_val_old_signed_16;
assign bbx_trig_ch_val_old_signed_16 = bbx_trig_ch_val_old[15:0];
wire signed [31:0] bbx_trig_ch_val_old_signed_32;
assign bbx_trig_ch_val_old_signed_32 = bbx_trig_ch_val_old;

wire [31:0] bbx_trig_ch_val;
assign bbx_trig_ch_val = bbx_val[bbx_trigger_ch];
wire signed [15:0] bbx_trig_ch_val_signed_16;
assign bbx_trig_ch_val_signed_16 = bbx_trig_ch_val[15:0];
wire signed [31:0] bbx_trig_ch_val_signed_32;
assign bbx_trig_ch_val_signed_32 = bbx_trig_ch_val;

reg [15:0] bbx_trig_delay;

monitor_RAM memory(
	.clka(clk),
	.wea(FPGA_Data_Write),
	.addra(FPGA_Addr),
	.dina(FPGA_Data_In),
	.douta(FPGA_Data_Out),
	.clkb(clk),
	.web(data_from_pc_write_enable),
	.addrb(data_from_pc_address),
	.dinb(data_from_pc_data_in),
	.doutb(data_from_pc_data_out));

wire [11:0] BBX_Addr;
wire [127:0] BBX_Data_in;
reg BBX_Data_Write;

wire [13:0] BBX_Addr_pc;
wire [31:0] BBX_Data_out_pc;


bbx_RAM bbx_memory(
	.clka(clk),
	.wea(BBX_Data_Write),
	.addra(BBX_Addr),
	.dina(BBX_Data_in),
	.clkb(clk),
	.web(0),
	.addrb(BBX_Addr_pc),
	.doutb(BBX_Data_out_pc));


Bus_Protocol Bus_Protocol(
   .Clk(clk),
	.Reset(reset),
   .RxD(RxD),
	.TxD(TxD),	 
	.data_from_pc_address(data_from_pc_address),
	.data_from_pc_data_in(data_from_pc_data_in),
	.data_from_pc_data_out(data_from_pc_data_out),
	.data_from_pc_write_enable(data_from_pc_write_enable),
	.BBX_Addr_pc(BBX_Addr_pc),
	.BBX_Data_out_pc(BBX_Data_out_pc)
);

reg [31:0]   data0_reg;
reg [31:0]   data1_reg;
reg [31:0]   data2_reg;
reg [31:0]   data3_reg;
reg [31:0]   data4_reg;
reg [31:0]   data5_reg;
reg [31:0]   data6_reg;
reg [31:0]   data7_reg;
reg [31:0]   data8_reg;
reg [31:0]   data9_reg;
reg [31:0]  data10_reg;
reg [31:0]  data11_reg;
reg [31:0]  data12_reg;
reg [31:0]  data13_reg;
reg [31:0]  data14_reg;
reg [31:0]  data15_reg;
reg [31:0]  data16_reg;
reg [31:0]  data17_reg;
reg [31:0]  data18_reg;
reg [31:0]  data19_reg;
reg [31:0]  data20_reg;
reg [31:0]  data21_reg;
reg [31:0]  data22_reg;
reg [31:0]  data23_reg;
reg [31:0]  data24_reg;
reg [31:0]  data25_reg;
reg [31:0]  data26_reg;
reg [31:0]  data27_reg;
reg [31:0]  data28_reg;
reg [31:0]  data29_reg;
reg [31:0]  data30_reg;
reg [31:0]  data31_reg;
reg [31:0]  data32_reg;
reg [31:0]  data33_reg;
reg [31:0]  data34_reg;
reg [31:0]  data35_reg;
reg [31:0]  data36_reg;
reg [31:0]  data37_reg;
reg [31:0]  data38_reg;
reg [31:0]  data39_reg;
reg [31:0]  data40_reg;
reg [31:0]  data41_reg;
reg [31:0]  data42_reg;
reg [31:0]  data43_reg;
reg [31:0]  data44_reg;
reg [31:0]  data45_reg;
reg [31:0]  data46_reg;
reg [31:0]  data47_reg;
reg [31:0]  data48_reg;
reg [31:0]  data49_reg;
reg [31:0]  data50_reg;
reg [31:0]  data51_reg;
reg [31:0]  data52_reg;
reg [31:0]  data53_reg;
reg [31:0]  data54_reg;
reg [31:0]  data55_reg;
reg [31:0]  data56_reg;
reg [31:0]  data57_reg;
reg [31:0]  data58_reg;
reg [31:0]  data59_reg;
reg [31:0]  data60_reg;
reg [31:0]  data61_reg;
reg [31:0]  data62_reg;
reg [31:0]  data63_reg;
reg [31:0]  data64_reg;
reg [31:0]  data65_reg;
reg [31:0]  data66_reg;
reg [31:0]  data67_reg;
reg [31:0]  data68_reg;
reg [31:0]  data69_reg;
reg [31:0]  data70_reg;
reg [31:0]  data71_reg;
reg [31:0]  data72_reg;
reg [31:0]  data73_reg;
reg [31:0]  data74_reg;
reg [31:0]  data75_reg;
reg [31:0]  data76_reg;
reg [31:0]  data77_reg;
reg [31:0]  data78_reg;
reg [31:0]  data79_reg;
reg [31:0]  data80_reg;
reg [31:0]  data81_reg;
reg [31:0]  data82_reg;
reg [31:0]  data83_reg;
reg [31:0]  data84_reg;
reg [31:0]  data85_reg;
reg [31:0]  data86_reg;
reg [31:0]  data87_reg;
reg [31:0]  data88_reg;
reg [31:0]  data89_reg;
reg [31:0]  data90_reg;
reg [31:0]  data91_reg;
reg [31:0]  data92_reg;
reg [31:0]  data93_reg;
reg [31:0]  data94_reg;
reg [31:0]  data95_reg;
reg [31:0]  data96_reg;
reg [31:0]  data97_reg;
reg [31:0]  data98_reg;
reg [31:0]  data99_reg;
reg [31:0] data100_reg;
reg [31:0] data101_reg;
reg [31:0] data102_reg;
reg [31:0] data103_reg;
reg [31:0] data104_reg;
reg [31:0] data105_reg;
reg [31:0] data106_reg;
reg [31:0] data107_reg;
reg [31:0] data108_reg;
reg [31:0] data109_reg;
reg [31:0] data110_reg;
reg [31:0] data111_reg;
reg [31:0] data112_reg;
reg [31:0] data113_reg;
reg [31:0] data114_reg;
reg [31:0] data115_reg;
reg [31:0] data116_reg;
reg [31:0] data117_reg;
reg [31:0] data118_reg;
reg [31:0] data119_reg;
reg [31:0] data120_reg;
reg [31:0] data121_reg;
reg [31:0] data122_reg;
reg [31:0] data123_reg;
reg [31:0] data124_reg;
reg [31:0] data125_reg;
reg [31:0] data126_reg;
reg [31:0] data127_reg;

always @ (posedge clk) 
begin
	
	if (FPGA_Data_Write) 
	begin
		FPGA_Data_Write <= 0;
	end
		//Memória feltöltése
		FPGA_Addr_next <= (FPGA_Addr_next == 1023) ? 0 : (FPGA_Addr_next + 1);
		FPGA_Addr <= FPGA_Addr_next;
		FPGA_Addr_prev <= FPGA_Addr;	
		
		case (FPGA_Addr_next)

			0: begin
				FPGA_Data_In <= data0_reg;
				FPGA_Data_Write <= 1;
			end	
 			2: begin
				FPGA_Data_In <= data1_reg;
				FPGA_Data_Write <= 1;
			end	
			4: begin
				FPGA_Data_In <= data2_reg;
				FPGA_Data_Write <= 1;
			end	
			6: begin
				FPGA_Data_In <= data3_reg;
				FPGA_Data_Write <= 1;
			end	
 			8: begin
				FPGA_Data_In <= data4_reg;
				FPGA_Data_Write <= 1;
			end	
			10: begin
				FPGA_Data_In <= data5_reg;
				FPGA_Data_Write <= 1;
			end
			12: begin
				FPGA_Data_In <= data6_reg;
				FPGA_Data_Write <= 1;
			end	
 			14: begin
				FPGA_Data_In <= data7_reg;
				FPGA_Data_Write <= 1;
			end	
			16: begin
				FPGA_Data_In <= data8_reg;
				FPGA_Data_Write <= 1;
			end	
			18: begin
				FPGA_Data_In <= data9_reg;
				FPGA_Data_Write <= 1;
			end	
 			20: begin
				FPGA_Data_In <= data10_reg;
				FPGA_Data_Write <= 1;
			end	
 			22: begin
				FPGA_Data_In <= data11_reg;
				FPGA_Data_Write <= 1;
			end
			24: begin
				FPGA_Data_In <= data12_reg;
				FPGA_Data_Write <= 1;
			end
			26: begin
				FPGA_Data_In <= data13_reg;
				FPGA_Data_Write <= 1;
			end
			28: begin
				FPGA_Data_In <= data14_reg;
				FPGA_Data_Write <= 1;
			end
			30: begin
				FPGA_Data_In <= data15_reg;
				FPGA_Data_Write <= 1;
			end
			32: begin
				FPGA_Data_In <= data16_reg;
				FPGA_Data_Write <= 1;
			end
			34: begin
				FPGA_Data_In <= data17_reg;
				FPGA_Data_Write <= 1;
			end
			36: begin
				FPGA_Data_In <= data18_reg;
				FPGA_Data_Write <= 1;
			end
			38: begin
				FPGA_Data_In <= data19_reg;
				FPGA_Data_Write <= 1;
			end
			40: begin
				FPGA_Data_In <= data20_reg;
				FPGA_Data_Write <= 1;
			end
			42: begin
				FPGA_Data_In <= data21_reg;
				FPGA_Data_Write <= 1;
			end
			44: begin
				FPGA_Data_In <= data22_reg;
				FPGA_Data_Write <= 1;
			end
			46: begin
				FPGA_Data_In <= data23_reg;
				FPGA_Data_Write <= 1;
			end
			48: begin
				FPGA_Data_In <= data24_reg;
				FPGA_Data_Write <= 1;
			end
			50: begin
				FPGA_Data_In <= data25_reg;
				FPGA_Data_Write <= 1;
			end
			52: begin
				FPGA_Data_In <= data26_reg;
				FPGA_Data_Write <= 1;
			end
			54: begin
				FPGA_Data_In <= data27_reg;
				FPGA_Data_Write <= 1;
			end
			56: begin
				FPGA_Data_In <= data28_reg;
				FPGA_Data_Write <= 1;
			end
			58: begin
				FPGA_Data_In <= data29_reg;
				FPGA_Data_Write <= 1;
			end
			60: begin
				FPGA_Data_In <= data30_reg;
				FPGA_Data_Write <= 1;
			end
			62: begin
				FPGA_Data_In <= data31_reg;
				FPGA_Data_Write <= 1;
			end
			64: begin
				FPGA_Data_In <= data32_reg;
				FPGA_Data_Write <= 1;
			end
			66: begin
				FPGA_Data_In <= data33_reg;
				FPGA_Data_Write <= 1;
			end
			68: begin
				FPGA_Data_In <= data34_reg;
				FPGA_Data_Write <= 1;
			end
			70: begin
				FPGA_Data_In <= data35_reg;
				FPGA_Data_Write <= 1;
			end
			72: begin
				FPGA_Data_In <= data36_reg;
				FPGA_Data_Write <= 1;
			end
			74: begin
				FPGA_Data_In <= data37_reg;
				FPGA_Data_Write <= 1;
			end
			76: begin
				FPGA_Data_In <= data38_reg;
				FPGA_Data_Write <= 1;
			end
			78: begin
				FPGA_Data_In <= data39_reg;
				FPGA_Data_Write <= 1;
			end
			80: begin
				FPGA_Data_In <= data40_reg;
				FPGA_Data_Write <= 1;
			end
			82: begin
				FPGA_Data_In <= data41_reg;
				FPGA_Data_Write <= 1;
			end
			84: begin
				FPGA_Data_In <= data42_reg;
				FPGA_Data_Write <= 1;
			end
			86: begin
				FPGA_Data_In <= data43_reg;
				FPGA_Data_Write <= 1;
			end
			88: begin
				FPGA_Data_In <= data44_reg;
				FPGA_Data_Write <= 1;
			end
			90: begin
				FPGA_Data_In <= data45_reg;
				FPGA_Data_Write <= 1;
			end
			92: begin
				FPGA_Data_In <= data46_reg;
				FPGA_Data_Write <= 1;
			end
			94: begin
				FPGA_Data_In <= data47_reg;
				FPGA_Data_Write <= 1;
			end
			96: begin
				FPGA_Data_In <= data48_reg;
				FPGA_Data_Write <= 1;
			end
			98: begin
				FPGA_Data_In <= data49_reg;
				FPGA_Data_Write <= 1;
			end
			100: begin
				FPGA_Data_In <= data50_reg;
				FPGA_Data_Write <= 1;
			end
			102: begin
				FPGA_Data_In <= data51_reg;
				FPGA_Data_Write <= 1;
			end
			104: begin
				FPGA_Data_In <= data52_reg;
				FPGA_Data_Write <= 1;
			end
			106: begin
				FPGA_Data_In <= data53_reg;
				FPGA_Data_Write <= 1;
			end
			108: begin
				FPGA_Data_In <= data54_reg;
				FPGA_Data_Write <= 1;
			end
			110: begin
				FPGA_Data_In <= data55_reg;
				FPGA_Data_Write <= 1;
			end
			112: begin
				FPGA_Data_In <= data56_reg;
				FPGA_Data_Write <= 1;
			end
			114: begin
				FPGA_Data_In <= data57_reg;
				FPGA_Data_Write <= 1;
			end
			116: begin
				FPGA_Data_In <= data58_reg;
				FPGA_Data_Write <= 1;
			end
			118: begin
				FPGA_Data_In <= data59_reg;
				FPGA_Data_Write <= 1;
			end
			120: begin
				FPGA_Data_In <= data60_reg;
				FPGA_Data_Write <= 1;
			end
			122: begin
				FPGA_Data_In <= data61_reg;
				FPGA_Data_Write <= 1;
			end
			124: begin
				FPGA_Data_In <= data62_reg;
				FPGA_Data_Write <= 1;
			end
			126: begin
				FPGA_Data_In <= data63_reg;
				FPGA_Data_Write <= 1;
			end
			128: begin
                FPGA_Data_In <= data64_reg;
                FPGA_Data_Write <= 1;
            end    
            130: begin
                FPGA_Data_In <= data65_reg;
                FPGA_Data_Write <= 1;
            end    
            132: begin
                FPGA_Data_In <= data66_reg;
                FPGA_Data_Write <= 1;
            end    
            134: begin
                FPGA_Data_In <= data67_reg;
                FPGA_Data_Write <= 1;
            end    
             136: begin
                FPGA_Data_In <= data68_reg;
                FPGA_Data_Write <= 1;
            end    
            138: begin
                FPGA_Data_In <= data69_reg;
                FPGA_Data_Write <= 1;
            end
            140: begin
                FPGA_Data_In <= data70_reg;
                FPGA_Data_Write <= 1;
            end    
            142: begin
                FPGA_Data_In <= data71_reg;
                FPGA_Data_Write <= 1;
            end    
            144: begin
                FPGA_Data_In <= data72_reg;
                FPGA_Data_Write <= 1;
            end    
            146: begin
                FPGA_Data_In <= data73_reg;
                FPGA_Data_Write <= 1;
            end    
            148: begin
                FPGA_Data_In <= data74_reg;
                FPGA_Data_Write <= 1;
            end    
            150: begin
                FPGA_Data_In <= data75_reg;
                FPGA_Data_Write <= 1;
            end
            152: begin
                FPGA_Data_In <= data76_reg;
                FPGA_Data_Write <= 1;
            end
            154: begin
                FPGA_Data_In <= data77_reg;
                FPGA_Data_Write <= 1;
            end
            156: begin
                FPGA_Data_In <= data78_reg;
                FPGA_Data_Write <= 1;
            end
            158: begin
                FPGA_Data_In <= data79_reg;
                FPGA_Data_Write <= 1;
            end
            160: begin
                FPGA_Data_In <= data80_reg;
                FPGA_Data_Write <= 1;
            end
            162: begin
                FPGA_Data_In <= data81_reg;
                FPGA_Data_Write <= 1;
            end
            164: begin
                FPGA_Data_In <= data82_reg;
                FPGA_Data_Write <= 1;
            end
            166: begin
                FPGA_Data_In <= data83_reg;
                FPGA_Data_Write <= 1;
            end
            168: begin
                FPGA_Data_In <= data84_reg;
                FPGA_Data_Write <= 1;
            end
            170: begin
                FPGA_Data_In <= data85_reg;
                FPGA_Data_Write <= 1;
            end
            172: begin
                FPGA_Data_In <= data86_reg;
                FPGA_Data_Write <= 1;
            end
            174: begin
                FPGA_Data_In <= data87_reg;
                FPGA_Data_Write <= 1;
            end
            176: begin
                FPGA_Data_In <= data88_reg;
                FPGA_Data_Write <= 1;
            end
            178: begin
                FPGA_Data_In <= data89_reg;
                FPGA_Data_Write <= 1;
            end
            180: begin
                FPGA_Data_In <= data90_reg;
                FPGA_Data_Write <= 1;
            end
            182: begin
                FPGA_Data_In <= data91_reg;
                FPGA_Data_Write <= 1;
            end
            184: begin
                FPGA_Data_In <= data92_reg;
                FPGA_Data_Write <= 1;
            end
            186: begin
                FPGA_Data_In <= data93_reg;
                FPGA_Data_Write <= 1;
            end
            188: begin
                FPGA_Data_In <= data94_reg;
                FPGA_Data_Write <= 1;
            end
            190: begin
                FPGA_Data_In <= data95_reg;
                FPGA_Data_Write <= 1;
            end
            192: begin
                FPGA_Data_In <= data96_reg;
                FPGA_Data_Write <= 1;
            end
            194: begin
                FPGA_Data_In <= data97_reg;
                FPGA_Data_Write <= 1;
            end
            196: begin
                FPGA_Data_In <= data98_reg;
                FPGA_Data_Write <= 1;
            end
            198: begin
                FPGA_Data_In <= data99_reg;
                FPGA_Data_Write <= 1;
            end
            200: begin
                FPGA_Data_In <= data100_reg;
                FPGA_Data_Write <= 1;
            end
            202: begin
                FPGA_Data_In <= data101_reg;
                FPGA_Data_Write <= 1;
            end
            204: begin
                FPGA_Data_In <= data102_reg;
                FPGA_Data_Write <= 1;
            end
            206: begin
                FPGA_Data_In <= data103_reg;
                FPGA_Data_Write <= 1;
            end
            208: begin
                FPGA_Data_In <= data104_reg;
                FPGA_Data_Write <= 1;
            end
            210: begin
                FPGA_Data_In <= data105_reg;
                FPGA_Data_Write <= 1;
            end
            212: begin
                FPGA_Data_In <= data106_reg;
                FPGA_Data_Write <= 1;
            end
            214: begin
                FPGA_Data_In <= data107_reg;
                FPGA_Data_Write <= 1;
            end
            216: begin
                FPGA_Data_In <= data108_reg;
                FPGA_Data_Write <= 1;
            end
            218: begin
                FPGA_Data_In <= data109_reg;
                FPGA_Data_Write <= 1;
            end
            220: begin
                FPGA_Data_In <= data110_reg;
                FPGA_Data_Write <= 1;
            end
            222: begin
                FPGA_Data_In <= data111_reg;
                FPGA_Data_Write <= 1;
            end
            224: begin
                FPGA_Data_In <= data112_reg;
                FPGA_Data_Write <= 1;
            end
            226: begin
                FPGA_Data_In <= data113_reg;
                FPGA_Data_Write <= 1;
            end
            228: begin
                FPGA_Data_In <= data114_reg;
                FPGA_Data_Write <= 1;
            end
            230: begin
                FPGA_Data_In <= data115_reg;
                FPGA_Data_Write <= 1;
            end
            232: begin
                FPGA_Data_In <= data116_reg;
                FPGA_Data_Write <= 1;
            end
            234: begin
                FPGA_Data_In <= data117_reg;
                FPGA_Data_Write <= 1;
            end
            236: begin
                FPGA_Data_In <= data118_reg;
                FPGA_Data_Write <= 1;
            end
            238: begin
                FPGA_Data_In <= data119_reg;
                FPGA_Data_Write <= 1;
            end
            240: begin
                FPGA_Data_In <= data120_reg;
                FPGA_Data_Write <= 1;
            end
            242: begin
                FPGA_Data_In <= data121_reg;
                FPGA_Data_Write <= 1;
            end
            244: begin
                FPGA_Data_In <= data122_reg;
                FPGA_Data_Write <= 1;
            end
            246: begin
                FPGA_Data_In <= data123_reg;
                FPGA_Data_Write <= 1;
            end
            248: begin
                FPGA_Data_In <= data124_reg;
                FPGA_Data_Write <= 1;
            end
            250: begin
                FPGA_Data_In <= data125_reg;
                FPGA_Data_Write <= 1;
            end
            252: begin
                FPGA_Data_In <= data126_reg;
                FPGA_Data_Write <= 1;
            end
            254: begin
                FPGA_Data_In <= data127_reg;
                FPGA_Data_Write <= 1;
            end

			560: begin
				if (((bbx_state == 2) || (bbx_state == 3)) && bbx_state_tmp != 3 && bbx_state_tmp != 0) begin
					FPGA_Data_In <= bbx_state;
					FPGA_Data_Write <= 1;
				end
			end
			561: begin
				FPGA_Data_In <= bbx_start_idx;
				FPGA_Data_Write <= 1;
			end	
			565: begin
				if ((bbx_state == 2) || (bbx_state == 3)) begin		
					bbx_tnow <= 0;				
					FPGA_Data_In <= 0; //bbx_tnow <= 0;	
					FPGA_Data_Write <= 1;
				end					
			end				
			567: begin
				FPGA_Data_In <= bbx_idx;
				FPGA_Data_Write <= 1;
			end	
			575: begin
				FPGA_Data_In <= bbx_end_idx;
				FPGA_Data_Write <= 1;
			end	
			default: begin
				//nincs meg a változó
			end
		endcase

		case (FPGA_Addr_prev)
			256: param0 <= FPGA_Data_Out;
			258: param1 <= FPGA_Data_Out;
			260: param2 <= FPGA_Data_Out;
			262: param3 <= FPGA_Data_Out;
			264: param4 <= FPGA_Data_Out;
			266: param5 <= FPGA_Data_Out;
			268: param6 <= FPGA_Data_Out;
			270: param7 <= FPGA_Data_Out;
			272: param8 <= FPGA_Data_Out;
			274: param9 <= FPGA_Data_Out;		
			276: param10 <= FPGA_Data_Out;	
			278: param11 <= FPGA_Data_Out;		
			280: param12 <= FPGA_Data_Out;	
			282: param13 <= FPGA_Data_Out;	
			284: param14 <= FPGA_Data_Out;					
			286: param15 <= FPGA_Data_Out;
			288: param16 <= FPGA_Data_Out;
			290: param17 <= FPGA_Data_Out;
			292: param18 <= FPGA_Data_Out;
			294: param19 <= FPGA_Data_Out;
			296: param20 <= FPGA_Data_Out;
			298: param21 <= FPGA_Data_Out;
			300: param22 <= FPGA_Data_Out;
			302: param23 <= FPGA_Data_Out;	
			304: param24 <= FPGA_Data_Out;
			306: param25 <= FPGA_Data_Out;
			308: param26 <= FPGA_Data_Out;	
			310: param27 <= FPGA_Data_Out;
			312: param28 <= FPGA_Data_Out;
			314: param29 <= FPGA_Data_Out;
			316: param30 <= FPGA_Data_Out;
			318: param31 <= FPGA_Data_Out;
			320: param32 <= FPGA_Data_Out;
			322: param33 <= FPGA_Data_Out;
			324: param34 <= FPGA_Data_Out;
			326: param35 <= FPGA_Data_Out;
			328: param36 <= FPGA_Data_Out;
			330: param37 <= FPGA_Data_Out;
			332: param38 <= FPGA_Data_Out;
			334: param39 <= FPGA_Data_Out;
			336: param40 <= FPGA_Data_Out;
			338: param41 <= FPGA_Data_Out;
			340: param42 <= FPGA_Data_Out;
			342: param43 <= FPGA_Data_Out;
			344: param44 <= FPGA_Data_Out;
			346: param45 <= FPGA_Data_Out;
			348: param46 <= FPGA_Data_Out;
			350: param47 <= FPGA_Data_Out;
			352: param48 <= FPGA_Data_Out;
			354: param49 <= FPGA_Data_Out;
			356: param50 <= FPGA_Data_Out;
			358: param51 <= FPGA_Data_Out;
			360: param52 <= FPGA_Data_Out;
			362: param53 <= FPGA_Data_Out;
			364: param54 <= FPGA_Data_Out;
			366: param55 <= FPGA_Data_Out;
			368: param56 <= FPGA_Data_Out;
			370: param57 <= FPGA_Data_Out;
			372: param58 <= FPGA_Data_Out;
			374: param59 <= FPGA_Data_Out;
			376: param60 <= FPGA_Data_Out;
			378: param61 <= FPGA_Data_Out;
			380: param62 <= FPGA_Data_Out;
			382: param63 <= FPGA_Data_Out;
			384: param64 <= FPGA_Data_Out;
            386: param65 <= FPGA_Data_Out;
            388: param66 <= FPGA_Data_Out;
            390: param67 <= FPGA_Data_Out;
            392: param68 <= FPGA_Data_Out;
            394: param69 <= FPGA_Data_Out;
            396: param70 <= FPGA_Data_Out;
            398: param71 <= FPGA_Data_Out;
            400: param72 <= FPGA_Data_Out;
            402: param73 <= FPGA_Data_Out;        
            404: param74 <= FPGA_Data_Out;    
            406: param75 <= FPGA_Data_Out;        
            408: param76 <= FPGA_Data_Out;    
            410: param77 <= FPGA_Data_Out;    
            412: param78 <= FPGA_Data_Out;                    
            414: param79 <= FPGA_Data_Out;
            416: param80 <= FPGA_Data_Out;
            418: param81 <= FPGA_Data_Out;
            420: param82 <= FPGA_Data_Out;
            422: param83 <= FPGA_Data_Out;
            424: param84 <= FPGA_Data_Out;
            426: param85 <= FPGA_Data_Out;
            428: param86 <= FPGA_Data_Out;
            430: param87 <= FPGA_Data_Out;    
            432: param88 <= FPGA_Data_Out;
            434: param89 <= FPGA_Data_Out;
            436: param90 <= FPGA_Data_Out;    
            438: param91 <= FPGA_Data_Out;
            440: param92 <= FPGA_Data_Out;
            442: param93 <= FPGA_Data_Out;
            444: param94 <= FPGA_Data_Out;
            446: param95 <= FPGA_Data_Out;
            448: param96 <= FPGA_Data_Out;
            450: param97 <= FPGA_Data_Out;
            452: param98 <= FPGA_Data_Out;
            454: param99 <= FPGA_Data_Out;
            456: param100 <= FPGA_Data_Out;
            458: param101 <= FPGA_Data_Out;
            460: param102 <= FPGA_Data_Out;
            462: param103 <= FPGA_Data_Out;
            464: param104 <= FPGA_Data_Out;
            466: param105 <= FPGA_Data_Out;
            468: param106 <= FPGA_Data_Out;
            470: param107 <= FPGA_Data_Out;
            472: param108 <= FPGA_Data_Out;
            474: param109 <= FPGA_Data_Out;
            476: param110 <= FPGA_Data_Out;
            478: param111 <= FPGA_Data_Out;
            480: param112 <= FPGA_Data_Out;
            482: param113 <= FPGA_Data_Out;
            484: param114 <= FPGA_Data_Out;
            486: param115 <= FPGA_Data_Out;
            488: param116 <= FPGA_Data_Out;
            490: param117 <= FPGA_Data_Out;
            492: param118 <= FPGA_Data_Out;
            494: param119 <= FPGA_Data_Out;
            496: param120 <= FPGA_Data_Out;
            498: param121 <= FPGA_Data_Out;
            500: param122 <= FPGA_Data_Out;
            502: param123 <= FPGA_Data_Out;
            504: param124 <= FPGA_Data_Out;
            506: param125 <= FPGA_Data_Out;
            508: param126 <= FPGA_Data_Out;
            510: param127 <= FPGA_Data_Out;			
			//BBX Változók amiket a PC ír
			544: bbx_val_addr[0] <= FPGA_Data_Out;
			546: bbx_val_addr[1] <= FPGA_Data_Out;
			548: bbx_val_addr[2] <= FPGA_Data_Out;
			550: bbx_val_addr[3] <= FPGA_Data_Out;		
			556: bbx_sample_time <= FPGA_Data_Out - 1;	
			558: bbx_trig_level <= FPGA_Data_Out;	
			560: bbx_state_tmp <= FPGA_Data_Out;
			562: bbx_trigger_ch <= FPGA_Data_Out;	
			563: bbx_pretrigger <= FPGA_Data_Out;	
			564: bbx_trig_slope <= FPGA_Data_Out;	
			565: bbx_tnow <= FPGA_Data_Out;	
			566: bbx_tlevel_type <= FPGA_Data_Out;	
			default: begin
				//nincs meg a változó
			end
		endcase	
		
	  data0_reg <=   data0;
	  data1_reg <=   data1;
	  data2_reg <=   data2;
	  data3_reg <=   data3;
	  data4_reg <=   data4;
	  data5_reg <=   data5;
	  data6_reg <=   data6;
	  data7_reg <=   data7;
	  data8_reg <=   data8;
	  data9_reg <=   data9;
	 data10_reg <=  data10;
	 data11_reg <=  data11;
	 data12_reg <=  data12;
	 data13_reg <=  data13;
	 data14_reg <=  data14;
	 data15_reg <=  data15;
	 data16_reg <=  data16;
	 data17_reg <=  data17;
	 data18_reg <=  data18;
	 data19_reg <=  data19;
	 data20_reg <=  data20;
	 data21_reg <=  data21;
	 data22_reg <=  data22;
	 data23_reg <=  data23;
	 data24_reg <=  data24;
	 data25_reg <=  data25;
	 data26_reg <=  data26;
	 data27_reg <=  data27;
	 data28_reg <=  data28;
	 data29_reg <=  data29;
	 data30_reg <=  data30;
	 data31_reg <=  data31;
	 data32_reg <=  data32;
	 data33_reg <=  data33;
	 data34_reg <=  data34;
	 data35_reg <=  data35;
	 data36_reg <=  data36;
	 data37_reg <=  data37;
	 data38_reg <=  data38;
	 data39_reg <=  data39;
	 data40_reg <=  data40;
	 data41_reg <=  data41;
	 data42_reg <=  data42;
	 data43_reg <=  data43;
	 data44_reg <=  data44;
	 data45_reg <=  data45;
	 data46_reg <=  data46;
	 data47_reg <=  data47;
	 data48_reg <=  data48;
	 data49_reg <=  data49;
	 data50_reg <=  data50;
	 data51_reg <=  data51;
	 data52_reg <=  data52;
	 data53_reg <=  data53;
	 data54_reg <=  data54;
	 data55_reg <=  data55;
	 data56_reg <=  data56;
	 data57_reg <=  data57;
	 data58_reg <=  data58;
	 data59_reg <=  data59;
	 data60_reg <=  data60;
	 data61_reg <=  data61;
	 data62_reg <=  data62;
	 data63_reg <=  data63;
	 data64_reg <=  data64;
	 data65_reg <=  data65;
	 data66_reg <=  data66;
	 data67_reg <=  data67;
	 data68_reg <=  data68;
	 data69_reg <=  data69;
	 data70_reg <=  data70;
	 data71_reg <=  data71;
	 data72_reg <=  data72;
	 data73_reg <=  data73;
	 data74_reg <=  data74;
	 data75_reg <=  data75;
	 data76_reg <=  data76;
	 data77_reg <=  data77;
	 data78_reg <=  data78;
	 data79_reg <=  data79;
	 data80_reg <=  data80;
	 data81_reg <=  data81;
	 data82_reg <=  data82;
	 data83_reg <=  data83;
	 data84_reg <=  data84;
	 data85_reg <=  data85;
	 data86_reg <=  data86;
	 data87_reg <=  data87;
	 data88_reg <=  data88;
	 data89_reg <=  data89;
	 data90_reg <=  data90;
	 data91_reg <=  data91;
	 data92_reg <=  data92;
	 data93_reg <=  data93;
	 data94_reg <=  data94;
	 data95_reg <=  data95;
	 data96_reg <=  data96;
	 data97_reg <=  data97;
	 data98_reg <=  data98;
	 data99_reg <=  data99;
	data100_reg <= data100;
	data101_reg <= data101;
	data102_reg <= data102;
	data103_reg <= data103;
	data104_reg <= data104;
	data105_reg <= data105;
	data106_reg <= data106;
	data107_reg <= data107;
	data108_reg <= data108;
	data109_reg <= data109;
	data110_reg <= data110;
	data111_reg <= data111;
	data112_reg <= data112;
	data113_reg <= data113;
	data114_reg <= data114;
	data115_reg <= data115;
	data116_reg <= data116;
	data117_reg <= data117;
	data118_reg <= data118;
	data119_reg <= data119;
	data120_reg <= data120;
	data121_reg <= data121;
	data122_reg <= data122;
	data123_reg <= data123;
	data124_reg <= data124;
	data125_reg <= data125;
	data126_reg <= data126;
	data127_reg <= data127;
end

BBX_MPX BBX_MPX_Ch0(
	.Clk(clk),
	.address(bbx_val_addr[0]),
	.data0(data0_reg),
	.data1(data1_reg),
	.data2(data2_reg),
	.data3(data3_reg),
	.data4(data4_reg),
	.data5(data5_reg),
	.data6(data6_reg),
	.data7(data7_reg),
	.data8(data8_reg),
	.data9(data9_reg),
	.data10(data10_reg),
	.data11(data11_reg),
	.data12(data12_reg),
	.data13(data13_reg),
	.data14(data14_reg),
	.data15(data15_reg),
	.data16(data16_reg),
	.data17(data17_reg),
	.data18(data18_reg),
	.data19(data19_reg),
	.data20(data20_reg),
	.data21(data21_reg),
	.data22(data22_reg),
	.data23(data23_reg),
	.data24(data24_reg),
	.data25(data25_reg),
	.data26(data26_reg),
	.data27(data27_reg),
	.data28(data28_reg),
	.data29(data29_reg),
	.data30(data30_reg),
	.data31(data31_reg),
	.data32(data32_reg),
	.data33(data33_reg),
	.data34(data34_reg),
	.data35(data35_reg),
	.data36(data36_reg),
	.data37(data37_reg),
	.data38(data38_reg),
	.data39(data39_reg),
	.data40(data40_reg),
	.data41(data41_reg),
	.data42(data42_reg),
	.data43(data43_reg),
	.data44(data44_reg),
	.data45(data45_reg),
	.data46(data46_reg),
	.data47(data47_reg),
	.data48(data48_reg),
	.data49(data49_reg),
	.data50(data50_reg),
	.data51(data51_reg),
	.data52(data52_reg),
	.data53(data53_reg),
	.data54(data54_reg),
	.data55(data55_reg),
	.data56(data56_reg),
	.data57(data57_reg),
	.data58(data58_reg),
	.data59(data59_reg),
	.data60(data60_reg),
	.data61(data61_reg),
	.data62(data62_reg),
	.data63(data63_reg),
	.data64(data64_reg),
    .data65(data65_reg),
    .data66(data66_reg),
    .data67(data67_reg),
    .data68(data68_reg),
    .data69(data69_reg),
    .data70(data70_reg),
    .data71(data71_reg),
    .data72(data72_reg),
    .data73(data73_reg),
    .data74(data74_reg),
    .data75(data75_reg),
    .data76(data76_reg),
    .data77(data77_reg),
    .data78(data78_reg),
    .data79(data79_reg),
    .data80(data80_reg),
    .data81(data81_reg),
    .data82(data82_reg),
    .data83(data83_reg),
    .data84(data84_reg),
    .data85(data85_reg),
    .data86(data86_reg),
    .data87(data87_reg),
    .data88(data88_reg),
    .data89(data89_reg),
    .data90(data90_reg),
    .data91(data91_reg),
    .data92(data92_reg),
    .data93(data93_reg),
    .data94(data94_reg),
    .data95(data95_reg),
    .data96(data96_reg),
    .data97(data97_reg),
    .data98(data98_reg),
    .data99(data99_reg),
    .data100(data100_reg),
    .data101(data101_reg),
    .data102(data102_reg),
    .data103(data103_reg),
    .data104(data104_reg),
    .data105(data105_reg),
    .data106(data106_reg),
    .data107(data107_reg),
    .data108(data108_reg),
    .data109(data109_reg),
    .data110(data110_reg),
    .data111(data111_reg),
    .data112(data112_reg),
    .data113(data113_reg),
    .data114(data114_reg),
    .data115(data115_reg),
    .data116(data116_reg),
    .data117(data117_reg),
    .data118(data118_reg),
    .data119(data119_reg),
    .data120(data120_reg),
    .data121(data121_reg),
    .data122(data122_reg),
    .data123(data123_reg),
    .data124(data124_reg),
    .data125(data125_reg),
    .data126(data126_reg),
    .data127(data127_reg),
	.param0(param0),
    .param1(param1),
    .param2(param2),
    .param3(param3),
    .param4(param4),
    .param5(param5),
    .param6(param6),
    .param7(param7),
    .param8(param8),
    .param9(param9),
    .param10(param10),
    .param11(param11),
    .param12(param12),
    .param13(param13),
    .param14(param14),
    .param15(param15),
    .param16(param16),
    .param17(param17),
    .param18(param18),
    .param19(param19),
    .param20(param20),
    .param21(param21),
    .param22(param22),
    .param23(param23),
    .param24(param24),
    .param25(param25),
    .param26(param26),
    .param27(param27),
    .param28(param28),
    .param29(param29),
    .param30(param30),
    .param31(param31),
    .param32(param32),
    .param33(param33),
    .param34(param34),
    .param35(param35),
    .param36(param36),
    .param37(param37),
    .param38(param38),
    .param39(param39),
    .param40(param40),
    .param41(param41),
    .param42(param42),
    .param43(param43),
    .param44(param44),
    .param45(param45),
    .param46(param46),
    .param47(param47),
    .param48(param48),
    .param49(param49),
    .param50(param50),
    .param51(param51),
    .param52(param52),
    .param53(param53),
    .param54(param54),
    .param55(param55),
    .param56(param56),
    .param57(param57),
    .param58(param58),
    .param59(param59),
    .param60(param60),
    .param61(param61),
    .param62(param62),
    .param63(param63),
    .param64(param64),
    .param65(param65),
    .param66(param66),
    .param67(param67),
    .param68(param68),
    .param69(param69),
    .param70(param70),
    .param71(param71),
    .param72(param72),
    .param73(param73),
    .param74(param74),
    .param75(param75),
    .param76(param76),
    .param77(param77),
    .param78(param78),
    .param79(param79),
    .param80(param80),
    .param81(param81),
    .param82(param82),
    .param83(param83),
    .param84(param84),
    .param85(param85),
    .param86(param86),
    .param87(param87),
    .param88(param88),
    .param89(param89),
    .param90(param90),
    .param91(param91),
    .param92(param92),
    .param93(param93),
    .param94(param94),
    .param95(param95),
    .param96(param96),
    .param97(param97),
    .param98(param98),
    .param99(param99),
    .param100(param100),
    .param101(param101),
    .param102(param102),
    .param103(param103),
    .param104(param104),
    .param105(param105),
    .param106(param106),
    .param107(param107),
    .param108(param108),
    .param109(param109),
    .param110(param110),
    .param111(param111),
    .param112(param112),
    .param113(param113),
    .param114(param114),
    .param115(param115),
    .param116(param116),
    .param117(param117),
    .param118(param118),
    .param119(param119),
    .param120(param120),
    .param121(param121),
    .param122(param122),
    .param123(param123),
    .param124(param124),
    .param125(param125),
    .param126(param126),
    .param127(param127),
	.value(bbx_val[0])
);

BBX_MPX BBX_MPX_Ch1(
	.Clk(clk),
	.address(bbx_val_addr[1]),
	.data0(data0_reg),
	.data1(data1_reg),
	.data2(data2_reg),
	.data3(data3_reg),
	.data4(data4_reg),
	.data5(data5_reg),
	.data6(data6_reg),
	.data7(data7_reg),
	.data8(data8_reg),
	.data9(data9_reg),
	.data10(data10_reg),
	.data11(data11_reg),
	.data12(data12_reg),
	.data13(data13_reg),
	.data14(data14_reg),
	.data15(data15_reg),
	.data16(data16_reg),
	.data17(data17_reg),
	.data18(data18_reg),
	.data19(data19_reg),
	.data20(data20_reg),
	.data21(data21_reg),
	.data22(data22_reg),
	.data23(data23_reg),
	.data24(data24_reg),
	.data25(data25_reg),
	.data26(data26_reg),
	.data27(data27_reg),
	.data28(data28_reg),
	.data29(data29_reg),
	.data30(data30_reg),
	.data31(data31_reg),
	.data32(data32_reg),
	.data33(data33_reg),
	.data34(data34_reg),
	.data35(data35_reg),
	.data36(data36_reg),
	.data37(data37_reg),
	.data38(data38_reg),
	.data39(data39_reg),
	.data40(data40_reg),
	.data41(data41_reg),
	.data42(data42_reg),
	.data43(data43_reg),
	.data44(data44_reg),
	.data45(data45_reg),
	.data46(data46_reg),
	.data47(data47_reg),
	.data48(data48_reg),
	.data49(data49_reg),
	.data50(data50_reg),
	.data51(data51_reg),
	.data52(data52_reg),
	.data53(data53_reg),
	.data54(data54_reg),
	.data55(data55_reg),
	.data56(data56_reg),
	.data57(data57_reg),
	.data58(data58_reg),
	.data59(data59_reg),
	.data60(data60_reg),
	.data61(data61_reg),
	.data62(data62_reg),
	.data63(data63_reg),
	.data64(data64_reg),
    .data65(data65_reg),
    .data66(data66_reg),
    .data67(data67_reg),
    .data68(data68_reg),
    .data69(data69_reg),
    .data70(data70_reg),
    .data71(data71_reg),
    .data72(data72_reg),
    .data73(data73_reg),
    .data74(data74_reg),
    .data75(data75_reg),
    .data76(data76_reg),
    .data77(data77_reg),
    .data78(data78_reg),
    .data79(data79_reg),
    .data80(data80_reg),
    .data81(data81_reg),
    .data82(data82_reg),
    .data83(data83_reg),
    .data84(data84_reg),
    .data85(data85_reg),
    .data86(data86_reg),
    .data87(data87_reg),
    .data88(data88_reg),
    .data89(data89_reg),
    .data90(data90_reg),
    .data91(data91_reg),
    .data92(data92_reg),
    .data93(data93_reg),
    .data94(data94_reg),
    .data95(data95_reg),
    .data96(data96_reg),
    .data97(data97_reg),
    .data98(data98_reg),
    .data99(data99_reg),
    .data100(data100_reg),
    .data101(data101_reg),
    .data102(data102_reg),
    .data103(data103_reg),
    .data104(data104_reg),
    .data105(data105_reg),
    .data106(data106_reg),
    .data107(data107_reg),
    .data108(data108_reg),
    .data109(data109_reg),
    .data110(data110_reg),
    .data111(data111_reg),
    .data112(data112_reg),
    .data113(data113_reg),
    .data114(data114_reg),
    .data115(data115_reg),
    .data116(data116_reg),
    .data117(data117_reg),
    .data118(data118_reg),
    .data119(data119_reg),
    .data120(data120_reg),
    .data121(data121_reg),
    .data122(data122_reg),
    .data123(data123_reg),
    .data124(data124_reg),
    .data125(data125_reg),
    .data126(data126_reg),
    .data127(data127_reg),
    .param0(param0),
    .param1(param1),
    .param2(param2),
    .param3(param3),
    .param4(param4),
    .param5(param5),
    .param6(param6),
    .param7(param7),
    .param8(param8),
    .param9(param9),
    .param10(param10),
    .param11(param11),
    .param12(param12),
    .param13(param13),
    .param14(param14),
    .param15(param15),
    .param16(param16),
    .param17(param17),
    .param18(param18),
    .param19(param19),
    .param20(param20),
    .param21(param21),
    .param22(param22),
    .param23(param23),
    .param24(param24),
    .param25(param25),
    .param26(param26),
    .param27(param27),
    .param28(param28),
    .param29(param29),
    .param30(param30),
    .param31(param31),
    .param32(param32),
    .param33(param33),
    .param34(param34),
    .param35(param35),
    .param36(param36),
    .param37(param37),
    .param38(param38),
    .param39(param39),
    .param40(param40),
    .param41(param41),
    .param42(param42),
    .param43(param43),
    .param44(param44),
    .param45(param45),
    .param46(param46),
    .param47(param47),
    .param48(param48),
    .param49(param49),
    .param50(param50),
    .param51(param51),
    .param52(param52),
    .param53(param53),
    .param54(param54),
    .param55(param55),
    .param56(param56),
    .param57(param57),
    .param58(param58),
    .param59(param59),
    .param60(param60),
    .param61(param61),
    .param62(param62),
    .param63(param63),
    .param64(param64),
    .param65(param65),
    .param66(param66),
    .param67(param67),
    .param68(param68),
    .param69(param69),
    .param70(param70),
    .param71(param71),
    .param72(param72),
    .param73(param73),
    .param74(param74),
    .param75(param75),
    .param76(param76),
    .param77(param77),
    .param78(param78),
    .param79(param79),
    .param80(param80),
    .param81(param81),
    .param82(param82),
    .param83(param83),
    .param84(param84),
    .param85(param85),
    .param86(param86),
    .param87(param87),
    .param88(param88),
    .param89(param89),
    .param90(param90),
    .param91(param91),
    .param92(param92),
    .param93(param93),
    .param94(param94),
    .param95(param95),
    .param96(param96),
    .param97(param97),
    .param98(param98),
    .param99(param99),
    .param100(param100),
    .param101(param101),
    .param102(param102),
    .param103(param103),
    .param104(param104),
    .param105(param105),
    .param106(param106),
    .param107(param107),
    .param108(param108),
    .param109(param109),
    .param110(param110),
    .param111(param111),
    .param112(param112),
    .param113(param113),
    .param114(param114),
    .param115(param115),
    .param116(param116),
    .param117(param117),
    .param118(param118),
    .param119(param119),
    .param120(param120),
    .param121(param121),
    .param122(param122),
    .param123(param123),
    .param124(param124),
    .param125(param125),
    .param126(param126),
    .param127(param127),
	.value(bbx_val[1])
);

BBX_MPX BBX_MPX_Ch2(
	.Clk(clk),
	.address(bbx_val_addr[2]),
	.data0(data0_reg),
	.data1(data1_reg),
	.data2(data2_reg),
	.data3(data3_reg),
	.data4(data4_reg),
	.data5(data5_reg),
	.data6(data6_reg),
	.data7(data7_reg),
	.data8(data8_reg),
	.data9(data9_reg),
	.data10(data10_reg),
	.data11(data11_reg),
	.data12(data12_reg),
	.data13(data13_reg),
	.data14(data14_reg),
	.data15(data15_reg),
	.data16(data16_reg),
	.data17(data17_reg),
	.data18(data18_reg),
	.data19(data19_reg),
	.data20(data20_reg),
	.data21(data21_reg),
	.data22(data22_reg),
	.data23(data23_reg),
	.data24(data24_reg),
	.data25(data25_reg),
	.data26(data26_reg),
	.data27(data27_reg),
	.data28(data28_reg),
	.data29(data29_reg),
	.data30(data30_reg),
	.data31(data31_reg),
	.data32(data32_reg),
	.data33(data33_reg),
	.data34(data34_reg),
	.data35(data35_reg),
	.data36(data36_reg),
	.data37(data37_reg),
	.data38(data38_reg),
	.data39(data39_reg),
	.data40(data40_reg),
	.data41(data41_reg),
	.data42(data42_reg),
	.data43(data43_reg),
	.data44(data44_reg),
	.data45(data45_reg),
	.data46(data46_reg),
	.data47(data47_reg),
	.data48(data48_reg),
	.data49(data49_reg),
	.data50(data50_reg),
	.data51(data51_reg),
	.data52(data52_reg),
	.data53(data53_reg),
	.data54(data54_reg),
	.data55(data55_reg),
	.data56(data56_reg),
	.data57(data57_reg),
	.data58(data58_reg),
	.data59(data59_reg),
	.data60(data60_reg),
	.data61(data61_reg),
	.data62(data62_reg),
	.data63(data63_reg),
	.data64(data64_reg),
    .data65(data65_reg),
    .data66(data66_reg),
    .data67(data67_reg),
    .data68(data68_reg),
    .data69(data69_reg),
    .data70(data70_reg),
    .data71(data71_reg),
    .data72(data72_reg),
    .data73(data73_reg),
    .data74(data74_reg),
    .data75(data75_reg),
    .data76(data76_reg),
    .data77(data77_reg),
    .data78(data78_reg),
    .data79(data79_reg),
    .data80(data80_reg),
    .data81(data81_reg),
    .data82(data82_reg),
    .data83(data83_reg),
    .data84(data84_reg),
    .data85(data85_reg),
    .data86(data86_reg),
    .data87(data87_reg),
    .data88(data88_reg),
    .data89(data89_reg),
    .data90(data90_reg),
    .data91(data91_reg),
    .data92(data92_reg),
    .data93(data93_reg),
    .data94(data94_reg),
    .data95(data95_reg),
    .data96(data96_reg),
    .data97(data97_reg),
    .data98(data98_reg),
    .data99(data99_reg),
    .data100(data100_reg),
    .data101(data101_reg),
    .data102(data102_reg),
    .data103(data103_reg),
    .data104(data104_reg),
    .data105(data105_reg),
    .data106(data106_reg),
    .data107(data107_reg),
    .data108(data108_reg),
    .data109(data109_reg),
    .data110(data110_reg),
    .data111(data111_reg),
    .data112(data112_reg),
    .data113(data113_reg),
    .data114(data114_reg),
    .data115(data115_reg),
    .data116(data116_reg),
    .data117(data117_reg),
    .data118(data118_reg),
    .data119(data119_reg),
    .data120(data120_reg),
    .data121(data121_reg),
    .data122(data122_reg),
    .data123(data123_reg),
    .data124(data124_reg),
    .data125(data125_reg),
    .data126(data126_reg),
    .data127(data127_reg),
    .param0(param0),
    .param1(param1),
    .param2(param2),
    .param3(param3),
    .param4(param4),
    .param5(param5),
    .param6(param6),
    .param7(param7),
    .param8(param8),
    .param9(param9),
    .param10(param10),
    .param11(param11),
    .param12(param12),
    .param13(param13),
    .param14(param14),
    .param15(param15),
    .param16(param16),
    .param17(param17),
    .param18(param18),
    .param19(param19),
    .param20(param20),
    .param21(param21),
    .param22(param22),
    .param23(param23),
    .param24(param24),
    .param25(param25),
    .param26(param26),
    .param27(param27),
    .param28(param28),
    .param29(param29),
    .param30(param30),
    .param31(param31),
    .param32(param32),
    .param33(param33),
    .param34(param34),
    .param35(param35),
    .param36(param36),
    .param37(param37),
    .param38(param38),
    .param39(param39),
    .param40(param40),
    .param41(param41),
    .param42(param42),
    .param43(param43),
    .param44(param44),
    .param45(param45),
    .param46(param46),
    .param47(param47),
    .param48(param48),
    .param49(param49),
    .param50(param50),
    .param51(param51),
    .param52(param52),
    .param53(param53),
    .param54(param54),
    .param55(param55),
    .param56(param56),
    .param57(param57),
    .param58(param58),
    .param59(param59),
    .param60(param60),
    .param61(param61),
    .param62(param62),
    .param63(param63),
    .param64(param64),
    .param65(param65),
    .param66(param66),
    .param67(param67),
    .param68(param68),
    .param69(param69),
    .param70(param70),
    .param71(param71),
    .param72(param72),
    .param73(param73),
    .param74(param74),
    .param75(param75),
    .param76(param76),
    .param77(param77),
    .param78(param78),
    .param79(param79),
    .param80(param80),
    .param81(param81),
    .param82(param82),
    .param83(param83),
    .param84(param84),
    .param85(param85),
    .param86(param86),
    .param87(param87),
    .param88(param88),
    .param89(param89),
    .param90(param90),
    .param91(param91),
    .param92(param92),
    .param93(param93),
    .param94(param94),
    .param95(param95),
    .param96(param96),
    .param97(param97),
    .param98(param98),
    .param99(param99),
    .param100(param100),
    .param101(param101),
    .param102(param102),
    .param103(param103),
    .param104(param104),
    .param105(param105),
    .param106(param106),
    .param107(param107),
    .param108(param108),
    .param109(param109),
    .param110(param110),
    .param111(param111),
    .param112(param112),
    .param113(param113),
    .param114(param114),
    .param115(param115),
    .param116(param116),
    .param117(param117),
    .param118(param118),
    .param119(param119),
    .param120(param120),
    .param121(param121),
    .param122(param122),
    .param123(param123),
    .param124(param124),
    .param125(param125),
    .param126(param126),
    .param127(param127),
	.value(bbx_val[2])
);

BBX_MPX BBX_MPX_Ch3(
	.Clk(clk),
	.address(bbx_val_addr[3]),
	.data0(data0_reg),
	.data1(data1_reg),
	.data2(data2_reg),
	.data3(data3_reg),
	.data4(data4_reg),
	.data5(data5_reg),
	.data6(data6_reg),
	.data7(data7_reg),
	.data8(data8_reg),
	.data9(data9_reg),
	.data10(data10_reg),
	.data11(data11_reg),
	.data12(data12_reg),
	.data13(data13_reg),
	.data14(data14_reg),
	.data15(data15_reg),
	.data16(data16_reg),
	.data17(data17_reg),
	.data18(data18_reg),
	.data19(data19_reg),
	.data20(data20_reg),
	.data21(data21_reg),
	.data22(data22_reg),
	.data23(data23_reg),
	.data24(data24_reg),
	.data25(data25_reg),
	.data26(data26_reg),
	.data27(data27_reg),
	.data28(data28_reg),
	.data29(data29_reg),
	.data30(data30_reg),
	.data31(data31_reg),
	.data32(data32_reg),
	.data33(data33_reg),
	.data34(data34_reg),
	.data35(data35_reg),
	.data36(data36_reg),
	.data37(data37_reg),
	.data38(data38_reg),
	.data39(data39_reg),
	.data40(data40_reg),
	.data41(data41_reg),
	.data42(data42_reg),
	.data43(data43_reg),
	.data44(data44_reg),
	.data45(data45_reg),
	.data46(data46_reg),
	.data47(data47_reg),
	.data48(data48_reg),
	.data49(data49_reg),
	.data50(data50_reg),
	.data51(data51_reg),
	.data52(data52_reg),
	.data53(data53_reg),
	.data54(data54_reg),
	.data55(data55_reg),
	.data56(data56_reg),
	.data57(data57_reg),
	.data58(data58_reg),
	.data59(data59_reg),
	.data60(data60_reg),
	.data61(data61_reg),
	.data62(data62_reg),
	.data63(data63_reg),
	.data64(data64_reg),
    .data65(data65_reg),
    .data66(data66_reg),
    .data67(data67_reg),
    .data68(data68_reg),
    .data69(data69_reg),
    .data70(data70_reg),
    .data71(data71_reg),
    .data72(data72_reg),
    .data73(data73_reg),
    .data74(data74_reg),
    .data75(data75_reg),
    .data76(data76_reg),
    .data77(data77_reg),
    .data78(data78_reg),
    .data79(data79_reg),
    .data80(data80_reg),
    .data81(data81_reg),
    .data82(data82_reg),
    .data83(data83_reg),
    .data84(data84_reg),
    .data85(data85_reg),
    .data86(data86_reg),
    .data87(data87_reg),
    .data88(data88_reg),
    .data89(data89_reg),
    .data90(data90_reg),
    .data91(data91_reg),
    .data92(data92_reg),
    .data93(data93_reg),
    .data94(data94_reg),
    .data95(data95_reg),
    .data96(data96_reg),
    .data97(data97_reg),
    .data98(data98_reg),
    .data99(data99_reg),
    .data100(data100_reg),
    .data101(data101_reg),
    .data102(data102_reg),
    .data103(data103_reg),
    .data104(data104_reg),
    .data105(data105_reg),
    .data106(data106_reg),
    .data107(data107_reg),
    .data108(data108_reg),
    .data109(data109_reg),
    .data110(data110_reg),
    .data111(data111_reg),
    .data112(data112_reg),
    .data113(data113_reg),
    .data114(data114_reg),
    .data115(data115_reg),
    .data116(data116_reg),
    .data117(data117_reg),
    .data118(data118_reg),
    .data119(data119_reg),
    .data120(data120_reg),
    .data121(data121_reg),
    .data122(data122_reg),
    .data123(data123_reg),
    .data124(data124_reg),
    .data125(data125_reg),
    .data126(data126_reg),
    .data127(data127_reg),
    .param0(param0),
    .param1(param1),
    .param2(param2),
    .param3(param3),
    .param4(param4),
    .param5(param5),
    .param6(param6),
    .param7(param7),
    .param8(param8),
    .param9(param9),
    .param10(param10),
    .param11(param11),
    .param12(param12),
    .param13(param13),
    .param14(param14),
    .param15(param15),
    .param16(param16),
    .param17(param17),
    .param18(param18),
    .param19(param19),
    .param20(param20),
    .param21(param21),
    .param22(param22),
    .param23(param23),
    .param24(param24),
    .param25(param25),
    .param26(param26),
    .param27(param27),
    .param28(param28),
    .param29(param29),
    .param30(param30),
    .param31(param31),
    .param32(param32),
    .param33(param33),
    .param34(param34),
    .param35(param35),
    .param36(param36),
    .param37(param37),
    .param38(param38),
    .param39(param39),
    .param40(param40),
    .param41(param41),
    .param42(param42),
    .param43(param43),
    .param44(param44),
    .param45(param45),
    .param46(param46),
    .param47(param47),
    .param48(param48),
    .param49(param49),
    .param50(param50),
    .param51(param51),
    .param52(param52),
    .param53(param53),
    .param54(param54),
    .param55(param55),
    .param56(param56),
    .param57(param57),
    .param58(param58),
    .param59(param59),
    .param60(param60),
    .param61(param61),
    .param62(param62),
    .param63(param63),
    .param64(param64),
    .param65(param65),
    .param66(param66),
    .param67(param67),
    .param68(param68),
    .param69(param69),
    .param70(param70),
    .param71(param71),
    .param72(param72),
    .param73(param73),
    .param74(param74),
    .param75(param75),
    .param76(param76),
    .param77(param77),
    .param78(param78),
    .param79(param79),
    .param80(param80),
    .param81(param81),
    .param82(param82),
    .param83(param83),
    .param84(param84),
    .param85(param85),
    .param86(param86),
    .param87(param87),
    .param88(param88),
    .param89(param89),
    .param90(param90),
    .param91(param91),
    .param92(param92),
    .param93(param93),
    .param94(param94),
    .param95(param95),
    .param96(param96),
    .param97(param97),
    .param98(param98),
    .param99(param99),
    .param100(param100),
    .param101(param101),
    .param102(param102),
    .param103(param103),
    .param104(param104),
    .param105(param105),
    .param106(param106),
    .param107(param107),
    .param108(param108),
    .param109(param109),
    .param110(param110),
    .param111(param111),
    .param112(param112),
    .param113(param113),
    .param114(param114),
    .param115(param115),
    .param116(param116),
    .param117(param117),
    .param118(param118),
    .param119(param119),
    .param120(param120),
    .param121(param121),
    .param122(param122),
    .param123(param123),
    .param124(param124),
    .param125(param125),
    .param126(param126),
    .param127(param127),
	.value(bbx_val[3])
);

assign BBX_Addr = bbx_idx;
assign BBX_Data_in = {bbx_val[3], bbx_val[2], bbx_val[1], bbx_val[0]};

always @ (posedge clk) 
begin //BlackBox kezelés
	if (bbx_div < bbx_sample_time)	begin				//a mintavételi frekvencia osztása
		bbx_div <= (bbx_div + 1);
	end
	else begin	
		bbx_div <= 0;										//..ha már kellõen leosztódott, vizsgálódunk
		case (bbx_state)	
		1:	begin 											//várakozás a triggerfeltételre
				bbx_trig_ch_val_old <= bbx_trig_ch_val;
				bbx_idx  <= bbx_idx+1;
				if (bbx_trig_delay != 0)
					bbx_trig_delay <= bbx_trig_delay - 1;
				else begin
					if ((bbx_tlevel_type == (BBX_TV_16BIT | BBX_TV_UNSIGNED)) || (bbx_tlevel_type == (BBX_TV_32BIT | BBX_TV_UNSIGNED))) begin
						if ((bbx_trig_slope == 0) && ((bbx_trig_ch_val_old < bbx_trig_level && bbx_trig_level <= bbx_trig_ch_val) || (bbx_tnow))) begin
							bbx_start_idx <= bbx_idx;								//bbx_start_idx
							bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);		//bbx_end_idx
							bbx_state <= 2;			//bbx_state
						end
						else if ((bbx_trig_slope == 1) && ((bbx_trig_ch_val_old > bbx_trig_level && bbx_trig_level >= bbx_trig_ch_val) || (bbx_tnow))) begin
							bbx_start_idx <= bbx_idx;								//bbx_start_idx
							bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);		//bbx_end_idx
							bbx_state <= 2;			//bbx_state				
						end
					end
					else if (bbx_tlevel_type == (BBX_TV_16BIT | BBX_TV_SIGNED)) begin
						if ((bbx_trig_slope == 0) && ((bbx_trig_ch_val_old_signed_16 < bbx_trig_level_signed_16 && bbx_trig_level_signed_16 <= bbx_trig_ch_val_signed_16) || (bbx_tnow))) begin
							bbx_start_idx <= bbx_idx;								//bbx_start_idx
							bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);		//bbx_end_idx
							bbx_state <= 2;			//bbx_state
						end
						else if ((bbx_trig_slope == 1) && ((bbx_trig_ch_val_old_signed_16 > bbx_trig_level_signed_16 && bbx_trig_level_signed_16 >= bbx_trig_ch_val_signed_16) || (bbx_tnow))) begin
							bbx_start_idx <= bbx_idx;								//bbx_start_idx
							bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);		//bbx_end_idx
							bbx_state <= 2;			//bbx_state				
						end					
					end
					else if (bbx_tlevel_type == (BBX_TV_32BIT | BBX_TV_SIGNED)) begin
						if ((bbx_trig_slope == 0) && ((bbx_trig_ch_val_old_signed_32 < bbx_trig_level_signed_32 && bbx_trig_level_signed_32 <= bbx_trig_ch_val_signed_32) || (bbx_tnow))) begin
							bbx_start_idx <= bbx_idx;								//bbx_start_idx
							bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);		//bbx_end_idx
							bbx_state <= 2;			//bbx_state
						end
						else if ((bbx_trig_slope == 1) && ((bbx_trig_ch_val_old_signed_32 > bbx_trig_level_signed_32 && bbx_trig_level_signed_32 >= bbx_trig_ch_val_signed_32) || (bbx_tnow))) begin
							bbx_start_idx <= bbx_idx;								//bbx_start_idx
							bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);		//bbx_end_idx
							bbx_state <= 2;			//bbx_state				
						end
				    end					
					else if (bbx_tlevel_type == (BBX_TV_FLOAT)) begin 
                        if ((bbx_trig_slope == 0) && ((bbx_trig_level[31]== 0) ? ((bbx_trig_ch_val_old[31]==1) || (bbx_trig_ch_val_old < bbx_trig_level)) : ((bbx_trig_ch_val_old[31]==1) && (bbx_trig_ch_val_old[30:0] > bbx_trig_level[30:0])))
                                                  && ((bbx_trig_level[31]== 0) ? ((bbx_trig_ch_val[31]==0) && (bbx_trig_ch_val >= bbx_trig_level)) : ((bbx_trig_ch_val[31]==0) || (bbx_trig_ch_val[30:0] <= bbx_trig_level[30:0])))) begin
                            bbx_start_idx <= bbx_idx;                                //bbx_start_idx
                            bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);        //bbx_end_idx
                            bbx_state <= 2;            //bbx_state
                        end                   
                        else if ((bbx_trig_slope == 1) && ((bbx_trig_level[31]== 0) ? ((bbx_trig_ch_val_old[31]==0) && (bbx_trig_ch_val_old > bbx_trig_level)) : ((bbx_trig_ch_val_old[31]==0) || (bbx_trig_ch_val_old[30:0] < bbx_trig_level[30:0])))
                                                       && ((bbx_trig_level[31]== 0) ? ((bbx_trig_ch_val[31]==1) || (bbx_trig_ch_val <= bbx_trig_level)) : ((bbx_trig_ch_val[31]==1) && (bbx_trig_ch_val[30:0] >= bbx_trig_level[30:0])))) begin    
                            bbx_start_idx <= bbx_idx;                                //bbx_start_idx
                            bbx_end_idx <= (bbx_idx-bbx_pretrigger-2);        //bbx_end_idx
                            bbx_state <= 2;            //bbx_state
                        end
                    end  					
				end
			end
		2: begin
				if (bbx_idx == bbx_end_idx) begin
					bbx_state <= 3;				//bbx_state			//várakozás a triggerfeltételre
					BBX_Data_Write <= 0;
				end
				bbx_trig_ch_val_old <= bbx_trig_ch_val;
				bbx_idx  <= bbx_idx+1;
			end
		default: begin
			if ((bbx_state_tmp == 0) || (bbx_state_tmp == 1)) begin
				bbx_state <= bbx_state_tmp;				//bbx_state	
				if (bbx_state_tmp == 1)
				begin
					BBX_Data_Write <= 1;
				end
			end
			bbx_trig_delay <= (bbx_pretrigger+1);		
		end
		endcase
	end
end 

endmodule
