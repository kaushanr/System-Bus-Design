/*##########Script Information###############################
  # Purpose: Arbiter testbench For System Bus Design   
  # Updated: 07-08-2022                                  
  # Author : Rumesh                                  
  ###########################################################*/
  
  `timescale 1ns / 1ps

module Test_Arbiter;

	// Inputs
	reg CLK;
	reg RST;
	reg HREQ_1;
	reg HLOCK_1;
	reg HREQ_2;
	reg HLOCK_2;
	reg [1:0] HSPLIT;
	reg [1:0] HRESP;

	// Outputs
	wire HGRANT_1;
	wire HGRANT_2;
	wire [1:0] HMAS;
	wire MLOCK;
	wire [1:0] SEL;
	wire AB;

	// Instantiate the Unit Under Test (UUT)
	Arbiter uut (
		.CLK(CLK), 
		.RST(RST), 
		.HREQ_1(HREQ_1), 
		.HLOCK_1(HLOCK_1), 
		.HREQ_2(HREQ_2), 
		.HLOCK_2(HLOCK_2), 
		.HSPLIT(HSPLIT), 
		.HRESP(HRESP), 
		.HGRANT_1(HGRANT_1), 
		.HGRANT_2(HGRANT_2), 
		.HMAS(HMAS), 
		.MLOCK(MLOCK), 
		.SEL(SEL), 
		.AB(AB),
		.HREADY(HREADY)
	);
	
	always #15 CLK = !CLK;
	 
	initial begin
	#400 RST = 1;
	#50  RST = 0;  
	end

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
   
		// Wait 100 ns for global reset to finish
		
      #100 HREQ_1 <= 1; HREQ_2 <= 0; HRESP <= 0; HSPLIT <= 0;HLOCK_1 <= 0;HLOCK_2 <= 0; // Master 1 request
		
		#100 HREQ_1 <= 0; HREQ_2 <= 0; HRESP <= 2'b01; HSPLIT <= 0;HLOCK_1 <= 0;HLOCK_2 <= 0; 
		
		#100 HREQ_1 <= 1; HREQ_2 <= 1; HRESP <= 0; HSPLIT <= 0;HLOCK_1 <= 0;HLOCK_2 <= 0; // Master 1 & 2 request
		
		#200 HREQ_1 <= 0; HREQ_2 <= 0; HRESP <= 2'b01; HSPLIT <= 0;HLOCK_1 <= 0;HLOCK_2 <= 0; 
		
		#100 HREQ_1 <= 1; HREQ_2 <= 1; HRESP <= 0; HSPLIT <= 0;HLOCK_1 <= 1;HLOCK_2 <= 0; // Master 1 priority request
		
		#100 HREQ_1 <= 0; HREQ_2 <= 0; HRESP <= 2'b01; HSPLIT <= 0;HLOCK_1 <= 0;HLOCK_2 <= 0;

	end
      
endmodule

