# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ANS_ANSWER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANS_GET_KEY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANS_GET_LEN_HIGH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANS_GET_LEN_LOW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANS_GET_LEN_LOW_LOW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANS_GET_MODE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ANS_INIC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BBX_TV_16BIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BBX_TV_16B_UPPER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BBX_TV_32BIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BBX_TV_FLOAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BBX_TV_SIGNED" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BBX_TV_UNSIGNED" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ETX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FPGA_ADDRESS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_PING" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_RD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_RDUNITS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_RD_BBX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_RD_ERRH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_RD_SPI_RAM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_REBOOT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_TABNAMES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_TABS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_TABVALUES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MON_WR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SER_BASE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SER_RECING" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SER_WAIT_DATA_STORE_AND_CHKSUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TABTITLE_START_ADDRESS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_16BIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_32BIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_ENWR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_FLOAT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_HEX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_SIGNED" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TYP_UNSIGNED" -parent ${Page_0}
  ipgui::add_param $IPINST -name "UNITS_START_ADDRESS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "VARS_START_ADDRESS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "XDT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "baud_rate_step" -parent ${Page_0}


}

proc update_PARAM_VALUE.ANS_ANSWER { PARAM_VALUE.ANS_ANSWER } {
	# Procedure called to update ANS_ANSWER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_ANSWER { PARAM_VALUE.ANS_ANSWER } {
	# Procedure called to validate ANS_ANSWER
	return true
}

proc update_PARAM_VALUE.ANS_GET_KEY { PARAM_VALUE.ANS_GET_KEY } {
	# Procedure called to update ANS_GET_KEY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_GET_KEY { PARAM_VALUE.ANS_GET_KEY } {
	# Procedure called to validate ANS_GET_KEY
	return true
}

proc update_PARAM_VALUE.ANS_GET_LEN_HIGH { PARAM_VALUE.ANS_GET_LEN_HIGH } {
	# Procedure called to update ANS_GET_LEN_HIGH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_GET_LEN_HIGH { PARAM_VALUE.ANS_GET_LEN_HIGH } {
	# Procedure called to validate ANS_GET_LEN_HIGH
	return true
}

proc update_PARAM_VALUE.ANS_GET_LEN_LOW { PARAM_VALUE.ANS_GET_LEN_LOW } {
	# Procedure called to update ANS_GET_LEN_LOW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_GET_LEN_LOW { PARAM_VALUE.ANS_GET_LEN_LOW } {
	# Procedure called to validate ANS_GET_LEN_LOW
	return true
}

proc update_PARAM_VALUE.ANS_GET_LEN_LOW_LOW { PARAM_VALUE.ANS_GET_LEN_LOW_LOW } {
	# Procedure called to update ANS_GET_LEN_LOW_LOW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_GET_LEN_LOW_LOW { PARAM_VALUE.ANS_GET_LEN_LOW_LOW } {
	# Procedure called to validate ANS_GET_LEN_LOW_LOW
	return true
}

proc update_PARAM_VALUE.ANS_GET_MODE { PARAM_VALUE.ANS_GET_MODE } {
	# Procedure called to update ANS_GET_MODE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_GET_MODE { PARAM_VALUE.ANS_GET_MODE } {
	# Procedure called to validate ANS_GET_MODE
	return true
}

proc update_PARAM_VALUE.ANS_INIC { PARAM_VALUE.ANS_INIC } {
	# Procedure called to update ANS_INIC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ANS_INIC { PARAM_VALUE.ANS_INIC } {
	# Procedure called to validate ANS_INIC
	return true
}

proc update_PARAM_VALUE.BBX_TV_16BIT { PARAM_VALUE.BBX_TV_16BIT } {
	# Procedure called to update BBX_TV_16BIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BBX_TV_16BIT { PARAM_VALUE.BBX_TV_16BIT } {
	# Procedure called to validate BBX_TV_16BIT
	return true
}

proc update_PARAM_VALUE.BBX_TV_16B_UPPER { PARAM_VALUE.BBX_TV_16B_UPPER } {
	# Procedure called to update BBX_TV_16B_UPPER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BBX_TV_16B_UPPER { PARAM_VALUE.BBX_TV_16B_UPPER } {
	# Procedure called to validate BBX_TV_16B_UPPER
	return true
}

