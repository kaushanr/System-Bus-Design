`timescale 1ns / 1ps

module Test_Addr_MUX;

	// Inputs
	reg CLK;
	reg RST;
	reg [15:0] HADDR_1;
	reg [15:0] HADDR_2;
	reg [1:0] SEL;

	// Outputs
	wire [15:0] HADDR;

	// Instantiate the Unit Under Test (UUT)
	Addr_MUX uut (
		.CLK(CLK), 
		.RST(RST), 
		.HADDR(HADDR), 
		.HADDR_1(HADDR_1), 
		.HADDR_2(HADDR_2), 
		.SEL(SEL)
	);
	
	always #15  CLK =  ! CLK;
	
	initial begin
	#500 RST = 1; // Random reset stimuli
	#50 RST = 0;
	end
	
	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
		HADDR_1 = 0;
		HADDR_2 = 0;
		SEL = 0;

		// Wait 100 ns for global reset to finish
		#15;
        
		// Add stimulus here
		
		#200 HADDR_1[15:0] = $random; HADDR_2[15:0] = $random; SEL = 2'b00; RST = 0; // no master selected
		#200 HADDR_1[15:0] = $random; HADDR_2[15:0] = $random; SEL = 2'b01; RST = 0; // master 1
		#200 HADDR_1[15:0] = $random; HADDR_2[15:0] = $random; SEL = 2'b10; RST = 0; // master 2
		#200 HADDR_1[15:0] = $random; HADDR_2[15:0] = $random; SEL = 2'b01; RST = 0; // master 1
		#200 HADDR_1[15:0] = $random; HADDR_2[15:0] = $random; SEL = 2'b11; RST = 0; // no master selected

	end
      
endmodule

