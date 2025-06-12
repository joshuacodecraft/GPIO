#Liberty files are needed for logical and physical netlist designs
set search_path "./"
set link_library " "

set_app_var enable_lint true

configure_lint_setup -goal lint_rtl
waive_lint -tag " STARC05-2.5.1.2" -add "clock_waive"


analyze -verbose -format verilog "../rtl/io_if.v"

elaborate io_if
check_lint

report_lint -verbose -file io_lint.txt

