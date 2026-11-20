#====================================================
# TRAFFIC SIGNAL CONTROLLER
# NEXYS A7-100T
#====================================================

# 100 MHz Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]

create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


#====================================================
# RESET BUTTON - CENTER BUTTON
#====================================================

set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports reset]


#====================================================
# PEDESTRIAN REQUEST - UP BUTTON
#====================================================

set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports pedestrian_request]


#====================================================
# EMERGENCY - RIGHT BUTTON
#====================================================

set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports emergency]


#====================================================
# ROAD A LIGHTS
#====================================================

# LED0 - Road A RED
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports roadA_red]

# LED1 - Road A YELLOW
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports roadA_yellow]

# LED2 - Road A GREEN
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports roadA_green]


#====================================================
# ROAD B LIGHTS
#====================================================

# LED3 - Road B RED
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports roadB_red]

# LED4 - Road B YELLOW
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports roadB_yellow]

# LED5 - Road B GREEN
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports roadB_green]


#====================================================
# BITSTREAM COMPRESSION
#====================================================

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]