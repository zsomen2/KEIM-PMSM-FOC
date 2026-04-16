--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2.2 (win64) Build 2348494 Mon Oct  1 18:25:44 MDT 2018
--Date        : Fri Mar 27 14:59:58 2026
--Host        : LENI running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
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
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    clk125 : in STD_LOGIC;
    ioext_spi_cs : out STD_LOGIC;
    ioext_spi_mosi : out STD_LOGIC;
    ioext_spi_clk : out STD_LOGIC;
    ioext_spi_miso : in STD_LOGIC;
    uart_tx : out STD_LOGIC;
    reset_btn : in STD_LOGIC;
    sd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sd_clk_0 : out STD_LOGIC;
    sd_clk_90 : out STD_LOGIC;
    uart_rx : in STD_LOGIC;
    QEP : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Fail : out STD_LOGIC_VECTOR ( 3 downto 0 );
    CtrlH : in STD_LOGIC_VECTOR ( 3 downto 0 );
    CtrlL : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Status : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ZyboBTN : in STD_LOGIC_VECTOR ( 2 downto 0 );
    ZyboSW : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ZyboLED : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      CtrlH(3 downto 0) => CtrlH(3 downto 0),
      CtrlL(3 downto 0) => CtrlL(3 downto 0),
      Fail(3 downto 0) => Fail(3 downto 0),
      QEP(3 downto 0) => QEP(3 downto 0),
      Status(3 downto 0) => Status(3 downto 0),
      ZyboBTN(2 downto 0) => ZyboBTN(2 downto 0),
      ZyboLED(3 downto 0) => ZyboLED(3 downto 0),
      ZyboSW(3 downto 0) => ZyboSW(3 downto 0),
      clk125 => clk125,
      ioext_spi_clk => ioext_spi_clk,
      ioext_spi_cs => ioext_spi_cs,
      ioext_spi_miso => ioext_spi_miso,
      ioext_spi_mosi => ioext_spi_mosi,
      reset_btn => reset_btn,
      sd(3 downto 0) => sd(3 downto 0),
      sd_clk_0 => sd_clk_0,
      sd_clk_90 => sd_clk_90,
      uart_rx => uart_rx,
      uart_tx => uart_tx
    );
end STRUCTURE;
