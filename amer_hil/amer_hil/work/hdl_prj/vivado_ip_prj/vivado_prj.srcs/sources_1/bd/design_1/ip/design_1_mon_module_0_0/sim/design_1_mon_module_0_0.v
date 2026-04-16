// (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: aut.bme.hu:user:mon_module:1.0
// IP Revision: 3

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_mon_module_0_0 (
  clk,
  reset,
  RxD,
  TxD,
  data0,
  data1,
  data2,
  data3,
  data4,
  data5,
  data6,
  data7,
  data8,
  data9,
  data10,
  data11,
  data12,
  data13,
  data14,
  data15,
  data16,
  data17,
  data18,
  data19,
  data20,
  data21,
  data22,
  data23,
  data24,
  data25,
  data26,
  data27,
  data28,
  data29,
  data30,
  data31,
  data32,
  data33,
  data34,
  data35,
  data36,
  data37,
  data38,
  data39,
  data40,
  data41,
  data42,
  data43,
  data44,
  data45,
  data46,
  data47,
  data48,
  data49,
  data50,
  data51,
  data52,
  data53,
  data54,
  data55,
  data56,
  data57,
  data58,
  data59,
  data60,
  data61,
  data62,
  data63,
  data64,
  data65,
  data66,
  data67,
  data68,
  data69,
  data70,
  data71,
  data72,
  data73,
  data74,
  data75,
  data76,
  data77,
  data78,
  data79,
  data80,
  data81,
  data82,
  data83,
  data84,
  data85,
  data86,
  data87,
  data88,
  data89,
  data90,
  data91,
  data92,
  data93,
  data94,
  data95,
  data96,
  data97,
  data98,
  data99,
  data100,
  data101,
  data102,
  data103,
  data104,
  data105,
  data106,
  data107,
  data108,
  data109,
  data110,
  data111,
  data112,
  data113,
  data114,
  data115,
  data116,
  data117,
  data118,
  data119,
  data120,
  data121,
  data122,
  data123,
  data124,
  data125,
  data126,
  data127,
  param0,
  param1,
  param2,
  param3,
  param4,
  param5,
  param6,
  param7,
  param8,
  param9,
  param10,
  param11,
  param12,
  param13,
  param14,
  param15,
  param16,
  param17,
  param18,
  param19,
  param20,
  param21,
  param22,
  param23,
  param24,
  param25,
  param26,
  param27,
  param28,
  param29,
  param30,
  param31,
  param32,
  param33,
  param34,
  param35,
  param36,
  param37,
  param38,
  param39,
  param40,
  param41,
  param42,
  param43,
  param44,
  param45,
  param46,
  param47,
  param48,
  param49,
  param50,
  param51,
  param52,
  param53,
  param54,
  param55,
  param56,
  param57,
  param58,
  param59,
  param60,
  param61,
  param62,
  param63,
  param64,
  param65,
  param66,
  param67,
  param68,
  param69,
  param70,
  param71,
  param72,
  param73,
  param74,
  param75,
  param76,
  param77,
  param78,
  param79,
  param80,
  param81,
  param82,
  param83,
  param84,
  param85,
  param86,
  param87,
  param88,
  param89,
  param90,
  param91,
  param92,
  param93,
  param94,
  param95,
  param96,
  param97,
  param98,
  param99,
  param100,
  param101,
  param102,
  param103,
  param104,
  param105,
  param106,
  param107,
  param108,
  param109,
  param110,
  param111,
  param112,
  param113,
  param114,
  param115,
  param116,
  param117,
  param118,
  param119,
  param120,
  param121,
  param122,
  param123,
  param124,
  param125,
  param126,
  param127
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET reset, FREQ_HZ 20000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME reset, POLARITY ACTIVE_HIGH" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset RST" *)
input wire reset;
input wire RxD;
output wire TxD;
input wire [31 : 0] data0;
input wire [31 : 0] data1;
input wire [31 : 0] data2;
input wire [31 : 0] data3;
input wire [31 : 0] data4;
input wire [31 : 0] data5;
input wire [31 : 0] data6;
input wire [31 : 0] data7;
input wire [31 : 0] data8;
input wire [31 : 0] data9;
input wire [31 : 0] data10;
input wire [31 : 0] data11;
input wire [31 : 0] data12;
input wire [31 : 0] data13;
input wire [31 : 0] data14;
input wire [31 : 0] data15;
input wire [31 : 0] data16;
input wire [31 : 0] data17;
input wire [31 : 0] data18;
input wire [31 : 0] data19;
input wire [31 : 0] data20;
input wire [31 : 0] data21;
input wire [31 : 0] data22;
input wire [31 : 0] data23;
input wire [31 : 0] data24;
input wire [31 : 0] data25;
input wire [31 : 0] data26;
input wire [31 : 0] data27;
input wire [31 : 0] data28;
input wire [31 : 0] data29;
input wire [31 : 0] data30;
input wire [31 : 0] data31;
input wire [31 : 0] data32;
input wire [31 : 0] data33;
input wire [31 : 0] data34;
input wire [31 : 0] data35;
input wire [31 : 0] data36;
input wire [31 : 0] data37;
input wire [31 : 0] data38;
input wire [31 : 0] data39;
input wire [31 : 0] data40;
input wire [31 : 0] data41;
input wire [31 : 0] data42;
input wire [31 : 0] data43;
input wire [31 : 0] data44;
input wire [31 : 0] data45;
input wire [31 : 0] data46;
input wire [31 : 0] data47;
input wire [31 : 0] data48;
input wire [31 : 0] data49;
input wire [31 : 0] data50;
input wire [31 : 0] data51;
input wire [31 : 0] data52;
input wire [31 : 0] data53;
input wire [31 : 0] data54;
input wire [31 : 0] data55;
input wire [31 : 0] data56;
input wire [31 : 0] data57;
input wire [31 : 0] data58;
input wire [31 : 0] data59;
input wire [31 : 0] data60;
input wire [31 : 0] data61;
input wire [31 : 0] data62;
input wire [31 : 0] data63;
input wire [31 : 0] data64;
input wire [31 : 0] data65;
input wire [31 : 0] data66;
input wire [31 : 0] data67;
input wire [31 : 0] data68;
input wire [31 : 0] data69;
input wire [31 : 0] data70;
input wire [31 : 0] data71;
input wire [31 : 0] data72;
input wire [31 : 0] data73;
input wire [31 : 0] data74;
input wire [31 : 0] data75;
input wire [31 : 0] data76;
input wire [31 : 0] data77;
input wire [31 : 0] data78;
input wire [31 : 0] data79;
input wire [31 : 0] data80;
input wire [31 : 0] data81;
input wire [31 : 0] data82;
input wire [31 : 0] data83;
input wire [31 : 0] data84;
input wire [31 : 0] data85;
input wire [31 : 0] data86;
input wire [31 : 0] data87;
input wire [31 : 0] data88;
input wire [31 : 0] data89;
input wire [31 : 0] data90;
input wire [31 : 0] data91;
input wire [31 : 0] data92;
input wire [31 : 0] data93;
input wire [31 : 0] data94;
input wire [31 : 0] data95;
input wire [31 : 0] data96;
input wire [31 : 0] data97;
input wire [31 : 0] data98;
input wire [31 : 0] data99;
input wire [31 : 0] data100;
input wire [31 : 0] data101;
input wire [31 : 0] data102;
input wire [31 : 0] data103;
input wire [31 : 0] data104;
input wire [31 : 0] data105;
input wire [31 : 0] data106;
input wire [31 : 0] data107;
input wire [31 : 0] data108;
input wire [31 : 0] data109;
input wire [31 : 0] data110;
input wire [31 : 0] data111;
input wire [31 : 0] data112;
input wire [31 : 0] data113;
input wire [31 : 0] data114;
input wire [31 : 0] data115;
input wire [31 : 0] data116;
input wire [31 : 0] data117;
input wire [31 : 0] data118;
input wire [31 : 0] data119;
input wire [31 : 0] data120;
input wire [31 : 0] data121;
input wire [31 : 0] data122;
input wire [31 : 0] data123;
input wire [31 : 0] data124;
input wire [31 : 0] data125;
input wire [31 : 0] data126;
input wire [31 : 0] data127;
output wire [31 : 0] param0;
output wire [31 : 0] param1;
output wire [31 : 0] param2;
output wire [31 : 0] param3;
output wire [31 : 0] param4;
output wire [31 : 0] param5;
output wire [31 : 0] param6;
output wire [31 : 0] param7;
output wire [31 : 0] param8;
output wire [31 : 0] param9;
output wire [31 : 0] param10;
output wire [31 : 0] param11;
output wire [31 : 0] param12;
output wire [31 : 0] param13;
output wire [31 : 0] param14;
output wire [31 : 0] param15;
output wire [31 : 0] param16;
output wire [31 : 0] param17;
output wire [31 : 0] param18;
output wire [31 : 0] param19;
output wire [31 : 0] param20;
output wire [31 : 0] param21;
output wire [31 : 0] param22;
output wire [31 : 0] param23;
output wire [31 : 0] param24;
output wire [31 : 0] param25;
output wire [31 : 0] param26;
output wire [31 : 0] param27;
output wire [31 : 0] param28;
output wire [31 : 0] param29;
output wire [31 : 0] param30;
output wire [31 : 0] param31;
output wire [31 : 0] param32;
output wire [31 : 0] param33;
output wire [31 : 0] param34;
output wire [31 : 0] param35;
output wire [31 : 0] param36;
output wire [31 : 0] param37;
output wire [31 : 0] param38;
output wire [31 : 0] param39;
output wire [31 : 0] param40;
output wire [31 : 0] param41;
output wire [31 : 0] param42;
output wire [31 : 0] param43;
output wire [31 : 0] param44;
output wire [31 : 0] param45;
output wire [31 : 0] param46;
output wire [31 : 0] param47;
output wire [31 : 0] param48;
output wire [31 : 0] param49;
output wire [31 : 0] param50;
output wire [31 : 0] param51;
output wire [31 : 0] param52;
output wire [31 : 0] param53;
output wire [31 : 0] param54;
output wire [31 : 0] param55;
output wire [31 : 0] param56;
output wire [31 : 0] param57;
output wire [31 : 0] param58;
output wire [31 : 0] param59;
output wire [31 : 0] param60;
output wire [31 : 0] param61;
output wire [31 : 0] param62;
output wire [31 : 0] param63;
output wire [31 : 0] param64;
output wire [31 : 0] param65;
output wire [31 : 0] param66;
output wire [31 : 0] param67;
output wire [31 : 0] param68;
output wire [31 : 0] param69;
output wire [31 : 0] param70;
output wire [31 : 0] param71;
output wire [31 : 0] param72;
output wire [31 : 0] param73;
output wire [31 : 0] param74;
output wire [31 : 0] param75;
output wire [31 : 0] param76;
output wire [31 : 0] param77;
output wire [31 : 0] param78;
output wire [31 : 0] param79;
output wire [31 : 0] param80;
output wire [31 : 0] param81;
output wire [31 : 0] param82;
output wire [31 : 0] param83;
output wire [31 : 0] param84;
output wire [31 : 0] param85;
output wire [31 : 0] param86;
output wire [31 : 0] param87;
output wire [31 : 0] param88;
output wire [31 : 0] param89;
output wire [31 : 0] param90;
output wire [31 : 0] param91;
output wire [31 : 0] param92;
output wire [31 : 0] param93;
output wire [31 : 0] param94;
output wire [31 : 0] param95;
output wire [31 : 0] param96;
output wire [31 : 0] param97;
output wire [31 : 0] param98;
output wire [31 : 0] param99;
output wire [31 : 0] param100;
output wire [31 : 0] param101;
output wire [31 : 0] param102;
output wire [31 : 0] param103;
output wire [31 : 0] param104;
output wire [31 : 0] param105;
output wire [31 : 0] param106;
output wire [31 : 0] param107;
output wire [31 : 0] param108;
output wire [31 : 0] param109;
output wire [31 : 0] param110;
output wire [31 : 0] param111;
output wire [31 : 0] param112;
output wire [31 : 0] param113;
output wire [31 : 0] param114;
output wire [31 : 0] param115;
output wire [31 : 0] param116;
output wire [31 : 0] param117;
output wire [31 : 0] param118;
output wire [31 : 0] param119;
output wire [31 : 0] param120;
output wire [31 : 0] param121;
output wire [31 : 0] param122;
output wire [31 : 0] param123;
output wire [31 : 0] param124;
output wire [31 : 0] param125;
output wire [31 : 0] param126;
output wire [31 : 0] param127;

  mon_module #(
    .baud_rate_step(16'H1798),
    .FPGA_ADDRESS(0),
    .SER_BASE(0),
    .SER_RECING(1),
    .SER_WAIT_DATA_STORE_AND_CHKSUM(2),
    .ANS_INIC(0),
    .ANS_GET_MODE(1),
    .ANS_GET_KEY(2),
    .ANS_GET_LEN_HIGH(3),
    .ANS_GET_LEN_LOW(4),
    .ANS_GET_LEN_LOW_LOW(5),
    .ANS_ANSWER(6),
    .STX(8'B00111100),
    .DLE(8'B00111101),
    .ETX(8'B00111110),
    .XDT(8'B00110000),
    .MON_RD(8'B00010000),
    .MON_WR(8'B00100011),
    .MON_TABS(8'B01000000),
    .MON_TABNAMES(8'B01010101),
    .MON_TABVALUES(8'B10100000),
    .MON_RDUNITS(8'B01111001),
    .MON_RD_ERRH(8'B01010001),
    .MON_RD_BBX(8'B01110101),
    .MON_RD_SPI_RAM(8'B00100100),
    .MON_REBOOT(8'B10000000),
    .MON_PING(8'B10011001),
    .TYP_32BIT(16'H0000),
    .TYP_16BIT(16'H0001),
    .TYP_SIGNED(16'H0000),
    .TYP_UNSIGNED(16'H0002),
    .TYP_HEX(16'H0080),
    .TYP_FLOAT(16'H0100),
    .TYP_ENWR(16'H0200),
    .BBX_TV_SIGNED(16'H0001),
    .BBX_TV_UNSIGNED(16'H0000),
    .BBX_TV_16BIT(16'H0002),
    .BBX_TV_32BIT(16'H0000),
    .BBX_TV_16B_UPPER(16'H0004),
    .BBX_TV_FLOAT(16'H0008),
    .TABTITLE_START_ADDRESS(32'H00000800),
    .UNITS_START_ADDRESS(32'H00000A00),
    .VARS_START_ADDRESS(32'H00000C00)
  ) inst (
    .clk(clk),
    .reset(reset),
    .RxD(RxD),
    .TxD(TxD),
    .data0(data0),
    .data1(data1),
    .data2(data2),
    .data3(data3),
    .data4(data4),
    .data5(data5),
    .data6(data6),
    .data7(data7),
    .data8(data8),
    .data9(data9),
    .data10(data10),
    .data11(data11),
    .data12(data12),
    .data13(data13),
    .data14(data14),
    .data15(data15),
    .data16(data16),
    .data17(data17),
    .data18(data18),
    .data19(data19),
    .data20(data20),
    .data21(data21),
    .data22(data22),
    .data23(data23),
    .data24(data24),
    .data25(data25),
    .data26(data26),
    .data27(data27),
    .data28(data28),
    .data29(data29),
    .data30(data30),
    .data31(data31),
    .data32(data32),
    .data33(data33),
    .data34(data34),
    .data35(data35),
    .data36(data36),
    .data37(data37),
    .data38(data38),
    .data39(data39),
    .data40(data40),
    .data41(data41),
    .data42(data42),
    .data43(data43),
    .data44(data44),
    .data45(data45),
    .data46(data46),
    .data47(data47),
    .data48(data48),
    .data49(data49),
    .data50(data50),
    .data51(data51),
    .data52(data52),
    .data53(data53),
    .data54(data54),
    .data55(data55),
    .data56(data56),
    .data57(data57),
    .data58(data58),
    .data59(data59),
    .data60(data60),
    .data61(data61),
    .data62(data62),
    .data63(data63),
    .data64(data64),
    .data65(data65),
    .data66(data66),
    .data67(data67),
    .data68(data68),
    .data69(data69),
    .data70(data70),
    .data71(data71),
    .data72(data72),
    .data73(data73),
    .data74(data74),
    .data75(data75),
    .data76(data76),
    .data77(data77),
    .data78(data78),
    .data79(data79),
    .data80(data80),
    .data81(data81),
    .data82(data82),
    .data83(data83),
    .data84(data84),
    .data85(data85),
    .data86(data86),
    .data87(data87),
    .data88(data88),
    .data89(data89),
    .data90(data90),
    .data91(data91),
    .data92(data92),
    .data93(data93),
    .data94(data94),
    .data95(data95),
    .data96(data96),
    .data97(data97),
    .data98(data98),
    .data99(data99),
    .data100(data100),
    .data101(data101),
    .data102(data102),
    .data103(data103),
    .data104(data104),
    .data105(data105),
    .data106(data106),
    .data107(data107),
    .data108(data108),
    .data109(data109),
    .data110(data110),
    .data111(data111),
    .data112(data112),
    .data113(data113),
    .data114(data114),
    .data115(data115),
    .data116(data116),
    .data117(data117),
    .data118(data118),
    .data119(data119),
    .data120(data120),
    .data121(data121),
    .data122(data122),
    .data123(data123),
    .data124(data124),
    .data125(data125),
    .data126(data126),
    .data127(data127),
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
    .param127(param127)
  );
endmodule