proc update_PARAM_VALUE.BBX_TV_32BIT { PARAM_VALUE.BBX_TV_32BIT } {
	# Procedure called to update BBX_TV_32BIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BBX_TV_32BIT { PARAM_VALUE.BBX_TV_32BIT } {
	# Procedure called to validate BBX_TV_32BIT
	return true
}

proc update_PARAM_VALUE.BBX_TV_FLOAT { PARAM_VALUE.BBX_TV_FLOAT } {
	# Procedure called to update BBX_TV_FLOAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BBX_TV_FLOAT { PARAM_VALUE.BBX_TV_FLOAT } {
	# Procedure called to validate BBX_TV_FLOAT
	return true
}

proc update_PARAM_VALUE.BBX_TV_SIGNED { PARAM_VALUE.BBX_TV_SIGNED } {
	# Procedure called to update BBX_TV_SIGNED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BBX_TV_SIGNED { PARAM_VALUE.BBX_TV_SIGNED } {
	# Procedure called to validate BBX_TV_SIGNED
	return true
}

proc update_PARAM_VALUE.BBX_TV_UNSIGNED { PARAM_VALUE.BBX_TV_UNSIGNED } {
	# Procedure called to update BBX_TV_UNSIGNED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BBX_TV_UNSIGNED { PARAM_VALUE.BBX_TV_UNSIGNED } {
	# Procedure called to validate BBX_TV_UNSIGNED
	return true
}

proc update_PARAM_VALUE.DLE { PARAM_VALUE.DLE } {
	# Procedure called to update DLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DLE { PARAM_VALUE.DLE } {
	# Procedure called to validate DLE
	return true
}

proc update_PARAM_VALUE.ETX { PARAM_VALUE.ETX } {
	# Procedure called to update ETX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ETX { PARAM_VALUE.ETX } {
	# Procedure called to validate ETX
	return true
}

proc update_PARAM_VALUE.FPGA_ADDRESS { PARAM_VALUE.FPGA_ADDRESS } {
	# Procedure called to update FPGA_ADDRESS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FPGA_ADDRESS { PARAM_VALUE.FPGA_ADDRESS } {
	# Procedure called to validate FPGA_ADDRESS
	return true
}

proc update_PARAM_VALUE.MON_PING { PARAM_VALUE.MON_PING } {
	# Procedure called to update MON_PING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_PING { PARAM_VALUE.MON_PING } {
	# Procedure called to validate MON_PING
	return true
}

proc update_PARAM_VALUE.MON_RD { PARAM_VALUE.MON_RD } {
	# Procedure called to update MON_RD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_RD { PARAM_VALUE.MON_RD } {
	# Procedure called to validate MON_RD
	return true
}

proc update_PARAM_VALUE.MON_RDUNITS { PARAM_VALUE.MON_RDUNITS } {
	# Procedure called to update MON_RDUNITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_RDUNITS { PARAM_VALUE.MON_RDUNITS } {
	# Procedure called to validate MON_RDUNITS
	return true
}

proc update_PARAM_VALUE.MON_RD_BBX { PARAM_VALUE.MON_RD_BBX } {
	# Procedure called to update MON_RD_BBX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_RD_BBX { PARAM_VALUE.MON_RD_BBX } {
	# Procedure called to validate MON_RD_BBX
	return true
}

proc update_PARAM_VALUE.MON_RD_ERRH { PARAM_VALUE.MON_RD_ERRH } {
	# Procedure called to update MON_RD_ERRH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_RD_ERRH { PARAM_VALUE.MON_RD_ERRH } {
	# Procedure called to validate MON_RD_ERRH
	return true
}

proc update_PARAM_VALUE.MON_RD_SPI_RAM { PARAM_VALUE.MON_RD_SPI_RAM } {
	# Procedure called to update MON_RD_SPI_RAM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_RD_SPI_RAM { PARAM_VALUE.MON_RD_SPI_RAM } {
	# Procedure called to validate MON_RD_SPI_RAM
	return true
}

proc update_PARAM_VALUE.MON_REBOOT { PARAM_VALUE.MON_REBOOT } {
	# Procedure called to update MON_REBOOT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_REBOOT { PARAM_VALUE.MON_REBOOT } {
	# Procedure called to validate MON_REBOOT
	return true
}

