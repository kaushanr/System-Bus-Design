`timescale 1ns / 1ps

module Read_MUX(CLK,RST,HRDATA,HRDATA_1,HRDATA_2,HRDATA_3,SEL);

input [1:0]SEL;
input RST,CLK;
input [31:0]HRDATA_1, HRDATA_2, HRDATA_3;

output reg [31:0]HRDATA;

always@(posedge CLK or posedge RST)
	begin 
	if(SEL == 2'b01 && RST != 1) // Slave 1 selected
		begin
			HRDATA = HRDATA_1;
		end 
	else if(SEL == 2'b10 && RST != 1) // Slave 2 selected
		begin
			HRDATA = HRDATA_2;
		end
	else if(SEL == 2'b11 && RST != 1) // Slave 3 selected
		begin 
			HRDATA = HRDATA_3;
		end
	else if(RST == 1) // Async reset
		begin
			HRDATA = 32'bx;
		end
	else
		begin
			HRDATA = 32'bx;
		end
	
	end

endmodule
