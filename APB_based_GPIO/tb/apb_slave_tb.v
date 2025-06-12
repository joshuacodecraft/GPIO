module apb_slave_tb();
					
	reg PCLK,PRESETn,PSEL,PENABLE,PWRITE;
	reg [3:0]PADDR;
	reg [31:0]PWDATA;
	wire PREADY;
	wire IRQ;
	wire [31:0]PRDATA;
	
	reg gpio_inta_o;
	reg [31:0]gpio_dat_o;
	wire sys_clk,sys_rst;
	wire gpio_we;
	wire [3:0]gpio_addr;
	wire [31:0]gpio_dat_i;
	
	apb_slave_if s1(PCLK,
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
					gpio_inta_o);
	
	
	initial
		begin
			PCLK=1'b0;
			forever #5 PCLK=~PCLK;
		end
			
	
	task initialize();
		begin				
			PRESETn=1'b0;
			PSEL=1'b0;
			PENABLE=1'b0;
			PWRITE=1'b0;
			PADDR=4'h0;
			PWDATA=32'h0000_0000;
			gpio_dat_o=32'h0000_0000;
			gpio_inta_o=1'b0;
			@(posedge PCLK);
			@(posedge PCLK);
			
			#20;
			PRESETn=1'b1;

		end
	endtask
			
	task write(input [3:0]addr, input [31:0]data);
		begin
			@(posedge PCLK);
				PADDR=addr;
				PWDATA=data;
				PWRITE=1'b1;				
				PSEL=1'b1;
				PENABLE=1'b0;
				
			@(posedge PCLK);
				PENABLE=1'b1;
				
			wait (PREADY==1);
			
			@(posedge PCLK);
				PWRITE=1'b0;				
				PSEL=1'b0;
				PENABLE=1'b0;
		end
	endtask
	
	
	task read(input [3:0]addr);
		begin
			@(posedge PCLK);
				PADDR=addr;
				PWRITE=1'b0;				
				PSEL=1'b1;
				PENABLE=1'b0;
				
			@(posedge PCLK);
				PENABLE=1'b1;
				
			wait (PREADY==1);
			
			@(posedge PCLK);
				$display("Read PRDATA = %h",PRDATA); 
				PSEL=1'b0;
				PENABLE=1'b0;
		end
	endtask
	
	initial 
		begin
			initialize;
			#20;
			write(4'h0,32'hABCD_1234);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h1,32'h1234_5678);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h2,32'hCAFE_BD08);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h3,32'hFFFF_FFFF);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			
			write(4'h4,32'h0000_0000);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h5,32'hABCD_1234);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h6,32'h1234_5678);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h7,32'hCAFE_BD08);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'h8,32'hFFFF_FFFF);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			
			write(4'h9,32'h0000_0000);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'hA,32'hABCD_1234);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'hB,32'h1234_5678);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'hC,32'hCAFE_BD08);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			write(4'hD,32'hFFFF_FFFF);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			
			write(4'hE,32'h0000_0000);
			$display("WRITE Addr: %0d, gpio_dat_i: 0x%08h", PADDR, gpio_dat_i);
			
			//Simulate gpio_dat_o returning the written values (for readback testing)
			gpio_dat_o = 32'hAAAA_BBBB; read(4'hA);
			gpio_dat_o = 32'h1234_5678; read(4'hB);
			gpio_dat_o = 32'hDEAD_BEEF; read(4'hC);
			gpio_dat_o = 32'hFFFF_FFFF; read(4'h4);
			gpio_dat_o = 32'h0000_0000; read(4'h7);
			
			gpio_inta_o = 1'b1;
			@(posedge PCLK);
			$display("IRQ Test: IRQ = %b", IRQ);
			gpio_inta_o = 1'b0;
			#20;
			$display("Test Complete.");
			
			$finish;

		end
			
		initial 
			begin
				$fsdbDumpvars(0,apb_slave_tb);
			end
		

endmodule