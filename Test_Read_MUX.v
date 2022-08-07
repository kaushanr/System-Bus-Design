`timescale 1ns / 1ps

module Test_Read_MUX;

	// Inputs
	reg CLK;
	reg RST;
	reg [31:0] HRDATA_1;
	reg [31:0] HRDATA_2;
	reg [31:0] HRDATA_3;
	reg [1:0] SEL;

	// Outputs
	wire [31:0] HRDATA;

	// Instantiate the Unit Under Test (UUT)
	Read_MUX uut (
		.CLK(CLK), 
		.RST(RST), 
		.HRDATA(HRDATA), 
		.HRDATA_1(HRDATA_1), 
		.HRDATA_2(HRDATA_2), 
		.HRDATA_3(HRDATA_3), 
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
		HRDATA_1 = 0;
		HRDATA_2 = 0;
		HRDATA_3 = 0;
		SEL = 0;

		// Wait 100 ns for global reset to finish
		#15;
        
		// Add stimulus here
		
		#200 HRDATA_1 = $random; HRDATA_2 = $random; HRDATA_3 = $random; SEL = 2'b00; RST = 0;
		#200 /*HRDATA_1 = $random; HRDATA_2 = $random; HRDATA_3 = $random;*/ SEL = 2'b01; RST = 0;
		#200 /*HRDATA_1 = $random; HRDATA_2 = $random; HRDATA_3 = $random;*/ SEL = 2'b10; RST = 0;
		#200 /*HRDATA_1 = $random; HRDATA_2 = $random; HRDATA_3 = $random;*/ SEL = 2'b11; RST = 0;
		#200 /*HRDATA_1 = $random; HRDATA_2 = $random; HRDATA_3 = $random;*/ SEL = 2'b00; RST = 0;
		
	end
      
endmodule