proc update_PARAM_VALUE.MON_TABNAMES { PARAM_VALUE.MON_TABNAMES } {
	# Procedure called to update MON_TABNAMES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_TABNAMES { PARAM_VALUE.MON_TABNAMES } {
	# Procedure called to validate MON_TABNAMES
	return true
}

proc update_PARAM_VALUE.MON_TABS { PARAM_VALUE.MON_TABS } {
	# Procedure called to update MON_TABS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_TABS { PARAM_VALUE.MON_TABS } {
	# Procedure called to validate MON_TABS
	return true
}

proc update_PARAM_VALUE.MON_TABVALUES { PARAM_VALUE.MON_TABVALUES } {
	# Procedure called to update MON_TABVALUES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_TABVALUES { PARAM_VALUE.MON_TABVALUES } {
	# Procedure called to validate MON_TABVALUES
	return true
}

proc update_PARAM_VALUE.MON_WR { PARAM_VALUE.MON_WR } {
	# Procedure called to update MON_WR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MON_WR { PARAM_VALUE.MON_WR } {
	# Procedure called to validate MON_WR
	return true
}

proc update_PARAM_VALUE.SER_BASE { PARAM_VALUE.SER_BASE } {
	# Procedure called to update SER_BASE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SER_BASE { PARAM_VALUE.SER_BASE } {
	# Procedure called to validate SER_BASE
	return true
}

proc update_PARAM_VALUE.SER_RECING { PARAM_VALUE.SER_RECING } {
	# Procedure called to update SER_RECING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SER_RECING { PARAM_VALUE.SER_RECING } {
	# Procedure called to validate SER_RECING
	return true
}

proc update_PARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM { PARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM } {
	# Procedure called to update SER_WAIT_DATA_STORE_AND_CHKSUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM { PARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM } {
	# Procedure called to validate SER_WAIT_DATA_STORE_AND_CHKSUM
	return true
}

proc update_PARAM_VALUE.STX { PARAM_VALUE.STX } {
	# Procedure called to update STX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STX { PARAM_VALUE.STX } {
	# Procedure called to validate STX
	return true
}

proc update_PARAM_VALUE.TABTITLE_START_ADDRESS { PARAM_VALUE.TABTITLE_START_ADDRESS } {
	# Procedure called to update TABTITLE_START_ADDRESS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TABTITLE_START_ADDRESS { PARAM_VALUE.TABTITLE_START_ADDRESS } {
	# Procedure called to validate TABTITLE_START_ADDRESS
	return true
}

proc update_PARAM_VALUE.TYP_16BIT { PARAM_VALUE.TYP_16BIT } {
	# Procedure called to update TYP_16BIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_16BIT { PARAM_VALUE.TYP_16BIT } {
	# Procedure called to validate TYP_16BIT
	return true
}

proc update_PARAM_VALUE.TYP_32BIT { PARAM_VALUE.TYP_32BIT } {
	# Procedure called to update TYP_32BIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_32BIT { PARAM_VALUE.TYP_32BIT } {
	# Procedure called to validate TYP_32BIT
	return true
}

proc update_PARAM_VALUE.TYP_ENWR { PARAM_VALUE.TYP_ENWR } {
	# Procedure called to update TYP_ENWR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_ENWR { PARAM_VALUE.TYP_ENWR } {
	# Procedure called to validate TYP_ENWR
	return true
}

proc update_PARAM_VALUE.TYP_FLOAT { PARAM_VALUE.TYP_FLOAT } {
	# Procedure called to update TYP_FLOAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_FLOAT { PARAM_VALUE.TYP_FLOAT } {
	# Procedure called to validate TYP_FLOAT
	return true
}

proc update_PARAM_VALUE.TYP_HEX { PARAM_VALUE.TYP_HEX } {
	# Procedure called to update TYP_HEX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_HEX { PARAM_VALUE.TYP_HEX } {
	# Procedure called to validate TYP_HEX
	return true
}

proc update_PARAM_VALUE.TYP_SIGNED { PARAM_VALUE.TYP_SIGNED } {
	# Procedure called to update TYP_SIGNED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_SIGNED { PARAM_VALUE.TYP_SIGNED } {
	# Procedure called to validate TYP_SIGNED
	return true
}

