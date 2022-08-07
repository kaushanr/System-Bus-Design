`timescale 1ns / 1ps

module Write_MUX(CLK,RST,HWDATA,HWDATA_1,HWDATA_2,SEL);

input [1:0]SEL;
input RST,CLK;
input [31:0]HWDATA_1, HWDATA_2;

output reg [31:0]HWDATA;

always@(posedge CLK or posedge RST)
	begin
	if(SEL == 2'b01 && RST != 1) // Master 1 selected
		begin
			HWDATA = HWDATA_1;
		end 
	else if(SEL == 2'b10 && RST != 1) // Master 2 selected
		begin
			HWDATA = HWDATA_2;
		end
	else if(RST == 1) // Async reset
		begin
			HWDATA = 32'bx;
		end
	else
		begin
			HWDATA = 32'bx;
		end
	
	end

endmodule
