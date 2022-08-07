/*##########Script Information###############################
  # Purpose: Decoder RTL For System Bus Design   
  # Updated: 07-08-2022                                  
  # Author : Rumesh                                  
  ###########################################################*/

`timescale 1ns / 1ps

module Decoder(RST,CLK,HADDR,SEL_1,SEL_2,SEL_3,SELR);

input RST,CLK;
input [14:0]HADDR; // looks at first 15 bits  only, 16th  bit not needed

output reg SEL_1,SEL_2,SEL_3;
output reg [1:0]SELR;

always@(posedge CLK or posedge RST)
	begin
	if(HADDR[14:13] == 2'b01 && RST != 1) // Slave 1 selected
		begin
			SEL_1 = 1; 
			SEL_2 = 0;
			SEL_3 = 0;
			SELR = 2'b01; 
		end 
	else if(HADDR[14:13] == 2'b10 && RST != 1) // Slave 2 selected
		begin
			SEL_1 = 0;
			SEL_2 = 1;
			SEL_3 = 0;
			SELR = 2'b10;
		end 
	else if(HADDR[14:13] == 2'b11 && RST != 1) // Slave 3 selected
		begin
			SEL_1 = 0;
			SEL_2 = 0;
			SEL_3 = 1;
			SELR = 2'b11; 
		end 
	else if(RST == 1) // Async reset
		begin
			SEL_1 = 0;
			SEL_2 = 0;
			SEL_3 = 0;
			SELR = 2'b00;
		end
	else
		begin
			SEL_1 = 0;
			SEL_2 = 0;
			SEL_3 = 0;
			SELR = 2'b00;
		end
	end
			
endmodule