proc update_PARAM_VALUE.TYP_UNSIGNED { PARAM_VALUE.TYP_UNSIGNED } {
	# Procedure called to update TYP_UNSIGNED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TYP_UNSIGNED { PARAM_VALUE.TYP_UNSIGNED } {
	# Procedure called to validate TYP_UNSIGNED
	return true
}

proc update_PARAM_VALUE.UNITS_START_ADDRESS { PARAM_VALUE.UNITS_START_ADDRESS } {
	# Procedure called to update UNITS_START_ADDRESS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.UNITS_START_ADDRESS { PARAM_VALUE.UNITS_START_ADDRESS } {
	# Procedure called to validate UNITS_START_ADDRESS
	return true
}

proc update_PARAM_VALUE.VARS_START_ADDRESS { PARAM_VALUE.VARS_START_ADDRESS } {
	# Procedure called to update VARS_START_ADDRESS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VARS_START_ADDRESS { PARAM_VALUE.VARS_START_ADDRESS } {
	# Procedure called to validate VARS_START_ADDRESS
	return true
}

proc update_PARAM_VALUE.XDT { PARAM_VALUE.XDT } {
	# Procedure called to update XDT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.XDT { PARAM_VALUE.XDT } {
	# Procedure called to validate XDT
	return true
}

proc update_PARAM_VALUE.baud_rate_step { PARAM_VALUE.baud_rate_step } {
	# Procedure called to update baud_rate_step when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.baud_rate_step { PARAM_VALUE.baud_rate_step } {
	# Procedure called to validate baud_rate_step
	return true
}


proc update_MODELPARAM_VALUE.baud_rate_step { MODELPARAM_VALUE.baud_rate_step PARAM_VALUE.baud_rate_step } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.baud_rate_step}] ${MODELPARAM_VALUE.baud_rate_step}
}

proc update_MODELPARAM_VALUE.FPGA_ADDRESS { MODELPARAM_VALUE.FPGA_ADDRESS PARAM_VALUE.FPGA_ADDRESS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FPGA_ADDRESS}] ${MODELPARAM_VALUE.FPGA_ADDRESS}
}

proc update_MODELPARAM_VALUE.SER_BASE { MODELPARAM_VALUE.SER_BASE PARAM_VALUE.SER_BASE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SER_BASE}] ${MODELPARAM_VALUE.SER_BASE}
}

proc update_MODELPARAM_VALUE.SER_RECING { MODELPARAM_VALUE.SER_RECING PARAM_VALUE.SER_RECING } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SER_RECING}] ${MODELPARAM_VALUE.SER_RECING}
}

proc update_MODELPARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM { MODELPARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM PARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM}] ${MODELPARAM_VALUE.SER_WAIT_DATA_STORE_AND_CHKSUM}
}

proc update_MODELPARAM_VALUE.ANS_INIC { MODELPARAM_VALUE.ANS_INIC PARAM_VALUE.ANS_INIC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_INIC}] ${MODELPARAM_VALUE.ANS_INIC}
}

proc update_MODELPARAM_VALUE.ANS_GET_MODE { MODELPARAM_VALUE.ANS_GET_MODE PARAM_VALUE.ANS_GET_MODE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_GET_MODE}] ${MODELPARAM_VALUE.ANS_GET_MODE}
}

proc update_MODELPARAM_VALUE.ANS_GET_KEY { MODELPARAM_VALUE.ANS_GET_KEY PARAM_VALUE.ANS_GET_KEY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_GET_KEY}] ${MODELPARAM_VALUE.ANS_GET_KEY}
}

proc update_MODELPARAM_VALUE.ANS_GET_LEN_HIGH { MODELPARAM_VALUE.ANS_GET_LEN_HIGH PARAM_VALUE.ANS_GET_LEN_HIGH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_GET_LEN_HIGH}] ${MODELPARAM_VALUE.ANS_GET_LEN_HIGH}
}

proc update_MODELPARAM_VALUE.ANS_GET_LEN_LOW { MODELPARAM_VALUE.ANS_GET_LEN_LOW PARAM_VALUE.ANS_GET_LEN_LOW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_GET_LEN_LOW}] ${MODELPARAM_VALUE.ANS_GET_LEN_LOW}
}

proc update_MODELPARAM_VALUE.ANS_GET_LEN_LOW_LOW { MODELPARAM_VALUE.ANS_GET_LEN_LOW_LOW PARAM_VALUE.ANS_GET_LEN_LOW_LOW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_GET_LEN_LOW_LOW}] ${MODELPARAM_VALUE.ANS_GET_LEN_LOW_LOW}
}

