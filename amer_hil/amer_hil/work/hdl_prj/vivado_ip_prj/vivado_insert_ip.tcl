open_project vivado_prj.xpr
update_ip_catalog -delete_ip {./ipcore/RLUb_HIL_ip_v1_0/component.xml} -repo_path {./ipcore} -quiet
update_ip_catalog -add_ip {./ipcore/RLUb_HIL_ip_v1_0.zip} -repo_path {./ipcore}
update_ip_catalog
set HDLCODERIPVLNV [get_property VLNV [get_ipdefs -filter {NAME==RLUb_HIL_ip && VERSION==1.0}]]
set HDLCODERIPINST RLUb_HIL_ip_0
set BDFILEPATH [get_files -quiet design_1.bd]
open_bd_design $BDFILEPATH
create_bd_cell -type ip -vlnv $HDLCODERIPVLNV $HDLCODERIPINST
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins ioexp_0/outdata]] [get_bd_pins $HDLCODERIPINST/IOextOut] [get_bd_pins ioexp_0/outdata]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins ioexp_0/indata]] [get_bd_pins $HDLCODERIPINST/IOextIn] [get_bd_pins ioexp_0/indata]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins sd_multiplexer_0/sdac_a]] [get_bd_pins $HDLCODERIPINST/SDMuxA] [get_bd_pins sd_multiplexer_0/sdac_a]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins sd_multiplexer_0/sdac_b]] [get_bd_pins $HDLCODERIPINST/SDMuxB] [get_bd_pins sd_multiplexer_0/sdac_b]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/data0]] [get_bd_pins $HDLCODERIPINST/Data0] [get_bd_pins mon_module_0/data0]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/data1]] [get_bd_pins $HDLCODERIPINST/Data1] [get_bd_pins mon_module_0/data1]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/data2]] [get_bd_pins $HDLCODERIPINST/Data2] [get_bd_pins mon_module_0/data2]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/data3]] [get_bd_pins $HDLCODERIPINST/Data3] [get_bd_pins mon_module_0/data3]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/data4]] [get_bd_pins $HDLCODERIPINST/Data4] [get_bd_pins mon_module_0/data4]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param0]] [get_bd_pins $HDLCODERIPINST/Param0] [get_bd_pins mon_module_0/param0]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param1]] [get_bd_pins $HDLCODERIPINST/Param1] [get_bd_pins mon_module_0/param1]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param2]] [get_bd_pins $HDLCODERIPINST/Param2] [get_bd_pins mon_module_0/param2]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param3]] [get_bd_pins $HDLCODERIPINST/Param3] [get_bd_pins mon_module_0/param3]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param4]] [get_bd_pins $HDLCODERIPINST/Param4] [get_bd_pins mon_module_0/param4]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param5]] [get_bd_pins $HDLCODERIPINST/Param5] [get_bd_pins mon_module_0/param5]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param6]] [get_bd_pins $HDLCODERIPINST/Param6] [get_bd_pins mon_module_0/param6]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins mon_module_0/param7]] [get_bd_pins $HDLCODERIPINST/Param7] [get_bd_pins mon_module_0/param7]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins clk_wiz_0/clk]] [get_bd_pins $HDLCODERIPINST/IPCORE_CLK] [get_bd_pins clk_wiz_0/clk]
connect_bd_net -net [get_bd_nets -of_objects [get_bd_pins proc_sys_reset_0/peripheral_aresetn]] [get_bd_pins $HDLCODERIPINST/IPCORE_RESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
create_bd_port -dir O -from 3 -to 0 QEP
connect_bd_net [get_bd_ports QEP] [get_bd_pins $HDLCODERIPINST/QEP]
create_bd_port -dir O -from 3 -to 0 Fail
connect_bd_net [get_bd_ports Fail] [get_bd_pins $HDLCODERIPINST/Fail]
create_bd_port -dir I -from 3 -to 0 CtrlH
connect_bd_net [get_bd_ports CtrlH] [get_bd_pins $HDLCODERIPINST/CtrlH]
create_bd_port -dir I -from 3 -to 0 CtrlL
connect_bd_net [get_bd_ports CtrlL] [get_bd_pins $HDLCODERIPINST/CtrlL]
create_bd_port -dir O -from 3 -to 0 Status
connect_bd_net [get_bd_ports Status] [get_bd_pins $HDLCODERIPINST/Status]
create_bd_port -dir I -from 2 -to 0 ZyboBTN
connect_bd_net [get_bd_ports ZyboBTN] [get_bd_pins $HDLCODERIPINST/ZyboBTN]
create_bd_port -dir I -from 3 -to 0 ZyboSW
connect_bd_net [get_bd_ports ZyboSW] [get_bd_pins $HDLCODERIPINST/ZyboSW]
create_bd_port -dir O -from 3 -to 0 ZyboLED
connect_bd_net [get_bd_ports ZyboLED] [get_bd_pins $HDLCODERIPINST/ZyboLED]
make_wrapper -files $BDFILEPATH -top
regsub -all "design_1.bd" [get_files design_1.bd] "hdl" TOPFILEPATH
add_files -norecurse $TOPFILEPATH
update_compile_order -fileset sources_1
validate_bd_design
save_bd_design
add_files -fileset constrs_1 -norecurse amer_top_constraint.xdc RLUb_HIL_ip_src_RLUb_HIL_top.xdc
close_project
exit
