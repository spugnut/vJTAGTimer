## Generated SDC file "Timer_JTAG_MAX.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Thu Nov 08 20:22:48 2018"

##
## DEVICE  "EPM240T100C5"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {sld_hub:auto_hub|alt_sld_fab_with_jtag_input:\instrumentation_fabric_with_node_gen:fabric_gen_new_way:with_jtag_input_gen:instrumentation_fabric|alt_sld_fab:instrumentation_fabric|alt_sld_fab_alt_sld_fab:alt_sld_fab|alt_sld_fab_alt_sld_fab_sldfabric:sldfabric|sld_jtag_hub:\jtag_hub_gen:real_sld_jtag_hub|sld_shadow_jsm:shadow_jsm|state[8]} -period 1.000 -waveform { 0.000 0.500 } [get_registers {sld_hub:auto_hub|alt_sld_fab_with_jtag_input:\instrumentation_fabric_with_node_gen:fabric_gen_new_way:with_jtag_input_gen:instrumentation_fabric|alt_sld_fab:instrumentation_fabric|alt_sld_fab_alt_sld_fab:alt_sld_fab|alt_sld_fab_alt_sld_fab_sldfabric:sldfabric|sld_jtag_hub:\jtag_hub_gen:real_sld_jtag_hub|sld_shadow_jsm:shadow_jsm|state[8]}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

