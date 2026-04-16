`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:48:32 01/15/2012 
// Design Name: 
// Module Name:    BBX_MPX 
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
module BBX_MPX(
	input Clk,
	input [31:0] address,
	input [31:0] data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13,data14,data15,
    input [31:0] data16,data17,data18,data19,data20,data21,data22,data23,data24,data25,data26,data27,data28,data29,data30,data31,
    input [31:0] data32,data33,data34,data35,data36,data37,data38,data39,data40,data41,data42,data43,data44,data45,data46,data47,
    input [31:0] data48,data49,data50,data51,data52,data53,data54,data55,data56,data57,data58,data59,data60,data61,data62,data63,
    input [31:0] data64,data65,data66,data67,data68,data69,data70,data71,data72,data73,data74,data75,data76,data77,data78,data79,
    input [31:0] data80,data81,data82,data83,data84,data85,data86,data87,data88,data89,data90,data91,data92,data93,data94,data95,
    input [31:0] data96,data97,data98,data99,data100,data101,data102,data103,data104,data105,data106,data107,data108,data109,data110,data111,
    input [31:0] data112,data113,data114,data115,data116,data117,data118,data119,data120,data121,data122,data123,data124,data125,data126,data127,
    input [31:0] param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,
    input [31:0] param16,param17,param18,param19,param20,param21,param22,param23,param24,param25,param26,param27,param28,param29,param30,param31,
    input [31:0] param32,param33,param34,param35,param36,param37,param38,param39,param40,param41,param42,param43,param44,param45,param46,param47,
    input [31:0] param48,param49,param50,param51,param52,param53,param54,param55,param56,param57,param58,param59,param60,param61,param62,param63,
    input [31:0] param64,param65,param66,param67,param68,param69,param70,param71,param72,param73,param74,param75,param76,param77,param78,param79,
    input [31:0] param80,param81,param82,param83,param84,param85,param86,param87,param88,param89,param90,param91,param92,param93,param94,param95,
    input [31:0] param96,param97,param98,param99,param100,param101,param102,param103,param104,param105,param106,param107,param108,param109,param110,param111,
    input [31:0] param112,param113,param114,param115,param116,param117,param118,param119,param120,param121,param122,param123,param124,param125,param126,param127,
	output reg[31:0] value
	);
	
always @ (posedge Clk) begin
	case (address)
		0: value <= data0;
		2: value <= data1;
		4: value <= data2;
		6: value <= data3;
		8: value <= data4;
		10: value <= data5;
		12: value <= data6;
		14: value <= data7;
		16: value <= data8;
		18: value <= data9;
		20: value <= data10;
		22: value <= data11;
		24: value <= data12;
		26: value <= data13;
		28: value <= data14;
		30: value <= data15;	
		32: value <= data16;	
		34: value <= data17;	
		36: value <= data18;	
		38: value <= data19;	
		40: value <= data20;	
		42: value <= data21;	
		44: value <= data22;	
		46: value <= data23;	
		48: value <= data24;	
		50: value <= data25;	
		52: value <= data26;	
		54: value <= data27;	
		56: value <= data28;	
		58: value <= data29;	
		60: value <= data30;	
		62: value <= data31;	
		64: value <= data32;	
		66: value <= data33;	
		68: value <= data34;	
		70: value <= data35;	
		72: value <= data36;	
		74: value <= data37;	
		76: value <= data38;	
		78: value <= data39;	
		80: value <= data40;	
		82: value <= data41;	
		84: value <= data42;	
		86: value <= data43;	
		88: value <= data44;	
		90: value <= data45;	
		92: value <= data46;	
		94: value <= data47;	
		96: value <= data48;	
		98: value <= data49;	
		100: value <= data50;	
		102: value <= data51;	
		104: value <= data52;	
		106: value <= data53;	
		108: value <= data54;	
		110: value <= data55;	
		112: value <= data56;	
		114: value <= data57;	
		116: value <= data58;	
		118: value <= data59;	
		120: value <= data60;	
		122: value <= data61;	
		124: value <= data62;	
		126: value <= data63;
		128: value <= data64;
        130: value <= data65;
        132: value <= data66;
        134: value <= data67;
        136: value <= data68;
        138: value <= data69;
        140: value <= data70;
        142: value <= data71;
        144: value <= data72;
        146: value <= data73;
        148: value <= data74;
        150: value <= data75;
        152: value <= data76;
        154: value <= data77;
        156: value <= data78;
        158: value <= data79;
        160: value <= data80;
        162: value <= data81;
        164: value <= data82;
        166: value <= data83;
        168: value <= data84;
        170: value <= data85;
        172: value <= data86;
        174: value <= data87;
        176: value <= data88;
        178: value <= data89;
        180: value <= data90;
        182: value <= data91;
        184: value <= data92;
        186: value <= data93;
        188: value <= data94;
        190: value <= data95;
        192: value <= data96;
        194: value <= data97;
        196: value <= data98;
        198: value <= data99;
        200: value <= data100;
        202: value <= data101;
        204: value <= data102;
        206: value <= data103;
        208: value <= data104;
        210: value <= data105;
        212: value <= data106;
        214: value <= data107;
        216: value <= data108;
        218: value <= data109;
        220: value <= data110;
        222: value <= data111;
        224: value <= data112;
        226: value <= data113;
        228: value <= data114;
        230: value <= data115;
        232: value <= data116;
        234: value <= data117;
        236: value <= data118;
        238: value <= data119;
        240: value <= data120;
        242: value <= data121;
        244: value <= data122;
        246: value <= data123;
        248: value <= data124;
        250: value <= data125;
        252: value <= data126;
        254: value <= data127;		
        256: value <= param0;
        258: value <= param1;
        260: value <= param2;
        262: value <= param3;
        264: value <= param4;
        266: value <= param5;
        268: value <= param6;
        270: value <= param7;
        272: value <= param8;
        274: value <= param9;
        276: value <= param10;
        278: value <= param11;
        280: value <= param12;
        282: value <= param13;
        284: value <= param14;
        286: value <= param15;    
        288: value <= param16;    
        290: value <= param17;    
        292: value <= param18;    
        294: value <= param19;    
        296: value <= param20;    
        298: value <= param21;    
        300: value <= param22;    
        302: value <= param23;    
        304: value <= param24;    
        306: value <= param25;    
        308: value <= param26;    
        310: value <= param27;    
        312: value <= param28;    
        314: value <= param29;    
        316: value <= param30;    
        318: value <= param31;    
        320: value <= param32;    
        322: value <= param33;    
        324: value <= param34;    
        326: value <= param35;    
        328: value <= param36;    
        330: value <= param37;    
        332: value <= param38;    
        334: value <= param39;    
        336: value <= param40;    
        338: value <= param41;    
        340: value <= param42;    
        342: value <= param43;    
        344: value <= param44;    
        346: value <= param45;    
        348: value <= param46;    
        350: value <= param47;    
        352: value <= param48;    
        354: value <= param49;    
        356: value <= param50;    
        358: value <= param51;    
        360: value <= param52;    
        362: value <= param53;    
        364: value <= param54;    
        366: value <= param55;    
        368: value <= param56;    
        370: value <= param57;    
        372: value <= param58;    
        374: value <= param59;    
        376: value <= param60;    
        378: value <= param61;    
        380: value <= param62;    
        382: value <= param63;
        384: value <= param64;
        386: value <= param65;
        388: value <= param66;
        390: value <= param67;
        392: value <= param68;
        394: value <= param69;
        396: value <= param70;
        398: value <= param71;
        400: value <= param72;
        402: value <= param73;
        404: value <= param74;
        406: value <= param75;
        408: value <= param76;
        410: value <= param77;
        412: value <= param78;
        414: value <= param79;
        416: value <= param80;
        418: value <= param81;
        420: value <= param82;
        422: value <= param83;
        424: value <= param84;
        426: value <= param85;
        428: value <= param86;
        430: value <= param87;
        432: value <= param88;
        434: value <= param89;
        436: value <= param90;
        438: value <= param91;
        440: value <= param92;
        442: value <= param93;
        444: value <= param94;
        446: value <= param95;
        448: value <= param96;
        450: value <= param97;
        452: value <= param98;
        454: value <= param99;
        456: value <= param100;
        458: value <= param101;
        460: value <= param102;
        462: value <= param103;
        464: value <= param104;
        466: value <= param105;
        468: value <= param106;
        470: value <= param107;
        472: value <= param108;
        474: value <= param109;
        476: value <= param110;
        478: value <= param111;
        480: value <= param112;
        482: value <= param113;
        484: value <= param114;
        486: value <= param115;
        488: value <= param116;
        490: value <= param117;
        492: value <= param118;
        494: value <= param119;
        496: value <= param120;
        498: value <= param121;
        500: value <= param122;
        502: value <= param123;
        504: value <= param124;
        506: value <= param125;
        508: value <= param126;
        510: value <= param127;
		
		default: value <= 32'hxxxxxxxx;
	endcase
end

endmodule
