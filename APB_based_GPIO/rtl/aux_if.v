module aux_if(sys_clk,sys_rst,auxin,aux_i);
	input sys_clk,sys_rst;
	input [31:0]auxin;
	output reg [31:0]aux_i;
	
	always@(posedge sys_clk)
		begin
			if(sys_rst)
				aux_i<=32'b0;
			else
				aux_i<=auxin;
		end
	
endmodule