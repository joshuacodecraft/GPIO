module io_if(out_pad_o,oen_padoe_o,in_pad_i,gpio_eclk,io_pad,ext_clk_pad_i);
	
	//properties
	input ext_clk_pad_i;
	input [31:0]out_pad_o,oen_padoe_o;
	inout [31:0]io_pad;
	output gpio_eclk;
	output [31:0]in_pad_i;
	
	
	//assigning external clk as eclk
	assign gpio_eclk=ext_clk_pad_i;
	
	//io acting as input
	bufif1 b0(io_pad[0],out_pad_o[0],oen_padoe_o[0]);
	bufif1 b1(io_pad[1],out_pad_o[1],oen_padoe_o[1]);
	bufif1 b2(io_pad[2],out_pad_o[2],oen_padoe_o[2]);
	bufif1 b3(io_pad[3],out_pad_o[3],oen_padoe_o[3]);
	bufif1 b4(io_pad[4],out_pad_o[4],oen_padoe_o[4]);
	bufif1 b5(io_pad[5],out_pad_o[5],oen_padoe_o[5]);
	bufif1 b6(io_pad[6],out_pad_o[6],oen_padoe_o[6]);
	bufif1 b7(io_pad[7],out_pad_o[7],oen_padoe_o[7]);
	bufif1 b8(io_pad[8],out_pad_o[8],oen_padoe_o[8]);
	bufif1 b9(io_pad[9],out_pad_o[9],oen_padoe_o[9]);
	bufif1 b10(io_pad[10],out_pad_o[10],oen_padoe_o[10]);
	bufif1 b11(io_pad[11],out_pad_o[11],oen_padoe_o[11]);
	bufif1 b12(io_pad[12],out_pad_o[12],oen_padoe_o[12]);
	bufif1 b13(io_pad[13],out_pad_o[13],oen_padoe_o[13]);
	bufif1 b14(io_pad[14],out_pad_o[14],oen_padoe_o[14]);
	bufif1 b15(io_pad[15],out_pad_o[15],oen_padoe_o[15]);
	bufif1 b16(io_pad[16],out_pad_o[16],oen_padoe_o[16]);
	bufif1 b17(io_pad[17],out_pad_o[17],oen_padoe_o[17]);
	bufif1 b18(io_pad[18],out_pad_o[18],oen_padoe_o[18]);
	bufif1 b19(io_pad[19],out_pad_o[19],oen_padoe_o[19]);
	bufif1 b20(io_pad[20],out_pad_o[20],oen_padoe_o[20]);
	bufif1 b21(io_pad[21],out_pad_o[21],oen_padoe_o[21]);
	bufif1 b22(io_pad[22],out_pad_o[22],oen_padoe_o[22]);
	bufif1 b23(io_pad[23],out_pad_o[23],oen_padoe_o[23]);
	bufif1 b24(io_pad[24],out_pad_o[24],oen_padoe_o[24]);
	bufif1 b25(io_pad[25],out_pad_o[25],oen_padoe_o[25]);
	bufif1 b26(io_pad[26],out_pad_o[26],oen_padoe_o[26]);
	bufif1 b27(io_pad[27],out_pad_o[27],oen_padoe_o[27]);
	bufif1 b28(io_pad[28],out_pad_o[28],oen_padoe_o[28]);
	bufif1 b29(io_pad[29],out_pad_o[29],oen_padoe_o[29]);
	bufif1 b30(io_pad[30],out_pad_o[30],oen_padoe_o[30]);
	bufif1 b31(io_pad[31],out_pad_o[31],oen_padoe_o[31]);
	
	//io_pad acting as output
	assign in_pad_i=io_pad;
	
endmodule