proc update_MODELPARAM_VALUE.ANS_ANSWER { MODELPARAM_VALUE.ANS_ANSWER PARAM_VALUE.ANS_ANSWER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ANS_ANSWER}] ${MODELPARAM_VALUE.ANS_ANSWER}
}

proc update_MODELPARAM_VALUE.STX { MODELPARAM_VALUE.STX PARAM_VALUE.STX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STX}] ${MODELPARAM_VALUE.STX}
}

proc update_MODELPARAM_VALUE.DLE { MODELPARAM_VALUE.DLE PARAM_VALUE.DLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DLE}] ${MODELPARAM_VALUE.DLE}
}

proc update_MODELPARAM_VALUE.ETX { MODELPARAM_VALUE.ETX PARAM_VALUE.ETX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ETX}] ${MODELPARAM_VALUE.ETX}
}

proc update_MODELPARAM_VALUE.XDT { MODELPARAM_VALUE.XDT PARAM_VALUE.XDT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.XDT}] ${MODELPARAM_VALUE.XDT}
}

proc update_MODELPARAM_VALUE.MON_RD { MODELPARAM_VALUE.MON_RD PARAM_VALUE.MON_RD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_RD}] ${MODELPARAM_VALUE.MON_RD}
}

proc update_MODELPARAM_VALUE.MON_WR { MODELPARAM_VALUE.MON_WR PARAM_VALUE.MON_WR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_WR}] ${MODELPARAM_VALUE.MON_WR}
}

proc update_MODELPARAM_VALUE.MON_TABS { MODELPARAM_VALUE.MON_TABS PARAM_VALUE.MON_TABS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_TABS}] ${MODELPARAM_VALUE.MON_TABS}
}

proc update_MODELPARAM_VALUE.MON_TABNAMES { MODELPARAM_VALUE.MON_TABNAMES PARAM_VALUE.MON_TABNAMES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_TABNAMES}] ${MODELPARAM_VALUE.MON_TABNAMES}
}

proc update_MODELPARAM_VALUE.MON_TABVALUES { MODELPARAM_VALUE.MON_TABVALUES PARAM_VALUE.MON_TABVALUES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_TABVALUES}] ${MODELPARAM_VALUE.MON_TABVALUES}
}

proc update_MODELPARAM_VALUE.MON_RDUNITS { MODELPARAM_VALUE.MON_RDUNITS PARAM_VALUE.MON_RDUNITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_RDUNITS}] ${MODELPARAM_VALUE.MON_RDUNITS}
}

proc update_MODELPARAM_VALUE.MON_RD_ERRH { MODELPARAM_VALUE.MON_RD_ERRH PARAM_VALUE.MON_RD_ERRH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_RD_ERRH}] ${MODELPARAM_VALUE.MON_RD_ERRH}
}

proc update_MODELPARAM_VALUE.MON_RD_BBX { MODELPARAM_VALUE.MON_RD_BBX PARAM_VALUE.MON_RD_BBX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_RD_BBX}] ${MODELPARAM_VALUE.MON_RD_BBX}
}

proc update_MODELPARAM_VALUE.MON_RD_SPI_RAM { MODELPARAM_VALUE.MON_RD_SPI_RAM PARAM_VALUE.MON_RD_SPI_RAM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_RD_SPI_RAM}] ${MODELPARAM_VALUE.MON_RD_SPI_RAM}
}

proc update_MODELPARAM_VALUE.MON_REBOOT { MODELPARAM_VALUE.MON_REBOOT PARAM_VALUE.MON_REBOOT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_REBOOT}] ${MODELPARAM_VALUE.MON_REBOOT}
}

proc update_MODELPARAM_VALUE.MON_PING { MODELPARAM_VALUE.MON_PING PARAM_VALUE.MON_PING } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MON_PING}] ${MODELPARAM_VALUE.MON_PING}
}

proc update_MODELPARAM_VALUE.TYP_32BIT { MODELPARAM_VALUE.TYP_32BIT PARAM_VALUE.TYP_32BIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_32BIT}] ${MODELPARAM_VALUE.TYP_32BIT}
}

