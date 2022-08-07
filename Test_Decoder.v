/*##########Script Information###############################
  # Purpose: Decoder testbench For System Bus Design   
  # Updated: 07-08-2022                                  
  # Author : Rumesh                                  
  ###########################################################*/
  
`timescale 1ns / 1ps

module Test_Decoder;

	// Inputs
	reg RST;
	reg CLK;
	reg [14:0] HADDR;

	// Outputs
	wire SEL_1;
	wire SEL_2;
	wire SEL_3;
	wire [1:0] SELR;

	// Instantiate the Unit Under Test (UUT)
	Decoder uut (
		.RST(RST), 
		.CLK(CLK), 
		.HADDR(HADDR), 
		.SEL_1(SEL_1), 
		.SEL_2(SEL_2), 
		.SEL_3(SEL_3), 
		.SELR(SELR)
	);
	
	always #15  CLK =  ! CLK;
	
	initial begin
	#500 RST = 1; // Reset test
	#50 RST = 0;
	end

	initial begin
		// Initialize Inputs
		RST = 0;
		CLK = 0;
		HADDR = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#150 HADDR = 15'b000000000000000;RST = 0;
		#150 HADDR = 15'b010000000000000;RST = 0; // Slave 1 select
		#150 HADDR = 15'b100000000000000;RST = 0; // Slave 2 select
		#150 HADDR = 15'b110000000000000;RST = 0; // Slave 3 select
		#150 HADDR = 15'b000000000000000;RST = 0;
		
	end
	
endmodule

