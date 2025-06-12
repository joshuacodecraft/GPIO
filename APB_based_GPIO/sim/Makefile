# Makefile for Router UVM Project
RTL = ../rtl/*
INC = +incdir+../rtl +incdir+../tb 
TB = ../tb/apb_slv_if_tb.sv
work = work #library name

FSDB_PATH = /home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


# Make targets for SV compilation using VCS
sv_cmp:
	vcs -l vcs.log -timescale=1ns/1ps -assert svaext -cm line+tgl+fsm+branch+cond -sverilog +v2k -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(TB) $(SVTB1)


# Make targets for running each testcases
run_test_apb_slv: clean
	vcs -l vcs.log -timescale=1ns/1ps -assert svaext -lca -cm line+tgl+fsm+branch+cond -sverilog +v2k -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a ../rtl/apb_slave_if.v $(INC) ../tb/apb_slave_tb.v
	./simv -a vcs.log +fsdbfile+apb_slv_wave.fsdb -cm line+tgl+fsm+branch+cond -cm_dir ./apb_slv_cov.vdb +ntb_random_seed_automatic
	urg -dir simv.vdb -dir ./apb_slv_cov.vdb -format both -report urgReportapb_slv

run_test_aux: clean
	vcs -l vcs.log -timescale=1ns/1ps -assert svaext -lca -cm line+tgl+fsm+branch+cond -sverilog +v2k -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a ../rtl/aux_if.v $(INC) ../tb/aux_tb.v
	./simv -a vcs.log +fsdbfile+aux_wave.fsdb -cm line+tgl+fsm+branch+cond -cm_dir ./aux_cov.vdb +ntb_random_seed_automatic
	urg -dir simv.vdb -dir ./aux_cov.vdb -format both -report urgReportaux
	
run_test_io: clean
	vcs -l vcs.log -timescale=1ns/1ps -assert svaext -lca -cm line+tgl+fsm+branch+cond -sverilog +v2k -full64 -kdb -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a ../rtl/io_if.v $(INC) ../tb/io_tb.v
	./simv -a vcs.log +fsdbfile+io_wave.fsdb -cm line+tgl+fsm+branch+cond -cm_dir ./io_cov.vdb +ntb_random_seed_automatic
	urg -dir simv.vdb -dir ./io_cov.vdb -format both -report urgReportio

view_wave_apb:
	verdi -ssf apb_slv_wave.fsdb

view_wave_aux:
	verdi -ssf aux_wave.fsdb

view_wave_io:
	verdi -ssf io_wave.fsdb

view_cov_apb_slv:
	verdi -cov -covdir simv.vdb -covdir apb_slv_cov.vdb

view_cov_aux:
	verdi -cov -covdir simv.vdb -covdir aux_cov.vdb

view_cov_io:
	verdi -cov -covdir simv.vdb -covdir io_cov.vdb

clean:
	rm -fr alib-52/ default.svf filenames* command.log  io_if_synth.log timing_report.txt *.vdb *.fsdb *.log *.txt csrc/ *.conf *.rc simv* Synopsys* *.key urgReport* *.h verdi* vdCovLog

#synth_io:
#	dc_shell -f io_synth.tcl

#ynth_apb:
#	dc_shell -f apb_synth.tcl

#synth_aux:
#	dc_shell -f aux_synth.tcl
