-- (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:RLUb_HIL_ip:1.0
-- IP Revision: 1000000

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_RLUb_HIL_ip_0_0 IS
  PORT (
    IPCORE_CLK : IN STD_LOGIC;
    IPCORE_RESETN : IN STD_LOGIC;
    IOextIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    Param0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Param7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ZyboBTN : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    ZyboSW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    CtrlH : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    CtrlL : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    IOextOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    SDMuxA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    SDMuxB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    Data0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    Data1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    Data2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    Data3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    Data4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ZyboLED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Status : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    Fail : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    QEP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END design_1_RLUb_HIL_ip_0_0;

ARCHITECTURE design_1_RLUb_HIL_ip_0_0_arch OF design_1_RLUb_HIL_ip_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_RLUb_HIL_ip_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT RLUb_HIL_ip IS
    PORT (
      IPCORE_CLK : IN STD_LOGIC;
      IPCORE_RESETN : IN STD_LOGIC;
      IOextIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      Param0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      Param7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      ZyboBTN : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      ZyboSW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      CtrlH : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      CtrlL : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      IOextOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      SDMuxA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      SDMuxB : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      Data0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      Data1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      Data2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      Data3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      Data4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ZyboLED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      Status : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      Fail : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      QEP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT RLUb_HIL_ip;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF design_1_RLUb_HIL_ip_0_0_arch: ARCHITECTURE IS "RLUb_HIL_ip,Vivado 2018.2.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF design_1_RLUb_HIL_ip_0_0_arch : ARCHITECTURE IS "design_1_RLUb_HIL_ip_0_0,RLUb_HIL_ip,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF design_1_RLUb_HIL_ip_0_0_arch: ARCHITECTURE IS "design_1_RLUb_HIL_ip_0_0,RLUb_HIL_ip,{x_ipProduct=Vivado 2018.2.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=RLUb_HIL_ip,x_ipVersion=1.0,x_ipCoreRevision=1000000,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF design_1_RLUb_HIL_ip_0_0_arch: ARCHITECTURE IS "package_project";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF IPCORE_RESETN: SIGNAL IS "XIL_INTERFACENAME IPCORE_RESETN, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF IPCORE_RESETN: SIGNAL IS "xilinx.com:signal:reset:1.0 IPCORE_RESETN RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF IPCORE_CLK: SIGNAL IS "XIL_INTERFACENAME IPCORE_CLK, ASSOCIATED_RESET IPCORE_RESETN, FREQ_HZ 20000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1";
  ATTRIBUTE X_INTERFACE_INFO OF IPCORE_CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 IPCORE_CLK CLK";
BEGIN
  U0 : RLUb_HIL_ip
    PORT MAP (
      IPCORE_CLK => IPCORE_CLK,
      IPCORE_RESETN => IPCORE_RESETN,
      IOextIn => IOextIn,
      Param0 => Param0,
      Param1 => Param1,
      Param2 => Param2,
      Param3 => Param3,
      Param4 => Param4,
      Param5 => Param5,
      Param6 => Param6,
      Param7 => Param7,
      ZyboBTN => ZyboBTN,
      ZyboSW => ZyboSW,
      CtrlH => CtrlH,
      CtrlL => CtrlL,
      IOextOut => IOextOut,
      SDMuxA => SDMuxA,
      SDMuxB => SDMuxB,
      Data0 => Data0,
      Data1 => Data1,
      Data2 => Data2,
      Data3 => Data3,
      Data4 => Data4,
      ZyboLED => ZyboLED,
      Status => Status,
      Fail => Fail,
      QEP => QEP
    );
END design_1_RLUb_HIL_ip_0_0_arch;
