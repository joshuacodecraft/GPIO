module aux_tb();
	reg sys_clk,sys_rst;
	reg [31:0]auxin;
	wire [31:0]aux_i;
	
	aux_if a1(sys_clk,sys_rst,auxin,aux_i);
	
	initial
		begin
			sys_clk=1'b0;
			forever #5 sys_clk=~sys_clk;
		end
		
		
	task in(input [31:0]in);
		begin
				auxin<=in;
		end
	endtask
	
	initial
		begin
			@(negedge sys_clk);
			sys_rst=1'b1;
			#10;
			@(negedge sys_clk);
			sys_rst=1'b0;
			#10;
			@(negedge sys_clk);
			in(32'h0000_0000);
			#20;
			in(32'hFFFF_FFFF);
			#20;
			in(32'h0000_0000);
			#20;
			@(negedge sys_clk);
			sys_rst=1'b1;
			
			$finish;
		end
	initial 
		$monitor("auxin:%h, aux_i:%h",auxin,aux_i);
		
	
endmodule