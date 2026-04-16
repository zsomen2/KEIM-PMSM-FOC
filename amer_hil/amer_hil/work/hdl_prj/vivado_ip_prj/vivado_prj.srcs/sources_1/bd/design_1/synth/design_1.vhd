--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2.2 (win64) Build 2348494 Mon Oct  1 18:25:44 MDT 2018
--Date        : Fri Mar 27 14:59:58 2026
--Host        : LENI running 64-bit major release  (build 9200)
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    CtrlH : in STD_LOGIC_VECTOR ( 3 downto 0 );
    CtrlL : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Fail : out STD_LOGIC_VECTOR ( 3 downto 0 );
    QEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Status : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ZyboBTN : in STD_LOGIC_VECTOR ( 2 downto 0 );
    ZyboLED : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ZyboSW : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clk125 : in STD_LOGIC;
    ioext_spi_clk : out STD_LOGIC;
    ioext_spi_cs : out STD_LOGIC;
    ioext_spi_miso : in STD_LOGIC;
    ioext_spi_mosi : out STD_LOGIC;
    reset_btn : in STD_LOGIC;
    sd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sd_clk_0 : out STD_LOGIC;
    sd_clk_90 : out STD_LOGIC;
    uart_rx : in STD_LOGIC;
    uart_tx : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=7,numReposBlks=7,numNonXlnxBlks=3,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_clk_wiz_0_0 is
  port (
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC;
    clkx4 : out STD_LOGIC;
    clk : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component design_1_clk_wiz_0_0;
  component design_1_ioexp_0_0 is
  port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    en : in STD_LOGIC;
    outdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    indata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    sck : out STD_LOGIC;
    cs : out STD_LOGIC;
    mosi : out STD_LOGIC;
    miso : in STD_LOGIC
  );
  end component design_1_ioexp_0_0;
  component design_1_mon_module_0_0 is
  port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    RxD : in STD_LOGIC;
    TxD : out STD_LOGIC;
    data0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data4 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data5 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data6 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data7 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data8 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data9 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data10 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data11 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data12 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data13 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data14 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data15 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data16 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data17 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data18 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data19 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data20 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data21 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data22 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data23 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data24 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data25 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data26 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data27 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data28 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data29 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data30 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data31 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data32 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data33 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data34 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data35 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data36 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data37 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data38 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data39 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data40 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data41 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data42 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data43 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data44 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data45 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data46 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data47 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data48 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data49 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data50 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data51 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data52 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data53 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data54 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data55 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data56 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data57 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data58 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data59 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data60 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data61 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data62 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data63 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data64 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data65 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data66 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data67 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data68 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data69 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data70 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data71 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data72 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data73 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data74 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data75 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data76 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data77 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data78 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data79 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data80 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data81 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data82 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data83 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data84 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data85 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data86 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data87 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data88 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data89 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data90 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data91 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data92 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data93 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data94 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data95 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data96 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data97 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data98 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data99 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data100 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data101 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data102 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data103 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data104 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data105 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data106 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data107 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data108 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data109 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data110 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data111 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data112 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data113 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data114 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data115 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data116 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data117 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data118 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data119 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data120 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data121 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data122 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data123 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data124 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data125 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data126 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data127 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    param0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param4 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param5 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param6 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param7 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param8 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param9 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param10 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param11 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param12 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param13 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param14 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param15 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param16 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param17 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param18 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param19 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param20 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param21 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param22 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param23 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param24 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param25 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param26 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param27 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param28 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param29 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param30 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param31 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param32 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param33 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param34 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param35 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param36 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param37 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param38 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param39 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param40 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param41 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param42 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param43 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param44 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param45 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param46 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param47 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param48 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param49 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param50 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param51 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param52 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param53 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param54 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param55 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param56 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param57 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param58 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param59 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param60 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param61 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param62 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param63 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param64 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param65 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param66 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param67 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param68 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param69 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param70 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param71 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param72 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param73 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param74 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param75 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param76 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param77 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param78 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param79 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param80 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param81 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param82 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param83 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param84 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param85 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param86 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param87 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param88 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param89 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param90 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param91 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param92 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param93 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param94 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param95 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param96 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param97 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param98 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param99 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param100 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param101 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param102 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param103 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param104 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param105 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param106 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param107 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param108 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param109 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param110 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param111 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param112 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param113 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param114 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param115 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param116 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param117 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param118 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param119 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param120 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param121 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param122 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param123 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param124 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param125 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param126 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    param127 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component design_1_mon_module_0_0;
  component design_1_proc_sys_reset_0_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_proc_sys_reset_0_0;
  component design_1_sd_multiplexer_0_0 is
  port (
    clk : in STD_LOGIC;
    clkx4 : in STD_LOGIC;
    sdac_a : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sdac_b : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sd_clk_0 : out STD_LOGIC;
    sd_clk_90 : out STD_LOGIC
  );
  end component design_1_sd_multiplexer_0_0;
  component design_1_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_xlconstant_0_0;
  component design_1_RLUb_HIL_ip_0_0 is
  port (
    IPCORE_CLK : in STD_LOGIC;
    IPCORE_RESETN : in STD_LOGIC;
    IOextIn : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Param0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param4 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param5 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param6 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Param7 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ZyboBTN : in STD_LOGIC_VECTOR ( 2 downto 0 );
    ZyboSW : in STD_LOGIC_VECTOR ( 3 downto 0 );
    CtrlH : in STD_LOGIC_VECTOR ( 3 downto 0 );
    CtrlL : in STD_LOGIC_VECTOR ( 3 downto 0 );
    IOextOut : out STD_LOGIC_VECTOR ( 7 downto 0 );
    SDMuxA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    SDMuxB : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Data0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Data1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Data2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Data3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Data4 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ZyboLED : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Status : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Fail : out STD_LOGIC_VECTOR ( 3 downto 0 );
    QEP : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component design_1_RLUb_HIL_ip_0_0;
  signal CtrlH_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal CtrlL_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal RLUb_HIL_ip_0_Data0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal RLUb_HIL_ip_0_Data1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal RLUb_HIL_ip_0_Data2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal RLUb_HIL_ip_0_Data3 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal RLUb_HIL_ip_0_Data4 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal RLUb_HIL_ip_0_Fail : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal RLUb_HIL_ip_0_IOextOut : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal RLUb_HIL_ip_0_QEP : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal RLUb_HIL_ip_0_SDMuxA : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal RLUb_HIL_ip_0_SDMuxB : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal RLUb_HIL_ip_0_Status : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal RLUb_HIL_ip_0_ZyboLED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ZyboBTN_1 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ZyboSW_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal clk125_1 : STD_LOGIC;
  signal clk_wiz_0_clk10 : STD_LOGIC;
  signal clk_wiz_0_clkx4 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal ioexp_0_cs : STD_LOGIC;
  signal ioexp_0_indata : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal ioexp_0_mosi : STD_LOGIC;
  signal ioexp_0_sck : STD_LOGIC;
  signal ioext_spi_miso_1 : STD_LOGIC;
  signal mon_module_0_TxD : STD_LOGIC;
  signal mon_module_0_param0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param3 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param4 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param5 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param6 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mon_module_0_param7 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal proc_sys_reset_0_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal proc_sys_reset_0_peripheral_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal reset_btn_1 : STD_LOGIC;
  signal sd_multiplexer_0_sd : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal sd_multiplexer_0_sd_clk_0 : STD_LOGIC;
  signal sd_multiplexer_0_sd_clk_90 : STD_LOGIC;
  signal uart_rx_1 : STD_LOGIC;
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_mon_module_0_param10_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param100_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param101_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param102_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param103_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param104_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param105_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param106_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param107_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param108_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param109_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param11_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param110_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param111_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param112_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param113_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param114_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param115_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param116_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param117_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param118_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param119_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param12_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param120_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param121_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param122_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param123_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param124_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param125_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param126_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param127_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param13_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param14_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param15_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param16_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param17_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param18_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param19_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param20_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param21_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param22_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param23_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param24_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param25_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param26_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param27_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param28_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param29_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param30_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param31_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param32_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param33_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param34_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param35_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param36_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param37_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param38_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param39_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param40_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param41_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param42_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param43_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param44_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param45_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param46_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param47_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param48_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param49_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param50_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param51_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param52_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param53_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param54_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param55_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param56_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param57_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param58_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param59_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param60_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param61_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param62_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param63_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param64_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param65_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param66_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param67_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param68_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param69_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param70_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param71_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param72_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param73_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param74_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param75_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param76_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param77_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param78_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param79_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param8_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param80_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param81_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param82_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param83_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param84_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param85_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param86_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param87_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param88_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param89_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param9_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param90_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param91_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param92_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param93_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param94_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param95_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param96_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param97_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param98_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_mon_module_0_param99_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_proc_sys_reset_0_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_proc_sys_reset_0_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk125 : signal is "xilinx.com:signal:clock:1.0 CLK.CLK125 CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk125 : signal is "XIL_INTERFACENAME CLK.CLK125, CLK_DOMAIN design_1_clk125, FREQ_HZ 125000000, PHASE 0.000";
  attribute X_INTERFACE_INFO of reset_btn : signal is "xilinx.com:signal:reset:1.0 RST.RESET_BTN RST";
  attribute X_INTERFACE_PARAMETER of reset_btn : signal is "XIL_INTERFACENAME RST.RESET_BTN, POLARITY ACTIVE_HIGH";
begin
  CtrlH_1(3 downto 0) <= CtrlH(3 downto 0);
  CtrlL_1(3 downto 0) <= CtrlL(3 downto 0);
  Fail(3 downto 0) <= RLUb_HIL_ip_0_Fail(3 downto 0);
  QEP(3 downto 0) <= RLUb_HIL_ip_0_QEP(3 downto 0);
  Status(3 downto 0) <= RLUb_HIL_ip_0_Status(3 downto 0);
  ZyboBTN_1(2 downto 0) <= ZyboBTN(2 downto 0);
  ZyboLED(3 downto 0) <= RLUb_HIL_ip_0_ZyboLED(3 downto 0);
  ZyboSW_1(3 downto 0) <= ZyboSW(3 downto 0);
  clk125_1 <= clk125;
  ioext_spi_clk <= ioexp_0_sck;
  ioext_spi_cs <= ioexp_0_cs;
  ioext_spi_miso_1 <= ioext_spi_miso;
  ioext_spi_mosi <= ioexp_0_mosi;
  reset_btn_1 <= reset_btn;
  sd(3 downto 0) <= sd_multiplexer_0_sd(3 downto 0);
  sd_clk_0 <= sd_multiplexer_0_sd_clk_0;
  sd_clk_90 <= sd_multiplexer_0_sd_clk_90;
  uart_rx_1 <= uart_rx;
  uart_tx <= mon_module_0_TxD;
RLUb_HIL_ip_0: component design_1_RLUb_HIL_ip_0_0
     port map (
      CtrlH(3 downto 0) => CtrlH_1(3 downto 0),
      CtrlL(3 downto 0) => CtrlL_1(3 downto 0),
      Data0(31 downto 0) => RLUb_HIL_ip_0_Data0(31 downto 0),
      Data1(31 downto 0) => RLUb_HIL_ip_0_Data1(31 downto 0),
      Data2(31 downto 0) => RLUb_HIL_ip_0_Data2(31 downto 0),
      Data3(31 downto 0) => RLUb_HIL_ip_0_Data3(31 downto 0),
      Data4(31 downto 0) => RLUb_HIL_ip_0_Data4(31 downto 0),
      Fail(3 downto 0) => RLUb_HIL_ip_0_Fail(3 downto 0),
      IOextIn(7 downto 0) => ioexp_0_indata(7 downto 0),
      IOextOut(7 downto 0) => RLUb_HIL_ip_0_IOextOut(7 downto 0),
      IPCORE_CLK => clk_wiz_0_clk10,
      IPCORE_RESETN => proc_sys_reset_0_peripheral_aresetn(0),
      Param0(31 downto 0) => mon_module_0_param0(31 downto 0),
      Param1(31 downto 0) => mon_module_0_param1(31 downto 0),
      Param2(31 downto 0) => mon_module_0_param2(31 downto 0),
      Param3(31 downto 0) => mon_module_0_param3(31 downto 0),
      Param4(31 downto 0) => mon_module_0_param4(31 downto 0),
      Param5(31 downto 0) => mon_module_0_param5(31 downto 0),
      Param6(31 downto 0) => mon_module_0_param6(31 downto 0),
      Param7(31 downto 0) => mon_module_0_param7(31 downto 0),
      QEP(3 downto 0) => RLUb_HIL_ip_0_QEP(3 downto 0),
      SDMuxA(7 downto 0) => RLUb_HIL_ip_0_SDMuxA(7 downto 0),
      SDMuxB(7 downto 0) => RLUb_HIL_ip_0_SDMuxB(7 downto 0),
      Status(3 downto 0) => RLUb_HIL_ip_0_Status(3 downto 0),
      ZyboBTN(2 downto 0) => ZyboBTN_1(2 downto 0),
      ZyboLED(3 downto 0) => RLUb_HIL_ip_0_ZyboLED(3 downto 0),
      ZyboSW(3 downto 0) => ZyboSW_1(3 downto 0)
    );
clk_wiz_0: component design_1_clk_wiz_0_0
     port map (
      clk => clk_wiz_0_clk10,
      clk_in1 => clk125_1,
      clkx4 => clk_wiz_0_clkx4,
      locked => clk_wiz_0_locked,
      reset => xlconstant_0_dout(0)
    );
ioexp_0: component design_1_ioexp_0_0
     port map (
      clk => clk_wiz_0_clk10,
      cs => ioexp_0_cs,
      en => '1',
      indata(7 downto 0) => ioexp_0_indata(7 downto 0),
      miso => ioext_spi_miso_1,
      mosi => ioexp_0_mosi,
      outdata(7 downto 0) => RLUb_HIL_ip_0_IOextOut(7 downto 0),
      reset => proc_sys_reset_0_peripheral_reset(0),
      sck => ioexp_0_sck
    );
mon_module_0: component design_1_mon_module_0_0
     port map (
      RxD => uart_rx_1,
      TxD => mon_module_0_TxD,
      clk => clk_wiz_0_clk10,
      data0(31 downto 0) => RLUb_HIL_ip_0_Data0(31 downto 0),
      data1(31 downto 0) => RLUb_HIL_ip_0_Data1(31 downto 0),
      data10(31 downto 0) => B"00000000000000000000000000000000",
      data100(31 downto 0) => B"00000000000000000000000000000000",
      data101(31 downto 0) => B"00000000000000000000000000000000",
      data102(31 downto 0) => B"00000000000000000000000000000000",
      data103(31 downto 0) => B"00000000000000000000000000000000",
      data104(31 downto 0) => B"00000000000000000000000000000000",
      data105(31 downto 0) => B"00000000000000000000000000000000",
      data106(31 downto 0) => B"00000000000000000000000000000000",
      data107(31 downto 0) => B"00000000000000000000000000000000",
      data108(31 downto 0) => B"00000000000000000000000000000000",
      data109(31 downto 0) => B"00000000000000000000000000000000",
      data11(31 downto 0) => B"00000000000000000000000000000000",
      data110(31 downto 0) => B"00000000000000000000000000000000",
      data111(31 downto 0) => B"00000000000000000000000000000000",
      data112(31 downto 0) => B"00000000000000000000000000000000",
      data113(31 downto 0) => B"00000000000000000000000000000000",
      data114(31 downto 0) => B"00000000000000000000000000000000",
      data115(31 downto 0) => B"00000000000000000000000000000000",
      data116(31 downto 0) => B"00000000000000000000000000000000",
      data117(31 downto 0) => B"00000000000000000000000000000000",
      data118(31 downto 0) => B"00000000000000000000000000000000",
      data119(31 downto 0) => B"00000000000000000000000000000000",
      data12(31 downto 0) => B"00000000000000000000000000000000",
      data120(31 downto 0) => B"00000000000000000000000000000000",
      data121(31 downto 0) => B"00000000000000000000000000000000",
      data122(31 downto 0) => B"00000000000000000000000000000000",
      data123(31 downto 0) => B"00000000000000000000000000000000",
      data124(31 downto 0) => B"00000000000000000000000000000000",
      data125(31 downto 0) => B"00000000000000000000000000000000",
      data126(31 downto 0) => B"00000000000000000000000000000000",
      data127(31 downto 0) => B"00000000000000000000000000000000",
      data13(31 downto 0) => B"00000000000000000000000000000000",
      data14(31 downto 0) => B"00000000000000000000000000000000",
      data15(31 downto 0) => B"00000000000000000000000000000000",
      data16(31 downto 0) => B"00000000000000000000000000000000",
      data17(31 downto 0) => B"00000000000000000000000000000000",
      data18(31 downto 0) => B"00000000000000000000000000000000",
      data19(31 downto 0) => B"00000000000000000000000000000000",
      data2(31 downto 0) => RLUb_HIL_ip_0_Data2(31 downto 0),
      data20(31 downto 0) => B"00000000000000000000000000000000",
      data21(31 downto 0) => B"00000000000000000000000000000000",
      data22(31 downto 0) => B"00000000000000000000000000000000",
      data23(31 downto 0) => B"00000000000000000000000000000000",
      data24(31 downto 0) => B"00000000000000000000000000000000",
      data25(31 downto 0) => B"00000000000000000000000000000000",
      data26(31 downto 0) => B"00000000000000000000000000000000",
      data27(31 downto 0) => B"00000000000000000000000000000000",
      data28(31 downto 0) => B"00000000000000000000000000000000",
      data29(31 downto 0) => B"00000000000000000000000000000000",
      data3(31 downto 0) => RLUb_HIL_ip_0_Data3(31 downto 0),
      data30(31 downto 0) => B"00000000000000000000000000000000",
      data31(31 downto 0) => B"00000000000000000000000000000000",
      data32(31 downto 0) => B"00000000000000000000000000000000",
      data33(31 downto 0) => B"00000000000000000000000000000000",
      data34(31 downto 0) => B"00000000000000000000000000000000",
      data35(31 downto 0) => B"00000000000000000000000000000000",
      data36(31 downto 0) => B"00000000000000000000000000000000",
      data37(31 downto 0) => B"00000000000000000000000000000000",
      data38(31 downto 0) => B"00000000000000000000000000000000",
      data39(31 downto 0) => B"00000000000000000000000000000000",
      data4(31 downto 0) => RLUb_HIL_ip_0_Data4(31 downto 0),
      data40(31 downto 0) => B"00000000000000000000000000000000",
      data41(31 downto 0) => B"00000000000000000000000000000000",
      data42(31 downto 0) => B"00000000000000000000000000000000",
      data43(31 downto 0) => B"00000000000000000000000000000000",
      data44(31 downto 0) => B"00000000000000000000000000000000",
      data45(31 downto 0) => B"00000000000000000000000000000000",
      data46(31 downto 0) => B"00000000000000000000000000000000",
      data47(31 downto 0) => B"00000000000000000000000000000000",
      data48(31 downto 0) => B"00000000000000000000000000000000",
      data49(31 downto 0) => B"00000000000000000000000000000000",
      data5(31 downto 0) => B"00000000000000000000000000000000",
      data50(31 downto 0) => B"00000000000000000000000000000000",
      data51(31 downto 0) => B"00000000000000000000000000000000",
      data52(31 downto 0) => B"00000000000000000000000000000000",
      data53(31 downto 0) => B"00000000000000000000000000000000",
      data54(31 downto 0) => B"00000000000000000000000000000000",
      data55(31 downto 0) => B"00000000000000000000000000000000",
      data56(31 downto 0) => B"00000000000000000000000000000000",
      data57(31 downto 0) => B"00000000000000000000000000000000",
      data58(31 downto 0) => B"00000000000000000000000000000000",
      data59(31 downto 0) => B"00000000000000000000000000000000",
      data6(31 downto 0) => B"00000000000000000000000000000000",
      data60(31 downto 0) => B"00000000000000000000000000000000",
      data61(31 downto 0) => B"00000000000000000000000000000000",
      data62(31 downto 0) => B"00000000000000000000000000000000",
      data63(31 downto 0) => B"00000000000000000000000000000000",
      data64(31 downto 0) => B"00000000000000000000000000000000",
      data65(31 downto 0) => B"00000000000000000000000000000000",
      data66(31 downto 0) => B"00000000000000000000000000000000",
      data67(31 downto 0) => B"00000000000000000000000000000000",
      data68(31 downto 0) => B"00000000000000000000000000000000",
      data69(31 downto 0) => B"00000000000000000000000000000000",
      data7(31 downto 0) => B"00000000000000000000000000000000",
      data70(31 downto 0) => B"00000000000000000000000000000000",
      data71(31 downto 0) => B"00000000000000000000000000000000",
      data72(31 downto 0) => B"00000000000000000000000000000000",
      data73(31 downto 0) => B"00000000000000000000000000000000",
      data74(31 downto 0) => B"00000000000000000000000000000000",
      data75(31 downto 0) => B"00000000000000000000000000000000",
      data76(31 downto 0) => B"00000000000000000000000000000000",
      data77(31 downto 0) => B"00000000000000000000000000000000",
      data78(31 downto 0) => B"00000000000000000000000000000000",
      data79(31 downto 0) => B"00000000000000000000000000000000",
      data8(31 downto 0) => B"00000000000000000000000000000000",
      data80(31 downto 0) => B"00000000000000000000000000000000",
      data81(31 downto 0) => B"00000000000000000000000000000000",
      data82(31 downto 0) => B"00000000000000000000000000000000",
      data83(31 downto 0) => B"00000000000000000000000000000000",
      data84(31 downto 0) => B"00000000000000000000000000000000",
      data85(31 downto 0) => B"00000000000000000000000000000000",
      data86(31 downto 0) => B"00000000000000000000000000000000",
      data87(31 downto 0) => B"00000000000000000000000000000000",
      data88(31 downto 0) => B"00000000000000000000000000000000",
      data89(31 downto 0) => B"00000000000000000000000000000000",
      data9(31 downto 0) => B"00000000000000000000000000000000",
      data90(31 downto 0) => B"00000000000000000000000000000000",
      data91(31 downto 0) => B"00000000000000000000000000000000",
      data92(31 downto 0) => B"00000000000000000000000000000000",
      data93(31 downto 0) => B"00000000000000000000000000000000",
      data94(31 downto 0) => B"00000000000000000000000000000000",
      data95(31 downto 0) => B"00000000000000000000000000000000",
      data96(31 downto 0) => B"00000000000000000000000000000000",
      data97(31 downto 0) => B"00000000000000000000000000000000",
      data98(31 downto 0) => B"00000000000000000000000000000000",
      data99(31 downto 0) => B"00000000000000000000000000000000",
      param0(31 downto 0) => mon_module_0_param0(31 downto 0),
      param1(31 downto 0) => mon_module_0_param1(31 downto 0),
      param10(31 downto 0) => NLW_mon_module_0_param10_UNCONNECTED(31 downto 0),
      param100(31 downto 0) => NLW_mon_module_0_param100_UNCONNECTED(31 downto 0),
      param101(31 downto 0) => NLW_mon_module_0_param101_UNCONNECTED(31 downto 0),
      param102(31 downto 0) => NLW_mon_module_0_param102_UNCONNECTED(31 downto 0),
      param103(31 downto 0) => NLW_mon_module_0_param103_UNCONNECTED(31 downto 0),
      param104(31 downto 0) => NLW_mon_module_0_param104_UNCONNECTED(31 downto 0),
      param105(31 downto 0) => NLW_mon_module_0_param105_UNCONNECTED(31 downto 0),
      param106(31 downto 0) => NLW_mon_module_0_param106_UNCONNECTED(31 downto 0),
      param107(31 downto 0) => NLW_mon_module_0_param107_UNCONNECTED(31 downto 0),
      param108(31 downto 0) => NLW_mon_module_0_param108_UNCONNECTED(31 downto 0),
      param109(31 downto 0) => NLW_mon_module_0_param109_UNCONNECTED(31 downto 0),
      param11(31 downto 0) => NLW_mon_module_0_param11_UNCONNECTED(31 downto 0),
      param110(31 downto 0) => NLW_mon_module_0_param110_UNCONNECTED(31 downto 0),
      param111(31 downto 0) => NLW_mon_module_0_param111_UNCONNECTED(31 downto 0),
      param112(31 downto 0) => NLW_mon_module_0_param112_UNCONNECTED(31 downto 0),
      param113(31 downto 0) => NLW_mon_module_0_param113_UNCONNECTED(31 downto 0),
      param114(31 downto 0) => NLW_mon_module_0_param114_UNCONNECTED(31 downto 0),
      param115(31 downto 0) => NLW_mon_module_0_param115_UNCONNECTED(31 downto 0),
      param116(31 downto 0) => NLW_mon_module_0_param116_UNCONNECTED(31 downto 0),
      param117(31 downto 0) => NLW_mon_module_0_param117_UNCONNECTED(31 downto 0),
      param118(31 downto 0) => NLW_mon_module_0_param118_UNCONNECTED(31 downto 0),
      param119(31 downto 0) => NLW_mon_module_0_param119_UNCONNECTED(31 downto 0),
      param12(31 downto 0) => NLW_mon_module_0_param12_UNCONNECTED(31 downto 0),
      param120(31 downto 0) => NLW_mon_module_0_param120_UNCONNECTED(31 downto 0),
      param121(31 downto 0) => NLW_mon_module_0_param121_UNCONNECTED(31 downto 0),
      param122(31 downto 0) => NLW_mon_module_0_param122_UNCONNECTED(31 downto 0),
      param123(31 downto 0) => NLW_mon_module_0_param123_UNCONNECTED(31 downto 0),
      param124(31 downto 0) => NLW_mon_module_0_param124_UNCONNECTED(31 downto 0),
      param125(31 downto 0) => NLW_mon_module_0_param125_UNCONNECTED(31 downto 0),
      param126(31 downto 0) => NLW_mon_module_0_param126_UNCONNECTED(31 downto 0),
      param127(31 downto 0) => NLW_mon_module_0_param127_UNCONNECTED(31 downto 0),
      param13(31 downto 0) => NLW_mon_module_0_param13_UNCONNECTED(31 downto 0),
      param14(31 downto 0) => NLW_mon_module_0_param14_UNCONNECTED(31 downto 0),
      param15(31 downto 0) => NLW_mon_module_0_param15_UNCONNECTED(31 downto 0),
      param16(31 downto 0) => NLW_mon_module_0_param16_UNCONNECTED(31 downto 0),
      param17(31 downto 0) => NLW_mon_module_0_param17_UNCONNECTED(31 downto 0),
      param18(31 downto 0) => NLW_mon_module_0_param18_UNCONNECTED(31 downto 0),
      param19(31 downto 0) => NLW_mon_module_0_param19_UNCONNECTED(31 downto 0),
      param2(31 downto 0) => mon_module_0_param2(31 downto 0),
      param20(31 downto 0) => NLW_mon_module_0_param20_UNCONNECTED(31 downto 0),
      param21(31 downto 0) => NLW_mon_module_0_param21_UNCONNECTED(31 downto 0),
      param22(31 downto 0) => NLW_mon_module_0_param22_UNCONNECTED(31 downto 0),
      param23(31 downto 0) => NLW_mon_module_0_param23_UNCONNECTED(31 downto 0),
      param24(31 downto 0) => NLW_mon_module_0_param24_UNCONNECTED(31 downto 0),
      param25(31 downto 0) => NLW_mon_module_0_param25_UNCONNECTED(31 downto 0),
      param26(31 downto 0) => NLW_mon_module_0_param26_UNCONNECTED(31 downto 0),
      param27(31 downto 0) => NLW_mon_module_0_param27_UNCONNECTED(31 downto 0),
      param28(31 downto 0) => NLW_mon_module_0_param28_UNCONNECTED(31 downto 0),
      param29(31 downto 0) => NLW_mon_module_0_param29_UNCONNECTED(31 downto 0),
      param3(31 downto 0) => mon_module_0_param3(31 downto 0),
      param30(31 downto 0) => NLW_mon_module_0_param30_UNCONNECTED(31 downto 0),
      param31(31 downto 0) => NLW_mon_module_0_param31_UNCONNECTED(31 downto 0),
      param32(31 downto 0) => NLW_mon_module_0_param32_UNCONNECTED(31 downto 0),
      param33(31 downto 0) => NLW_mon_module_0_param33_UNCONNECTED(31 downto 0),
      param34(31 downto 0) => NLW_mon_module_0_param34_UNCONNECTED(31 downto 0),
      param35(31 downto 0) => NLW_mon_module_0_param35_UNCONNECTED(31 downto 0),
      param36(31 downto 0) => NLW_mon_module_0_param36_UNCONNECTED(31 downto 0),
      param37(31 downto 0) => NLW_mon_module_0_param37_UNCONNECTED(31 downto 0),
      param38(31 downto 0) => NLW_mon_module_0_param38_UNCONNECTED(31 downto 0),
      param39(31 downto 0) => NLW_mon_module_0_param39_UNCONNECTED(31 downto 0),
      param4(31 downto 0) => mon_module_0_param4(31 downto 0),
      param40(31 downto 0) => NLW_mon_module_0_param40_UNCONNECTED(31 downto 0),
      param41(31 downto 0) => NLW_mon_module_0_param41_UNCONNECTED(31 downto 0),
      param42(31 downto 0) => NLW_mon_module_0_param42_UNCONNECTED(31 downto 0),
      param43(31 downto 0) => NLW_mon_module_0_param43_UNCONNECTED(31 downto 0),
      param44(31 downto 0) => NLW_mon_module_0_param44_UNCONNECTED(31 downto 0),
      param45(31 downto 0) => NLW_mon_module_0_param45_UNCONNECTED(31 downto 0),
      param46(31 downto 0) => NLW_mon_module_0_param46_UNCONNECTED(31 downto 0),
      param47(31 downto 0) => NLW_mon_module_0_param47_UNCONNECTED(31 downto 0),
      param48(31 downto 0) => NLW_mon_module_0_param48_UNCONNECTED(31 downto 0),
      param49(31 downto 0) => NLW_mon_module_0_param49_UNCONNECTED(31 downto 0),
      param5(31 downto 0) => mon_module_0_param5(31 downto 0),
      param50(31 downto 0) => NLW_mon_module_0_param50_UNCONNECTED(31 downto 0),
      param51(31 downto 0) => NLW_mon_module_0_param51_UNCONNECTED(31 downto 0),
      param52(31 downto 0) => NLW_mon_module_0_param52_UNCONNECTED(31 downto 0),
      param53(31 downto 0) => NLW_mon_module_0_param53_UNCONNECTED(31 downto 0),
      param54(31 downto 0) => NLW_mon_module_0_param54_UNCONNECTED(31 downto 0),
      param55(31 downto 0) => NLW_mon_module_0_param55_UNCONNECTED(31 downto 0),
      param56(31 downto 0) => NLW_mon_module_0_param56_UNCONNECTED(31 downto 0),
      param57(31 downto 0) => NLW_mon_module_0_param57_UNCONNECTED(31 downto 0),
      param58(31 downto 0) => NLW_mon_module_0_param58_UNCONNECTED(31 downto 0),
      param59(31 downto 0) => NLW_mon_module_0_param59_UNCONNECTED(31 downto 0),
      param6(31 downto 0) => mon_module_0_param6(31 downto 0),
      param60(31 downto 0) => NLW_mon_module_0_param60_UNCONNECTED(31 downto 0),
      param61(31 downto 0) => NLW_mon_module_0_param61_UNCONNECTED(31 downto 0),
      param62(31 downto 0) => NLW_mon_module_0_param62_UNCONNECTED(31 downto 0),
      param63(31 downto 0) => NLW_mon_module_0_param63_UNCONNECTED(31 downto 0),
      param64(31 downto 0) => NLW_mon_module_0_param64_UNCONNECTED(31 downto 0),
      param65(31 downto 0) => NLW_mon_module_0_param65_UNCONNECTED(31 downto 0),
      param66(31 downto 0) => NLW_mon_module_0_param66_UNCONNECTED(31 downto 0),
      param67(31 downto 0) => NLW_mon_module_0_param67_UNCONNECTED(31 downto 0),
      param68(31 downto 0) => NLW_mon_module_0_param68_UNCONNECTED(31 downto 0),
      param69(31 downto 0) => NLW_mon_module_0_param69_UNCONNECTED(31 downto 0),
      param7(31 downto 0) => mon_module_0_param7(31 downto 0),
      param70(31 downto 0) => NLW_mon_module_0_param70_UNCONNECTED(31 downto 0),
      param71(31 downto 0) => NLW_mon_module_0_param71_UNCONNECTED(31 downto 0),
      param72(31 downto 0) => NLW_mon_module_0_param72_UNCONNECTED(31 downto 0),
      param73(31 downto 0) => NLW_mon_module_0_param73_UNCONNECTED(31 downto 0),
      param74(31 downto 0) => NLW_mon_module_0_param74_UNCONNECTED(31 downto 0),
      param75(31 downto 0) => NLW_mon_module_0_param75_UNCONNECTED(31 downto 0),
      param76(31 downto 0) => NLW_mon_module_0_param76_UNCONNECTED(31 downto 0),
      param77(31 downto 0) => NLW_mon_module_0_param77_UNCONNECTED(31 downto 0),
      param78(31 downto 0) => NLW_mon_module_0_param78_UNCONNECTED(31 downto 0),
      param79(31 downto 0) => NLW_mon_module_0_param79_UNCONNECTED(31 downto 0),
      param8(31 downto 0) => NLW_mon_module_0_param8_UNCONNECTED(31 downto 0),
      param80(31 downto 0) => NLW_mon_module_0_param80_UNCONNECTED(31 downto 0),
      param81(31 downto 0) => NLW_mon_module_0_param81_UNCONNECTED(31 downto 0),
      param82(31 downto 0) => NLW_mon_module_0_param82_UNCONNECTED(31 downto 0),
      param83(31 downto 0) => NLW_mon_module_0_param83_UNCONNECTED(31 downto 0),
      param84(31 downto 0) => NLW_mon_module_0_param84_UNCONNECTED(31 downto 0),
      param85(31 downto 0) => NLW_mon_module_0_param85_UNCONNECTED(31 downto 0),
      param86(31 downto 0) => NLW_mon_module_0_param86_UNCONNECTED(31 downto 0),
      param87(31 downto 0) => NLW_mon_module_0_param87_UNCONNECTED(31 downto 0),
      param88(31 downto 0) => NLW_mon_module_0_param88_UNCONNECTED(31 downto 0),
      param89(31 downto 0) => NLW_mon_module_0_param89_UNCONNECTED(31 downto 0),
      param9(31 downto 0) => NLW_mon_module_0_param9_UNCONNECTED(31 downto 0),
      param90(31 downto 0) => NLW_mon_module_0_param90_UNCONNECTED(31 downto 0),
      param91(31 downto 0) => NLW_mon_module_0_param91_UNCONNECTED(31 downto 0),
      param92(31 downto 0) => NLW_mon_module_0_param92_UNCONNECTED(31 downto 0),
      param93(31 downto 0) => NLW_mon_module_0_param93_UNCONNECTED(31 downto 0),
      param94(31 downto 0) => NLW_mon_module_0_param94_UNCONNECTED(31 downto 0),
      param95(31 downto 0) => NLW_mon_module_0_param95_UNCONNECTED(31 downto 0),
      param96(31 downto 0) => NLW_mon_module_0_param96_UNCONNECTED(31 downto 0),
      param97(31 downto 0) => NLW_mon_module_0_param97_UNCONNECTED(31 downto 0),
      param98(31 downto 0) => NLW_mon_module_0_param98_UNCONNECTED(31 downto 0),
      param99(31 downto 0) => NLW_mon_module_0_param99_UNCONNECTED(31 downto 0),
      reset => proc_sys_reset_0_peripheral_reset(0)
    );
proc_sys_reset_0: component design_1_proc_sys_reset_0_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => NLW_proc_sys_reset_0_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => clk_wiz_0_locked,
      ext_reset_in => reset_btn_1,
      interconnect_aresetn(0) => NLW_proc_sys_reset_0_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => '0',
      mb_reset => NLW_proc_sys_reset_0_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => proc_sys_reset_0_peripheral_aresetn(0),
      peripheral_reset(0) => proc_sys_reset_0_peripheral_reset(0),
      slowest_sync_clk => clk_wiz_0_clk10
    );
sd_multiplexer_0: component design_1_sd_multiplexer_0_0
     port map (
      clk => clk_wiz_0_clk10,
      clkx4 => clk_wiz_0_clkx4,
      sd(3 downto 0) => sd_multiplexer_0_sd(3 downto 0),
      sd_clk_0 => sd_multiplexer_0_sd_clk_0,
      sd_clk_90 => sd_multiplexer_0_sd_clk_90,
      sdac_a(7 downto 0) => RLUb_HIL_ip_0_SDMuxA(7 downto 0),
      sdac_b(7 downto 0) => RLUb_HIL_ip_0_SDMuxB(7 downto 0)
    );
xlconstant_0: component design_1_xlconstant_0_0
     port map (
      dout(0) => xlconstant_0_dout(0)
    );
end STRUCTURE;
