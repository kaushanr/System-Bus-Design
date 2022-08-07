/*##########Script Information###############################
  # Purpose: Arbiter RTL For System Bus Design   
  # Updated: 07-08-2022                                  
  # Author : Rumesh                                  
  ###########################################################*/
  
  `timescale 1ns / 1ps

module Arbiter(

 CLK,
 RST,
 HREQ_1,
 HLOCK_1,
 HREQ_2,
 HLOCK_2,
 HSPLIT,
 HRESP,
 HGRANT_1,
 HGRANT_2,
 HMAS,
 MLOCK,
 SEL,AB,
 HREADY
    );

	input CLK;
	input RST;  
	input HREQ_1;
	input HLOCK_1;
	input HREQ_2;
	input HLOCK_2;
	input [1:0] HSPLIT;
	input [1:0] HRESP;
	
	input HREADY;
	
	output reg HGRANT_1;
	output reg HGRANT_2;
	output reg [1:0] HMAS;
	output reg MLOCK;
	output reg [1:0] SEL;
	output reg AB;

//----------------------------
	parameter SPLIT = 2'b11;
	parameter IDLE = 2'b00;
	parameter GRANT1 = 2'b01;
	parameter GRANT2 = 2'b10;

	reg [1:0]  state;
	reg g1;
	reg g2;
	reg [1:0] grant_save;

	
initial begin
	AB = 1'bz;
	state = IDLE;
end

always@(posedge CLK or posedge RST)
	begin
		if(RST == 1) 
			begin
				HGRANT_1 <= 0;
				HGRANT_2 <= 0;
				HMAS <= 0;
				MLOCK <= 0;
				SEL <= 2'b00;
				grant_save <= 0; // saves info about the previous master granted access to the bus
				state <= IDLE;

			end
	else
		begin
		
			state <= IDLE;

		case(state)
			
			IDLE:begin
			
				HGRANT_1 <= 0;
				HGRANT_2 <= 0;
				HMAS <= 0;
				MLOCK <= 0;
				SEL <= 2'b00;
				
// Priority order = Split request > Locked request > normal request
// Master 1 - 01, Master 2 - 10			
	
				if(HSPLIT == 2'b01) // Split request from slave 1 asking master 1 to connect
					begin
						state <= GRANT1;
					end
				else if(HSPLIT == 2'b10) // split request from slave 1 asking master 2 to connect
					begin
						state <= GRANT2;
					end
				else if(HREQ_1 == 1 && HREQ_2 == 0) // normal request only from master 1
					begin
						state <= GRANT1;
					end
				else if(HREQ_1 == 0 && HREQ_2 == 1) // normal request only from master 2
					begin
						state <= GRANT2;
					end
				else if(HREQ_1 == 1 && HREQ_2 == 1) //Priority selection of masters
					begin
						if(HSPLIT == 2'b01 || HLOCK_1) // checks for split request from slave 1 asking master 1 to connect OR a locked request from master 1
							begin
								state <= GRANT1;
							end
						else if(HSPLIT == 2'b10 || HLOCK_2) // checks for split request from slave 1 asking master 2 to connect OR a locked request from master 2
							begin
								state <= GRANT2;
							end
						else // signals with equal normal priority
							begin
								if (grant_save == 2'b01) // variable storing previous master ID
									begin
										state <= GRANT2;
									end
								else if(grant_save == 2'b10)
									begin
										state <= GRANT1;
									end
								else
									begin
										state <= GRANT1; // Default grant to master 1 on start
									end
							end
					end
				else
					begin
						state <= IDLE;
					end
				end
			
			
			GRANT1:begin // access given to Master 1
				
				HGRANT_1 <= 1;
				HGRANT_2 <= 0;
				HMAS <= 2'b01; // unique ID of Master 1 - 01
				MLOCK <= HLOCK_1;
				SEL <= 2'b01; // goes to the address and write muxes
				grant_save <= 2'b01;
				
				
				if(HRESP == SPLIT) // If split response issued, grant switched to other master
					begin
						state <= GRANT2;
					end
				else
					begin
						state <= (HLOCK_1 || HRESP == 2'b00 || HREADY == 1'b0)?GRANT1:IDLE; // (some condition)?if_TRUE:if_FALSE Ternery operator
					end
				end
				
			
			GRANT2:begin
				
				HGRANT_1 <= 0;
				HGRANT_2 <= 1;
				HMAS <= 2'b10;
				MLOCK <= HLOCK_2;
				SEL <= 2'b10;
				grant_save <= 2'b10;
				
				if(HRESP == SPLIT)
					begin
						state <= GRANT1;
					end
				else
					begin
						state <= (HLOCK_2 || HRESP == 2'b00 || HREADY == 1'b0)?GRANT2:IDLE;
					end
				end
		endcase 
	end 
end

endmodule