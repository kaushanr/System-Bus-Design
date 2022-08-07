`timescale 1ns / 1ps

module Test_Resp_MUX;

	// Inputs
	reg CLK;
	reg RST;
	reg [1:0] HRESP_1;
	reg [1:0] HRESP_2;
	reg [1:0] HRESP_3;
	reg [1:0] SEL;

	// Outputs
	wire [1:0] HRESP;

	// Instantiate the Unit Under Test (UUT)
	Resp_MUX uut (
		.CLK(CLK), 
		.RST(RST), 
		.HRESP(HRESP), 
		.HRESP_1(HRESP_1), 
		.HRESP_2(HRESP_2), 
		.HRESP_3(HRESP_3), 
		.SEL(SEL)
	);
	
	always #12  CLK =  ! CLK;
	
	initial begin
	#500 RST = 1; // Random reset stimuli
	#50 RST = 0;
	end

	initial begin
		// Initialize Inputs
		CLK = 0;
		RST = 0;
		HRESP_1 = 0;
		HRESP_2 = 0;
		HRESP_3 = 0;
		SEL = 0;

		// Wait 100 ns for global reset to finish
		#15;
        
		// Add stimulus here
		
		#200 HRESP_1[1:0] = $random; HRESP_2[1:0] = $random; HRESP_3[1:0] = $random; SEL = 2'b00; RST = 0;
		#200 HRESP_1[1:0] = $random; HRESP_2[1:0] = $random; HRESP_3[1:0] = $random; SEL = 2'b01; RST = 0;
		#200 HRESP_1[1:0] = $random; HRESP_2[1:0] = $random; HRESP_3[1:0] = $random; SEL = 2'b10; RST = 0;
		#200 HRESP_1[1:0] = $random; HRESP_2[1:0] = $random; HRESP_3[1:0] = $random; SEL = 2'b11; RST = 0;
		#200 HRESP_1[1:0] = $random; HRESP_2[1:0] = $random; HRESP_3[1:0] = $random; SEL = 2'b00; RST = 0;

	end
      
endmodule

