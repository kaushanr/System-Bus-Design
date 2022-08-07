`timescale 1ns / 1ps

module Test_F_Master;

	// Inputs
	reg CLK;
	reg RST;
	reg HGRANT;
	reg HREADY;
	reg [1:0] HRESP;
	reg [31:0] HRDATA;
	reg U_REQ;
	reg U_LOCK;
	reg U_WRITE;
	reg [11:0] U_ADDR;
	reg [31:0] U_WDATA;
	reg [1:0] U_SLAVE;

	// Outputs
	wire HREQ;
	wire HLOCK;
	wire [15:0] HADDR;
	wire [31:0] HWDATA;
	wire AB;

	// Instantiate the Unit Under Test (UUT)
	Master uut (
		.CLK(CLK), 
		.RST(RST), 
		.HGRANT(HGRANT), 
		.HREADY(HREADY), 
		.HRESP(HRESP), 
		.HRDATA(HRDATA), 
		.HREQ(HREQ), 
		.HLOCK(HLOCK), 
		.HADDR(HADDR), 
		.HWDATA(HWDATA), 
		.AB(AB), 
		.U_REQ(U_REQ), 
		.U_LOCK(U_LOCK), 
		.U_WRITE(U_WRITE), 
		.U_ADDR(U_ADDR), 
		.U_WDATA(U_WDATA), 
		.U_SLAVE(U_SLAVE)
	);
	
	always #10 CLK=~CLK;
	
	initial begin
	#593 RST = 1; // Random reset stimuli
	#40 RST = 0;
	end

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
		HGRANT = 0;
		HREADY = 1'bz;
		HRESP = 0;
		HRDATA = 32'bx;
		U_REQ = 0;
		U_LOCK = 0;
		U_WRITE = 0;
		U_ADDR = 16'bx;
		U_WDATA = 32'bx;
		U_SLAVE = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		#100 U_REQ = 0; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'b0; U_WDATA = 32'bx; U_SLAVE = 2'b00;
				HGRANT = 0; HRESP = 2'b00; HREADY = 1'bz;
		
		// Write
		#100 U_REQ = 1; U_LOCK = 0; U_WRITE = 1; U_ADDR = 12'd3; U_WDATA = $random; U_SLAVE = 2'b01;
				#40 HGRANT = 1; HRESP = 2'b00; #20 HREADY = 1;
				
		#40 U_REQ = 0; #60 U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'b0; U_SLAVE = 2'b01;
				 HGRANT = 0; HRESP = 2'b00; #40 HREADY = 1'bz;
				 
	   // Write with reset
		#100 U_REQ = 1; U_LOCK = 0; U_WRITE = 1; U_ADDR = 12'd3; U_WDATA = $random; U_SLAVE = 2'b01;
				#100 HGRANT = 1; HRESP = 2'b00; #20 HREADY = 1;
				
		#40 U_REQ = 0; #60 U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'b0; U_SLAVE = 2'b01;
				 HGRANT = 0; HRESP = 2'b00; #40 HREADY = 1'bz;
		
		// Read
		#100 U_REQ = 1; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'd3; U_SLAVE = 2'b01;
				HRESP = 2'b00; #40 HGRANT = 1; #20 HREADY = 1;
				
		#40 U_REQ = 0; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'd3; U_SLAVE = 2'b01;
				HRESP = 2'b00; HRDATA = U_WDATA;
				
		#10 U_REQ = 0; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'd3; U_SLAVE = 2'b01;
				HRESP = 2'b00; HREADY = 1; 
				
		#70 HGRANT = 0; #20 HRDATA = 32'bx; HREADY = 1'bz;

		// Split
		
	/*		// Write
			#100 U_REQ = 1; U_LOCK = 0; U_WRITE = 1; U_ADDR = 12'd3; U_WDATA = $random; U_SLAVE = 2'b01;
					#50 HGRANT = 1; HRESP = 2'b00; #20 HREADY = 1;
					
			#40 U_REQ = 0; #60 U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'b0; U_SLAVE = 2'b01;
					HGRANT = 0; HRESP = 2'b00; #40 HREADY = 1'bz;
			
			// Read
			#100 U_REQ = 1; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'd3; U_SLAVE = 2'b01;
					HRESP = 2'b00; #50 HGRANT = 1; #20 HREADY = 1;
					
				// Split invoked
				
				#20 HREADY = 1; HRESP = 2'b11; HGRANT = 0; #20  U_REQ = 0;
				
				// Split revoked
				
				#250 HREADY = 1; HRESP = 2'b00; HGRANT = 1;
			
			#40 U_REQ = 0; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'd3; U_SLAVE = 2'b01;
					HRESP = 2'b00; HRDATA = U_WDATA;
					
			#10 U_REQ = 0; U_LOCK = 0; U_WRITE = 0; U_ADDR = 12'd3; U_SLAVE = 2'b01;
					HRESP = 2'b00; HREADY = 1; 
					
			#70 HGRANT = 0; #20 HRDATA = 32'bx; HREADY = 1'bz;*/
	end
      
endmodule

