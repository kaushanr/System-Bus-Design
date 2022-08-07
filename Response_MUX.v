`timescale 1ns / 1ps

module Resp_MUX(CLK,RST,HRESP,HRESP_1,HRESP_2,HRESP_3,SEL);

input [1:0]SEL;
input RST,CLK;
input [1:0]HRESP_1, HRESP_2, HRESP_3;

output reg [1:0]HRESP;

always@(posedge CLK or posedge RST)
	begin
	if(SEL == 2'b01 && RST != 1) // Slave 1 selected
		begin
			HRESP = HRESP_1;
		end 
	else if(SEL == 2'b10 && RST != 1) // Slave 2 selected
		begin
			HRESP = HRESP_2;
		end
	else if(SEL == 2'b11 && RST != 1) // Slave 3 selected
		begin
			HRESP = HRESP_3;
		end
	else if(RST == 1) // Async reset
		begin
			HRESP = 0;
		end
	else
		begin
			HRESP = 0;
		end
	
	end


endmodule
