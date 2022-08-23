# Clock pin
# set_property PACKAGE_PIN E3 [get_ports {clk}]
# set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports { o_led }]; #IO_L24N_T3_35 Sch=led[4]
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { o_led[0] }]; #IO_L24N_T3_35 Sch=led[4]
set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { o_led[1] }]; #IO_25_35 Sch=led[5]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { o_led[2] }]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { o_led[3] }]; #IO_L24N_T3_A00_D16_14 Sch=led[7]
# set_property -dict { PACKAGE_PIN D9 IOSTANDARD LVCMOS33 } [get_ports { i_btn }]; #IO_L6N_T0_VREF_16 Sch=btn[0]
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCMOS33 } [get_ports { i_sw  }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]

set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { o_uart }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { i_uart }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in

# Clock constraints
# create_clock -period 10.0 [get_ports {clk}]