proc update_MODELPARAM_VALUE.TYP_16BIT { MODELPARAM_VALUE.TYP_16BIT PARAM_VALUE.TYP_16BIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_16BIT}] ${MODELPARAM_VALUE.TYP_16BIT}
}

proc update_MODELPARAM_VALUE.TYP_SIGNED { MODELPARAM_VALUE.TYP_SIGNED PARAM_VALUE.TYP_SIGNED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_SIGNED}] ${MODELPARAM_VALUE.TYP_SIGNED}
}

proc update_MODELPARAM_VALUE.TYP_UNSIGNED { MODELPARAM_VALUE.TYP_UNSIGNED PARAM_VALUE.TYP_UNSIGNED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_UNSIGNED}] ${MODELPARAM_VALUE.TYP_UNSIGNED}
}

proc update_MODELPARAM_VALUE.TYP_HEX { MODELPARAM_VALUE.TYP_HEX PARAM_VALUE.TYP_HEX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_HEX}] ${MODELPARAM_VALUE.TYP_HEX}
}

proc update_MODELPARAM_VALUE.TYP_FLOAT { MODELPARAM_VALUE.TYP_FLOAT PARAM_VALUE.TYP_FLOAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_FLOAT}] ${MODELPARAM_VALUE.TYP_FLOAT}
}

proc update_MODELPARAM_VALUE.TYP_ENWR { MODELPARAM_VALUE.TYP_ENWR PARAM_VALUE.TYP_ENWR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TYP_ENWR}] ${MODELPARAM_VALUE.TYP_ENWR}
}

proc update_MODELPARAM_VALUE.BBX_TV_SIGNED { MODELPARAM_VALUE.BBX_TV_SIGNED PARAM_VALUE.BBX_TV_SIGNED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BBX_TV_SIGNED}] ${MODELPARAM_VALUE.BBX_TV_SIGNED}
}

proc update_MODELPARAM_VALUE.BBX_TV_UNSIGNED { MODELPARAM_VALUE.BBX_TV_UNSIGNED PARAM_VALUE.BBX_TV_UNSIGNED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BBX_TV_UNSIGNED}] ${MODELPARAM_VALUE.BBX_TV_UNSIGNED}
}

proc update_MODELPARAM_VALUE.BBX_TV_16BIT { MODELPARAM_VALUE.BBX_TV_16BIT PARAM_VALUE.BBX_TV_16BIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BBX_TV_16BIT}] ${MODELPARAM_VALUE.BBX_TV_16BIT}
}

proc update_MODELPARAM_VALUE.BBX_TV_32BIT { MODELPARAM_VALUE.BBX_TV_32BIT PARAM_VALUE.BBX_TV_32BIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BBX_TV_32BIT}] ${MODELPARAM_VALUE.BBX_TV_32BIT}
}

proc update_MODELPARAM_VALUE.BBX_TV_16B_UPPER { MODELPARAM_VALUE.BBX_TV_16B_UPPER PARAM_VALUE.BBX_TV_16B_UPPER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BBX_TV_16B_UPPER}] ${MODELPARAM_VALUE.BBX_TV_16B_UPPER}
}

proc update_MODELPARAM_VALUE.BBX_TV_FLOAT { MODELPARAM_VALUE.BBX_TV_FLOAT PARAM_VALUE.BBX_TV_FLOAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BBX_TV_FLOAT}] ${MODELPARAM_VALUE.BBX_TV_FLOAT}
}

proc update_MODELPARAM_VALUE.TABTITLE_START_ADDRESS { MODELPARAM_VALUE.TABTITLE_START_ADDRESS PARAM_VALUE.TABTITLE_START_ADDRESS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TABTITLE_START_ADDRESS}] ${MODELPARAM_VALUE.TABTITLE_START_ADDRESS}
}

proc update_MODELPARAM_VALUE.UNITS_START_ADDRESS { MODELPARAM_VALUE.UNITS_START_ADDRESS PARAM_VALUE.UNITS_START_ADDRESS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.UNITS_START_ADDRESS}] ${MODELPARAM_VALUE.UNITS_START_ADDRESS}
}

proc update_MODELPARAM_VALUE.VARS_START_ADDRESS { MODELPARAM_VALUE.VARS_START_ADDRESS PARAM_VALUE.VARS_START_ADDRESS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VARS_START_ADDRESS}] ${MODELPARAM_VALUE.VARS_START_ADDRESS}
}

