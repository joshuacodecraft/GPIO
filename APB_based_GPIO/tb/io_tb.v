module io_tb();
	
	//properties
	reg ext_clk_pad_i;
	reg [31:0]out_pad_o,oen_padoe_o;
	wire [31:0]io_pad;
	wire gpio_eclk;
	wire [31:0]in_pad_i;
	
	reg [31:0]data;
	
	assign io_pad=(~oen_padoe_o)?data:32'hZZZZ_ZZZZ;
	
	io_if i1(out_pad_o,oen_padoe_o,in_pad_i,gpio_eclk,io_pad,ext_clk_pad_i);
	
	/*initial
		begin
			ext_clk_pad_i=1'b0;
			forever #5 ext_clk_pad_i=~ext_clk_pad_i;
		end*/
	
	task initialize();
		begin
			out_pad_o=32'b0000_0000;
			oen_padoe_o=32'b0000_0000;
			data=32'h0000_0000;
		end
	endtask
	
	
	task out(input [31:0]din);
		begin
			oen_padoe_o=32'hFFFF_FFFF;
			//out_pad_o=32'hABCD_1234;
			out_pad_o=din;
			#10;
			$display("DUT Driving Output:");
			$display("out_pad_o:%d \n io_pad:%d",out_pad_o,io_pad);
		end
	endtask
	
	
	task in(input [31:0]din);
		begin
			oen_padoe_o=32'h0000_0000;
			data=din;
			#10;
			$display("DUT Driving Input:");
			$display("io_pad:%d \n in_pad_i:%d",io_pad,in_pad_i);
		end
	endtask
	
	initial 
		begin
			initialize;
			#10;
			out(32'hABCD_1234);
			in(32'hFFFF_FFFF);
			
			#10;
			out(32'hDEAD_BEAD);
			in(32'hA5A5_9C9C);
			
			#10;
			out(32'h5432_9876);
			in(32'hCADE_ACEF);
			#10;
			$finish;
		end
		
endmodule