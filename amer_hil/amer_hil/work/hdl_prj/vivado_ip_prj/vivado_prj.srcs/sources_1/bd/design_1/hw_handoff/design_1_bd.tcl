
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z010clg400-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CtrlH [ create_bd_port -dir I -from 3 -to 0 CtrlH ]
  set CtrlL [ create_bd_port -dir I -from 3 -to 0 CtrlL ]
  set Fail [ create_bd_port -dir O -from 3 -to 0 Fail ]
  set QEP [ create_bd_port -dir O -from 3 -to 0 QEP ]
  set Status [ create_bd_port -dir O -from 3 -to 0 Status ]
  set ZyboBTN [ create_bd_port -dir I -from 2 -to 0 ZyboBTN ]
  set ZyboLED [ create_bd_port -dir O -from 3 -to 0 ZyboLED ]
  set ZyboSW [ create_bd_port -dir I -from 3 -to 0 ZyboSW ]
  set clk125 [ create_bd_port -dir I -type clk clk125 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {125000000} \
 ] $clk125
  set ioext_spi_clk [ create_bd_port -dir O ioext_spi_clk ]
  set ioext_spi_cs [ create_bd_port -dir O ioext_spi_cs ]
  set ioext_spi_miso [ create_bd_port -dir I ioext_spi_miso ]
  set ioext_spi_mosi [ create_bd_port -dir O ioext_spi_mosi ]
  set reset_btn [ create_bd_port -dir I -type rst reset_btn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset_btn
  set sd [ create_bd_port -dir O -from 3 -to 0 sd ]
  set sd_clk_0 [ create_bd_port -dir O sd_clk_0 ]
  set sd_clk_90 [ create_bd_port -dir O sd_clk_90 ]
  set uart_rx [ create_bd_port -dir I uart_rx ]
  set uart_tx [ create_bd_port -dir O uart_tx ]

  # Create instance: RLUb_HIL_ip_0, and set properties
  set RLUb_HIL_ip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:RLUb_HIL_ip:1.0 RLUb_HIL_ip_0 ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {80.0} \
   CONFIG.CLKOUT1_JITTER {277.027} \
   CONFIG.CLKOUT1_PHASE_ERROR {265.359} \
   CONFIG.CLKOUT1_REQUESTED_DUTY_CYCLE {65.000} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {80.000} \
   CONFIG.CLKOUT1_USED {true} \
   CONFIG.CLKOUT2_JITTER {369.430} \
   CONFIG.CLKOUT2_PHASE_ERROR {265.359} \
   CONFIG.CLKOUT2_REQUESTED_DUTY_CYCLE {50.000} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {20.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {265.121} \
   CONFIG.CLKOUT3_PHASE_ERROR {265.359} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT3_USED {false} \
   CONFIG.CLKOUT4_JITTER {265.121} \
   CONFIG.CLKOUT4_PHASE_ERROR {265.359} \
   CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT4_USED {false} \
   CONFIG.CLKOUT5_JITTER {265.121} \
   CONFIG.CLKOUT5_PHASE_ERROR {265.359} \
   CONFIG.CLKOUT5_USED {false} \
   CONFIG.CLK_OUT1_PORT {clkx4} \
   CONFIG.CLK_OUT2_PORT {clk} \
   CONFIG.CLK_OUT3_PORT {clk_out3} \
   CONFIG.CLK_OUT4_PORT {clk_out4} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {32.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {8.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
   CONFIG.MMCM_CLKOUT0_DUTY_CYCLE {0.650} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {40} \
   CONFIG.MMCM_CLKOUT1_DUTY_CYCLE {0.500} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
   CONFIG.MMCM_CLKOUT3_DIVIDE {1} \
   CONFIG.MMCM_CLKOUT4_DIVIDE {1} \
   CONFIG.MMCM_DIVCLK_DIVIDE {5} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.RESET_PORT {reset} \
   CONFIG.RESET_TYPE {ACTIVE_HIGH} \
 ] $clk_wiz_0

  # Create instance: ioexp_0, and set properties
  set ioexp_0 [ create_bd_cell -type ip -vlnv aut.bme.hu:fiek:ioexp:1.0 ioexp_0 ]

  # Create instance: mon_module_0, and set properties
  set mon_module_0 [ create_bd_cell -type ip -vlnv aut.bme.hu:user:mon_module:1.0 mon_module_0 ]
  set_property -dict [ list \
   CONFIG.baud_rate_step {0x1798} \
 ] $mon_module_0

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]
  set_property -dict [ list \
   CONFIG.C_EXT_RST_WIDTH {4} \
   CONFIG.C_NUM_PERP_ARESETN {1} \
 ] $proc_sys_reset_0

  # Create instance: sd_multiplexer_0, and set properties
  set sd_multiplexer_0 [ create_bd_cell -type ip -vlnv aut.bme.hu:fiek:sd_multiplexer:1.0 sd_multiplexer_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create port connections
  connect_bd_net -net CtrlH_1 [get_bd_ports CtrlH] [get_bd_pins RLUb_HIL_ip_0/CtrlH]
  connect_bd_net -net CtrlL_1 [get_bd_ports CtrlL] [get_bd_pins RLUb_HIL_ip_0/CtrlL]
  connect_bd_net -net RLUb_HIL_ip_0_Data0 [get_bd_pins RLUb_HIL_ip_0/Data0] [get_bd_pins mon_module_0/data0]
  connect_bd_net -net RLUb_HIL_ip_0_Data1 [get_bd_pins RLUb_HIL_ip_0/Data1] [get_bd_pins mon_module_0/data1]
  connect_bd_net -net RLUb_HIL_ip_0_Data2 [get_bd_pins RLUb_HIL_ip_0/Data2] [get_bd_pins mon_module_0/data2]
  connect_bd_net -net RLUb_HIL_ip_0_Data3 [get_bd_pins RLUb_HIL_ip_0/Data3] [get_bd_pins mon_module_0/data3]
  connect_bd_net -net RLUb_HIL_ip_0_Data4 [get_bd_pins RLUb_HIL_ip_0/Data4] [get_bd_pins mon_module_0/data4]
  connect_bd_net -net RLUb_HIL_ip_0_Fail [get_bd_ports Fail] [get_bd_pins RLUb_HIL_ip_0/Fail]
  connect_bd_net -net RLUb_HIL_ip_0_IOextOut [get_bd_pins RLUb_HIL_ip_0/IOextOut] [get_bd_pins ioexp_0/outdata]
  connect_bd_net -net RLUb_HIL_ip_0_QEP [get_bd_ports QEP] [get_bd_pins RLUb_HIL_ip_0/QEP]
  connect_bd_net -net RLUb_HIL_ip_0_SDMuxA [get_bd_pins RLUb_HIL_ip_0/SDMuxA] [get_bd_pins sd_multiplexer_0/sdac_a]
  connect_bd_net -net RLUb_HIL_ip_0_SDMuxB [get_bd_pins RLUb_HIL_ip_0/SDMuxB] [get_bd_pins sd_multiplexer_0/sdac_b]
  connect_bd_net -net RLUb_HIL_ip_0_Status [get_bd_ports Status] [get_bd_pins RLUb_HIL_ip_0/Status]
  connect_bd_net -net RLUb_HIL_ip_0_ZyboLED [get_bd_ports ZyboLED] [get_bd_pins RLUb_HIL_ip_0/ZyboLED]
  connect_bd_net -net ZyboBTN_1 [get_bd_ports ZyboBTN] [get_bd_pins RLUb_HIL_ip_0/ZyboBTN]
  connect_bd_net -net ZyboSW_1 [get_bd_ports ZyboSW] [get_bd_pins RLUb_HIL_ip_0/ZyboSW]
  connect_bd_net -net clk125_1 [get_bd_ports clk125] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk10 [get_bd_pins RLUb_HIL_ip_0/IPCORE_CLK] [get_bd_pins clk_wiz_0/clk] [get_bd_pins ioexp_0/clk] [get_bd_pins mon_module_0/clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins sd_multiplexer_0/clk]
  connect_bd_net -net clk_wiz_0_clkx4 [get_bd_pins clk_wiz_0/clkx4] [get_bd_pins sd_multiplexer_0/clkx4]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net ioexp_0_cs [get_bd_ports ioext_spi_cs] [get_bd_pins ioexp_0/cs]
  connect_bd_net -net ioexp_0_indata [get_bd_pins RLUb_HIL_ip_0/IOextIn] [get_bd_pins ioexp_0/indata]
  connect_bd_net -net ioexp_0_mosi [get_bd_ports ioext_spi_mosi] [get_bd_pins ioexp_0/mosi]
  connect_bd_net -net ioexp_0_sck [get_bd_ports ioext_spi_clk] [get_bd_pins ioexp_0/sck]
  connect_bd_net -net ioext_spi_miso_1 [get_bd_ports ioext_spi_miso] [get_bd_pins ioexp_0/miso]
  connect_bd_net -net mon_module_0_TxD [get_bd_ports uart_tx] [get_bd_pins mon_module_0/TxD]
  connect_bd_net -net mon_module_0_param0 [get_bd_pins RLUb_HIL_ip_0/Param0] [get_bd_pins mon_module_0/param0]
  connect_bd_net -net mon_module_0_param1 [get_bd_pins RLUb_HIL_ip_0/Param1] [get_bd_pins mon_module_0/param1]
  connect_bd_net -net mon_module_0_param2 [get_bd_pins RLUb_HIL_ip_0/Param2] [get_bd_pins mon_module_0/param2]
  connect_bd_net -net mon_module_0_param3 [get_bd_pins RLUb_HIL_ip_0/Param3] [get_bd_pins mon_module_0/param3]
  connect_bd_net -net mon_module_0_param4 [get_bd_pins RLUb_HIL_ip_0/Param4] [get_bd_pins mon_module_0/param4]
  connect_bd_net -net mon_module_0_param5 [get_bd_pins RLUb_HIL_ip_0/Param5] [get_bd_pins mon_module_0/param5]
  connect_bd_net -net mon_module_0_param6 [get_bd_pins RLUb_HIL_ip_0/Param6] [get_bd_pins mon_module_0/param6]
  connect_bd_net -net mon_module_0_param7 [get_bd_pins RLUb_HIL_ip_0/Param7] [get_bd_pins mon_module_0/param7]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins RLUb_HIL_ip_0/IPCORE_RESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins ioexp_0/reset] [get_bd_pins mon_module_0/reset] [get_bd_pins proc_sys_reset_0/peripheral_reset]
  connect_bd_net -net reset_btn_1 [get_bd_ports reset_btn] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net sd_multiplexer_0_sd [get_bd_ports sd] [get_bd_pins sd_multiplexer_0/sd]
  connect_bd_net -net sd_multiplexer_0_sd_clk_0 [get_bd_ports sd_clk_0] [get_bd_pins sd_multiplexer_0/sd_clk_0]
  connect_bd_net -net sd_multiplexer_0_sd_clk_90 [get_bd_ports sd_clk_90] [get_bd_pins sd_multiplexer_0/sd_clk_90]
  connect_bd_net -net uart_rx_1 [get_bd_ports uart_rx] [get_bd_pins mon_module_0/RxD]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins clk_wiz_0/reset] [get_bd_pins xlconstant_0/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


