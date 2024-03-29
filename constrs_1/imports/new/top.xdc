#100MHz
set_property PACKAGE_PIN W5 [get_ports sysclk]
set_property IOSTANDARD LVCMOS33 [get_ports sysclk]
create_clock -name clk -period 10.000 [get_ports sysclk]

set_property PACKAGE_PIN T18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN U17 [get_ports button]
set_property IOSTANDARD LVCMOS33 [get_ports button]

#led 0-7
set_property PACKAGE_PIN U16 [get_ports cur_pc[0]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[0]]
set_property PACKAGE_PIN E19 [get_ports cur_pc[1]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[1]]
set_property PACKAGE_PIN U19 [get_ports cur_pc[2]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[2]]
set_property PACKAGE_PIN V19 [get_ports cur_pc[3]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[3]]
set_property PACKAGE_PIN W18 [get_ports cur_pc[4]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[4]]
set_property PACKAGE_PIN U15 [get_ports cur_pc[5]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[5]]
set_property PACKAGE_PIN U14 [get_ports cur_pc[6]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[6]]
set_property PACKAGE_PIN V14 [get_ports cur_pc[7]]
set_property IOSTANDARD LVCMOS33 [get_ports cur_pc[7]]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
#CA->CG
set_property PACKAGE_PIN W7 [get_ports {cat[0]}]
set_property PACKAGE_PIN W6 [get_ports {cat[1]}]
set_property PACKAGE_PIN U8 [get_ports {cat[2]}]
set_property PACKAGE_PIN V8 [get_ports {cat[3]}]
set_property PACKAGE_PIN U5 [get_ports {cat[4]}]
set_property PACKAGE_PIN V5 [get_ports {cat[5]}]
set_property PACKAGE_PIN U7 [get_ports {cat[6]}]
set_property PACKAGE_PIN V7 [get_ports {cat[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cat[0]}]

set_property PACKAGE_PIN V17 [get_ports selreg[0]]
set_property IOSTANDARD LVCMOS33 [get_ports selreg[0]]
set_property PACKAGE_PIN V16 [get_ports selreg[1]]
set_property IOSTANDARD LVCMOS33 [get_ports selreg[1]]
set_property PACKAGE_PIN W16 [get_ports selclk]
set_property IOSTANDARD LVCMOS33 [get_ports selclk]
