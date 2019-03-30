# Copyright (C) 2017  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: Timer.tcl
# Generated on: Mon Oct 15 13:36:55 2018

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "Timer"]} {
		puts "Project Timer is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists Timer]} {
		project_open -revision Timer Timer
	} else {
		project_new -revision Timer Timer
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "MAX II"
	set_global_assignment -name DEVICE EPM240T100C5
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 17.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "13:58:26  MARCH 22, 2018"
	set_global_assignment -name LAST_QUARTUS_VERSION "17.1.0 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR "-1"
	set_global_assignment -name POWER_EXT_SUPPLY_VOLTAGE_TO_REGULATOR 3.3V
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name SYSTEMVERILOG_FILE Timer.sv
	set_global_assignment -name SYSTEMVERILOG_FILE Seg7Encoder.sv
	set_location_assignment PIN_100 -to display1[0]
	set_location_assignment PIN_99 -to display1[1]
	set_location_assignment PIN_98 -to display1[2]
	set_location_assignment PIN_97 -to display1[3]
	set_location_assignment PIN_96 -to display1[4]
	set_location_assignment PIN_95 -to display1[5]
	set_location_assignment PIN_92 -to display1[6]
	set_location_assignment PIN_91 -to display1[7]
	set_location_assignment PIN_75 -to display2[0]
	set_location_assignment PIN_74 -to display2[1]
	set_location_assignment PIN_73 -to display2[2]
	set_location_assignment PIN_72 -to display2[3]
	set_location_assignment PIN_71 -to display2[4]
	set_location_assignment PIN_70 -to display2[5]
	set_location_assignment PIN_69 -to display2[6]
	set_location_assignment PIN_68 -to display2[7]
	set_location_assignment PIN_12 -to clk

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
