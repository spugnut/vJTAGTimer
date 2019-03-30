##############################################################################################
############################# Basic vJTAG Interface ##########################################
##############################################################################################
 
#This portion of the script is derived from some of the examples from Altera, and from the 
#rather nice writeup by Chris on the DE0 at http://idlelogiclabs.com
#http://idlelogiclabs.com/2012/04/15/talking-to-the-de0-nano-using-the-virtual-jtag-interface/
 
global usbblaster_name
global test_device

# List all available programming hardwares, and select the USBBlaster.
# (Note: this example assumes only one USBBlaster connected.)
# Programming Hardwares:
foreach hardware_name [get_hardware_names] {
#   puts $hardware_name
    if { [string match "USB-Blaster*" $hardware_name] } {
        set usbblaster_name $hardware_name
    }
}
 
puts "Using JTAG chain from $usbblaster_name.";
 
foreach device_name [get_device_names -hardware_name $usbblaster_name] {
    if { [string match "@1*" $device_name] } {
        set test_device $device_name
    }
}
puts "Connecting to FPGA JTAG fabric: $test_device.\n";
 
proc openport {} {
    global usbblaster_name
        global test_device
    open_device -hardware_name $usbblaster_name -device_name $test_device
}
 
proc closeport { } {
    catch {device_unlock}
    catch {close_device}
}

proc userinput {} {
    openport
    device_lock -timeout 10000
	help
    while {1 == 1} {	
	puts -nonewline "\n> "
		set cmd [string toupper [gets stdin]]
		set items [split $cmd " "]
		switch [lindex $items 0] {
			PAUSE {
				pause
			}
			RUN {
				run
			}
			TOGGLE {
				toggle
			}
			RESET {
				reset
			}
			GET {
				get
			}
			SET {
				setval [lindex $items 1]
			}
			HELP {
				help
			}
			QUIT {
				puts "Ok. Daisy, Daisy....."
				break
			}
			default {				
				puts "Talk sense man - or I'll set Crem on you."
			}
		}			
	}
    closeport
}

proc help {} {
	puts "***************************"
	puts "Counter control script v1.0"
	puts "Valid commands:"
	puts "    SET \[number\]"
	puts "    PAUSE"
	puts "    RUN"
	puts "    TOGGLE"
	puts "    GET"
	puts "    RESET"
	puts "    HELP"
	puts "    QUIT"
	puts "***************************"
}

proc run {} {
	puts "Running"
	device_virtual_ir_shift -instance_index 0 -ir_value 4 -no_captured_ir_value
	device_virtual_dr_shift -instance_index 0 -length 6 -dr_value 000000 
}

proc reset {} {
	puts "Resetting counter"
	device_virtual_ir_shift -instance_index 0 -ir_value 2 -no_captured_ir_value
	device_virtual_dr_shift -instance_index 0 -length 6 -dr_value 000000 
}

proc setval number {
	puts "Setting counter"
	device_virtual_dr_shift -instance_index 0 -length 6 -dr_value [dec2bin $number 6]
	device_virtual_ir_shift -instance_index 0 -ir_value 1 -no_captured_ir_value	
	device_virtual_dr_shift -instance_index 0 -length 6 -dr_value [dec2bin $number 6]
}

proc pause {} {
	puts "Pausing counter"
	device_virtual_ir_shift -instance_index 0 -ir_value 3 -no_captured_ir_value
	device_virtual_dr_shift -instance_index 0 -length 6 -dr_value 000000 
}

proc toggle {} {
	puts "Toggling direction"
	device_virtual_ir_shift -instance_index 0 -ir_value 7 -no_captured_ir_value
	device_virtual_dr_shift -instance_index 0 -length 6 -dr_value 000000 
}

proc get {} {
	puts "Getting seconds register"
	device_virtual_ir_shift -instance_index 0 -ir_value 5 -no_captured_ir_value
	set tdi [device_virtual_dr_shift -instance_index 0 -length 6 -dr_value 000000]
	puts "Seconds: $tdi"
}

proc dec2bin {i {width {}}} {
    #returns the binary representation of $i
    # width determines the length of the returned string (left truncated or added left 0)
    # use of width allows concatenation of bits sub-fields

    set res {}
    if {$i<0} {
        set sign -
        set i [expr {abs($i)}]
    } else {
        set sign {}
    }
    while {$i>0} {
        set res [expr {$i%2}]$res
        set i [expr {$i/2}]
    }
    if {$res eq {}} {set res 0}

    if {$width ne {}} {
        append d [string repeat 0 $width] $res
        set res [string range $d [string length $res] end]
    }
    return $sign$res
}

proc bin2dec bin {
    if {$bin == 0} {
        return 0
    } elseif {[string match -* $bin]} {
        set sign -
        set bin [string range $bin[set bin {}] 1 end]
    } else {
        set sign {}
    }
    return $sign[expr 0b$bin]
}

userinput