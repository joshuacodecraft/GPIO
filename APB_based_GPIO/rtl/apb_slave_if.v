module apb_slave_if(PCLK,
					PRESETn,
					PSEL,
					PENABLE,
					PWRITE,
					PREADY,
					PADDR,
					PWDATA,
					PRDATA,
					IRQ,
					sys_clk,
					sys_rst,
					gpio_we,
					gpio_addr,
					gpio_dat_i,
					gpio_dat_o,
					gpio_inta_o
					);
					
	input PCLK,PRESETn,PSEL,PENABLE,PWRITE;
	input [3:0]PADDR;
	input [31:0]PWDATA;
	output PREADY;
	output IRQ;
	output [31:0]PRDATA;
	
	input gpio_inta_o;
	input [31:0]gpio_dat_o;
	output sys_clk,sys_rst;
	output gpio_we;
	output [3:0]gpio_addr;
	output [31:0]gpio_dat_i;
	
	reg [1:0]prs,nxt;
	
	parameter idle=2'b00,
			  setup=2'b01,
			  access=2'b10;

	assign sys_clk=PCLK;
	assign sys_rst=PRESETn;
	assign IRQ=gpio_inta_o;
	assign gpio_addr=PADDR;
	assign gpio_we=PENABLE?PWRITE:1'b0;
	
	
	always@(posedge PCLK or negedge PRESETn)
		begin
			if(!PRESETn)
				prs<=idle;
			else
				prs<=nxt;
		end
	
	
	always@(*)
		begin
			case(prs)
				idle:
					if(PSEL==1'b1 && PENABLE==1'b0)
						nxt=setup;
					else
						nxt=idle;
				
				setup:
					if(PSEL==1'b1 && PENABLE==1'b1)
						nxt=access;
					else if(PSEL==1'b1 && PENABLE==1'b0)
						nxt=setup;
					else
						nxt=idle;
				
				access:
					if(PSEL==1'b1)
						nxt=setup;
					else
						nxt=idle;
				default:
					nxt=idle;
					
			endcase
		end
		
	/*
	always@(*)
		begin
			if(PWRITE==1'b1 && prs==access)
				begin
					gpio_we=1'b1;
					PRDATA=1'b1;
					gpio_dat_i=PWDATA;
				end
			
			else if(PWRITE==1'b0 && prs==access)
				begin
					gpio_we=1'b0;
					gpio_dat_i=1'b0;
					PRDATA=gpio_dat_o;
				end
			
				else
					begin
						gpio_we=1'b0;
						gpio_dat_i=1'b0;
						PRDATA=1'b0;
					end
		end
		
	assign temp=(prs==access)?1'b1:1'b0;
	
	always@(posedge PCLK or negedge PRESETn)
		begin
			if(!PRESETn)
				PREADY<=1'b0;
			else
				PREADY<=temp;
		end
		*/
		
	assign gpio_dat_i=(PWRITE==1'b1 && PENABLE)?PWDATA:gpio_dat_i;
	assign PRDATA=(PWRITE==1'b0 && PENABLE)?gpio_dat_o:32'h0;
	assign PREADY=(prs==access)?1'b1:1'b0;
		
endmodule							