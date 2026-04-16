`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:00:42 01/04/2016 
// Design Name: 
// Module Name:    ioexp
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


module ioexp(
	input clk,
    input reset,
	input en,
    
	input [7:0] outdata,
	output reg [7:0] indata,
	
    output reg sck=1'b0,
    output reg cs=1'b1,
    output mosi,
	input miso
    );

reg [7:0] shift_out, shift_in;
reg [2:0] cnt=7;
reg [1:0] state=0;

assign mosi=shift_out[7];

always @(posedge clk)
begin
	if (reset == 1'b1)
	begin
		shift_out<=0;
		shift_in<=0;
		indata<=0;
		cnt<=7;
		state<=0;
		sck<=1'b0;
		cs<=1'b1;
	end
	else if (en == 1'b1)
	begin
		if (state == 0)
		begin
			cs<=1'b0;
			shift_out<=outdata;
			state<=1;
		end
		else if (state == 1)
		begin
			cs<=1'b1;
			state<=2;
			shift_in<={shift_in[6:0], miso};
		end
		else if (state == 2)
		begin
			sck<=1'b1;
			state<=3;
		end
		else if (state == 3)
		begin
			sck<=1'b0;
			if (cnt == 7)
			begin
				cnt<=0;
				state<=0;
				indata<=shift_in;
			end
			else
			begin
				shift_out<={shift_out[6:0], 1'bx};
				shift_in<={shift_in[6:0], miso};
				cnt<=cnt+1;
				state<=2;
			end
		end
	end
end


endmodule
