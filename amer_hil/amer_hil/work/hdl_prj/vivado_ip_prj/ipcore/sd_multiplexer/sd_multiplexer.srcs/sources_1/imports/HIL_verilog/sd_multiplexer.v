`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:51 01/04/2016 
// Design Name: 
// Module Name:    sd_multiplexer 
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


module sd_multiplexer(
	input clk,
	input clkx4,
	
	input [7:0] sdac_a,
	input [7:0] sdac_b,
	
	output reg [3:0] sd,
	output sd_clk_0,
	output sd_clk_90
    );

reg [1:0] clkphase, clkout;
wire [1:0] nextphase;

assign nextphase = clkphase + 1;

always @(negedge clkx4)
begin	
	case (clkphase)
		2'b00 : clkout <= 2'b01;
		2'b01 : clkout <= 2'b11;
		2'b10 : clkout <= 2'b10;
		2'b11 : clkout <= 2'b00;
	endcase
end

assign  sd_clk_0 = clkout[0];
assign sd_clk_90 = clkout[1];

reg [15:0] sd_tmp;
always @(posedge clk)
begin
	sd_tmp[0]  <= sdac_b[4];	//AN11
	sd_tmp[1]  <= sdac_b[0];	//AN12
	sd_tmp[2]  <= sdac_a[3];	//AN13
	sd_tmp[3]  <= sdac_a[7];	//AN14
	sd_tmp[4]  <= sdac_b[6];	//AN21
	sd_tmp[5]  <= sdac_b[3];	//AN22
	sd_tmp[6]  <= sdac_a[0];	//AN23
	sd_tmp[7]  <= sdac_a[4];	//AN24
	sd_tmp[8]  <= sdac_b[7];	//AN31
	sd_tmp[9]  <= sdac_b[2];	//AN32
	sd_tmp[10] <= sdac_a[1];	//AN33
	sd_tmp[11] <= sdac_a[5];	//AN34
	sd_tmp[12] <= sdac_b[5];	//AN41
	sd_tmp[13] <= sdac_b[1];	//AN42
	sd_tmp[14] <= sdac_a[2];	//AN43
	sd_tmp[15] <= sdac_a[6];	//AN44

	//sd_tmp<={sdac_b, sdac_a};
end

integer i;
always @(posedge clkx4)
begin
	clkphase <= nextphase;
	
	for (i=0;i<4;i=i+1)
	begin
		sd[i]<=sd_tmp[4*nextphase+i];
	end
end

endmodule
