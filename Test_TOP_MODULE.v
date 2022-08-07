`timescale 1ns / 1ps

module Test_TOP_MODULE;

	// Inputs
	reg RST;
	reg CLK;
	reg U1_REQ;
	reg U1_LOCK;
	reg U1_WRITE;
	reg [11:0] U1_ADDR;
	reg [31:0] U1_WDATA;
	reg [1:0] U1_SLAVE;
	reg U2_REQ;
	reg U2_LOCK;
	reg U2_WRITE;
	reg [11:0] U2_ADDR;
	reg [31:0] U2_WDATA;
	reg [1:0] U2_SLAVE;
	reg U_SPLIT;

	// Outputs
	wire AB;

	// Instantiate the Unit Under Test (UUT)
	TOP_MODULE uut (
		.RST(RST), 
		.CLK(CLK), 
		.U1_REQ(U1_REQ), 
		.U1_LOCK(U1_LOCK), 
		.U1_WRITE(U1_WRITE), 
		.U1_ADDR(U1_ADDR), 
		.U1_WDATA(U1_WDATA), 
		.U1_SLAVE(U1_SLAVE), 
		.U2_REQ(U2_REQ), 
		.U2_LOCK(U2_LOCK), 
		.U2_WRITE(U2_WRITE), 
		.U2_ADDR(U2_ADDR), 
		.U2_WDATA(U2_WDATA), 
		.U2_SLAVE(U2_SLAVE), 
		.U_SPLIT(U_SPLIT), 
		.AB(AB)
	);
	
	always #10 CLK=~CLK;
/*	
	initial begin
	#1200 RST = 1; // Random reset stimuli
	#40 RST = 0;
	end
*/

	initial begin
		// Initialize Inputs
		RST = 0;
		CLK = 0;
		U1_REQ = 0;
		U1_LOCK = 0;
		U1_WRITE = 0;
		U1_ADDR = 0;
		U1_WDATA = 0;
		U1_SLAVE = 0;
		U2_REQ = 0;
		U2_LOCK = 0;
		U2_WRITE = 0;
		U2_ADDR = 0;
		U2_WDATA = 0;
		U2_SLAVE = 0;
		U_SPLIT = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		//#200;
		
//---One Master Request with Write/Read-------
	
	/*	// WRITE from Master 1 to Slave 1
		#200 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'b0; U1_WDATA = 32'b0; U1_SLAVE = 2'b00;
		
		#100 U1_REQ = 1; U1_LOCK = 0; U1_WRITE = 1; U1_ADDR = 12'd4; U1_WDATA = $random; U1_SLAVE = 2'b01;
		
		#100 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 1; U1_ADDR = 12'd4; U1_SLAVE = 2'b01;
			
		#200 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd0; U1_WDATA = 32'b0; U1_SLAVE = 2'b00;
	
		// WRITE from Master 2 to Slave 2
		#200 U2_REQ = 0; U2_LOCK = 0; U2_WRITE = 0; U2_ADDR = 12'b0; U2_WDATA = 32'b0; U2_SLAVE = 2'b00;
		
		#100 U2_REQ = 1; U2_LOCK = 0; U2_WRITE = 1; U2_ADDR = 12'd4; U2_WDATA = $random; U2_SLAVE = 2'b10;
		
		#100 U2_REQ = 0; U2_LOCK = 0; U2_WRITE = 1; U2_ADDR = 12'd4; U2_SLAVE = 2'b10;
			
		#200 U2_REQ = 0; U2_LOCK = 0; U2_WRITE = 0; U2_ADDR = 12'd0; U2_WDATA = 32'b0; U2_SLAVE = 2'b00;
		
		// READ from Slave 1 to Master 1 
		#100 U1_REQ = 1; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd4;  U1_SLAVE = 2'b01;
				
		#100 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd4;  U1_SLAVE = 2'b01;
		
		#100 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd4;  U1_SLAVE = 2'b00;
	*/
//---Two Master Request with equal priorities---------

	/*	#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
		
		// Master 1 + Master 2 request and write to Slave 1 (Master 1 granted access)
		#200 U1_REQ = 1; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;
		
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 0; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;		
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
			  
		// Master 1 + Master 2 request and write to Slave 1 (Master 2 granted access)
		#200 U1_REQ = 1; #20 U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;	

		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
	*/
//---Two Master Request with different priorities---------

	/*	#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
			  
		// Master 1 + Master 2 request and write to Slave 1 (Master 2 HLOCK invoked priority)
		#200 U1_REQ = 1; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 1; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 1; U1_WRITE = 0; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;	

		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
	*/
//---Split Transaction-----
	
		// WRITE to Master 1
		#200 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'b0; U1_WDATA = 32'b0; U1_SLAVE = 2'b00;
		
		#100 U1_REQ = 1; U1_LOCK = 0; U1_WRITE = 1; U1_ADDR = 12'd9; U1_WDATA = $random; U1_SLAVE = 2'b01;
		
		#100 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 1; U1_ADDR = 12'd9; U1_SLAVE = 2'b01;
			
		#200 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd0; U1_WDATA = 32'b0; U1_SLAVE = 2'b00; 		 
	
		// READ from Master 1
		#100 U1_REQ = 1; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd9;  U1_SLAVE = 2'b01;
				
		#100 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd9;  U1_SLAVE = 2'b01; U_SPLIT = 1;
		
		//---- SPLIT invoked
		
			// WRITE from Master 2 to Slave 2
			#200 U2_REQ = 0; U2_LOCK = 0; U2_WRITE = 0; U2_ADDR = 12'b0; U2_WDATA = 32'b0; U2_SLAVE = 2'b00;
			
			#100 U2_REQ = 1; U2_LOCK = 0; U2_WRITE = 1; U2_ADDR = 12'd6; U2_WDATA = $random; U2_SLAVE = 2'b10;
			
			#100 U2_REQ = 0; U2_LOCK = 0; U2_WRITE = 1; U2_ADDR = 12'd6; U2_SLAVE = 2'b10;
				
			#200 U2_REQ = 0; U2_LOCK = 0; U2_WRITE = 0; U2_ADDR = 12'd0; U2_WDATA = 32'b0; U2_SLAVE = 2'b00;
		
		//---- SPLIT resumed
		
		#200 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd9;  U1_SLAVE = 2'b01; U_SPLIT = 0;
		
		#100 U1_REQ = 0; U1_LOCK = 0; U1_WRITE = 0; U1_ADDR = 12'd9;  U1_SLAVE = 2'b00;
	
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
		
	/*	
		// Master 1 + Master 2 request and write to Slave 1 (Master 2 granted access)
		#200 U1_REQ = 1; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b10;
		
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b10;		
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
			  
	   // Master 1 + Master 2 request and write to Slave 1 (Master 1 granted access)
		#200 U1_REQ = 1; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b10;
		
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b10;		
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;	
	*/
//---Additional priority verification
/*
		#200 U1_REQ = 0; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 1; U1_WRITE = 0; U2_WRITE = 1; 
				U1_ADDR = 12'd9; U2_ADDR = 12'd9;  U1_SLAVE = 2'b01; U2_SLAVE = 2'b10; U2_WDATA = $random; 
				U_SPLIT = 0;
		
		#100 U1_REQ = 0;U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 1; U1_WRITE = 0; U2_WRITE = 1;  U1_ADDR = 12'd9;
			  U2_ADDR = 12'd9; U1_SLAVE = 2'b00; U2_SLAVE = 2'b10;
	
	//	#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
	//		  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
		
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
		
		// Master 1 + Master 2 request and write to Slave 1 (Master 1 granted access)
		#200 U1_REQ = 1; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;
		
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 0; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;		
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
			  
	   // Master 1 + Master 2 request and write to Slave 1 (Master 1 granted access)
		#200 U1_REQ = 1; U2_REQ = 1; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 1; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'd3; U1_WDATA = $random; U2_WDATA = $random; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;
		
		#200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 1; U2_WRITE = 0; U1_ADDR = 12'd1; 
			  U2_ADDR = 12'b0; U1_SLAVE = 2'b01; U2_SLAVE = 2'b01;		
			  
	   #200 U1_REQ = 0; U2_REQ = 0; U1_LOCK = 0; U2_LOCK = 0; U1_WRITE = 0; U2_WRITE = 0; U1_ADDR = 12'b0; 
			  U2_ADDR = 12'b0; U1_WDATA = 32'b0; U2_WDATA = 32'b0; U1_SLAVE = 2'b00; U2_SLAVE = 2'b00;
	*/
	end
      
endmodule

