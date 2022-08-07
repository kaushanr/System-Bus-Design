`timescale 1ns / 1ps

module Test_Slave_2K_Split;

	// Inputs
	reg SEL;
	reg [15:0] HADDR;
	reg [31:0] HWDATA;
	reg CLK;
	reg RST;
	reg [1:0] HMAS;
	reg MLOCK;
	reg USPLIT;

	// Outputs
	wire [31:0] HRDATA;
	wire [1:0] HRESP;
	wire HREADY;
	wire [1:0] HSPLIT;
	wire AB;

	// Instantiate the Unit Under Test (UUT)
	Slave_2K_Split uut (
		.SEL(SEL), 
		.HADDR(HADDR), 
		.HWDATA(HWDATA), 
		.HRDATA(HRDATA), 
		.HRESP(HRESP), 
		.CLK(CLK), 
		.HREADY(HREADY), 
		.HSPLIT(HSPLIT), 
		.RST(RST), 
		.HMAS(HMAS), 
		.MLOCK(MLOCK), 
		.USPLIT(USPLIT), 
		.AB(AB)
	);
	always #10 CLK=~CLK;
	
/*	initial begin
	#933 RST = 1; // Random reset stimuli
	#30 RST = 0;
	end
*/
	initial begin
		// Initialize Inputs
		SEL = 0;
		HADDR = 0;
		HWDATA = 0;
		CLK = 0;
		RST = 0;
		HMAS = 0;
		MLOCK = 0;
		USPLIT = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		#200 HADDR = 16'bx ; HWDATA = 32'bx; SEL = 0; HMAS = 2'b0; MLOCK = 0;
		
	/*	// Write
		
		#200 HADDR = 16'b0011000000000011 ; HWDATA = $random; SEL = 1; HMAS = 2'b01; MLOCK = 0;
		
		#20 HADDR = 16'b1011000000000011 ;
		
		#100 HADDR = 16'bx ; HWDATA = 32'bx; #20 SEL = 0; HMAS = 2'b0; MLOCK = 0;
		
		// Write with reset
		
		#200 HADDR = 16'b0011000000000011 ; HWDATA = $random; SEL = 1; HMAS = 2'b01; MLOCK = 0;
		
		#20 HADDR = 16'b1011000000000011 ;
		
		#100 HADDR = 16'bx ; HWDATA = 32'bx; #20 SEL = 0; HMAS = 2'b0; MLOCK = 0;
		
		// Read
		
		#200 HADDR = 16'b0010000000000011 ; SEL = 1; HMAS = 2'b01; MLOCK = 0;
		
		#20 HADDR = 16'b1010000000000011 ;
		
		#100 HADDR = 16'bx ; HWDATA = 32'bx; #20 SEL = 0; HMAS = 2'b0; MLOCK = 0;
	
	*/	// Split
		
			#200 HADDR = 16'bx ; HWDATA = 32'bx; SEL = 0; HMAS = 2'b0; MLOCK = 0;
		
			// Write
			#100 HADDR = 16'b0011000000000011 ; HWDATA = $random; SEL = 1; HMAS = 2'b01; MLOCK = 0;
		
			#20 HADDR = 16'b1011000000000011 ;
			
			#100 HADDR = 16'bx ; HWDATA = 32'bx; #20 SEL = 0; HMAS = 2'b0; MLOCK = 0;
			
			// Read
			#200 HADDR = 16'b0010000000000011 ; SEL = 1; HMAS = 2'b01; MLOCK = 0;
			
			#20 HADDR = 16'b1010000000000011 ; 
			
				// Split invoked
				
				#20 USPLIT = 1; #20 SEL = 0;
				
				// Split revoked
				
				#250 USPLIT = 0; #20 SEL = 1;
			
			#200 HADDR = 16'bx ; HWDATA = 32'bx; SEL = 0; HMAS = 2'b0; MLOCK = 0;
	
	end
      
endmodule

