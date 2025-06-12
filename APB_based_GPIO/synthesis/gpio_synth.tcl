remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog {../rtl/io_if.v} 

elaborate io_if

link 

check_design

current_design  io_if

#compile_ultra

compile_ultra -no_autoungroup

write_file -f verilog -hier -output io_if_netlist.v


 

