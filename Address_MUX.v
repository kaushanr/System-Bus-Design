module Addr_MUX(CLK,RST,HADDR,HADDR_1,HADDR_2,SEL);

input [1:0]SEL;
input RST,CLK;
input [15:0]HADDR_1, HADDR_2;

output reg [15:0]HADDR;

always@(posedge CLK or posedge RST)
	begin
	if(SEL == 2'b01 && RST != 1) // Master 1 selected
		begin
			HADDR = HADDR_1;
		end 
	else if(SEL == 2'b10 && RST != 1) // Master 2 selected
		begin
		HADDR = HADDR_2;
		end
	else if(RST == 1) // Async reset
		begin
			HADDR = 16'bx;
		end
	else
		begin
			HADDR = 16'bx;
		end
	
	end

endmodule
