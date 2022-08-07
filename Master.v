`timescale 1ns / 1ps

//Transfer types
`define IDLE 1'b0
`define START 1'b1
//`define IDLE_TRANS 2'b11

//Response types
`define OKAY 2'b00
`define ERROR 2'b01
`define RETRY 2'b10
`define SPLIT 2'b11


module Master (
	input CLK,
	input RST,

	input HGRANT,
	input HREADY,
	input [1:0] HRESP,
	input [31:0] HRDATA,

	output reg HREQ,
	output reg HLOCK,
	
	
	output reg [15:0] HADDR,
	output reg [31:0] HWDATA,
	output reg AB,

	//External triggers for testing
	input U_REQ, 
	input U_LOCK,
	input U_WRITE,
	input [11:0] U_ADDR,
	input [31:0] U_WDATA,
	input [1:0] U_SLAVE

);
	 
	parameter [2:0] IDLE = 3'd0;
	parameter [2:0] REQUEST = 3'd1;
	parameter [2:0] TRANS_BEGIN = 3'd2;
	parameter [2:0] TRANS_END = 3'd3;
	parameter [2:0] TRANS_RD_HOLD = 3'd4;
	parameter [2:0] SPLIT = 3'd5;

	reg [15:0] ADDR; 
	reg [31:0] R_DATA; 
	reg [2:0] ADDR_INC = 12'd4; //WORD increment
	reg [11:0] PC; // program counter
	reg TRANS;
	
	reg HWRITE;

	reg [2:0] state;
	 
	initial begin
		AB = 1'bz;
		state = IDLE; //initially idle state
		R_DATA = 32'bz;
	end
	 
always @ (posedge CLK or posedge RST )
	
	begin
		if(RST == 1) 
			begin
		
			HREQ <= 1'b0;
			HLOCK <= 1'b0; //master has lock
			HADDR <= 16'bx;
			HWDATA <= 32'bx;
			state <= IDLE;
			
			end
		
	else begin
	
		case(state)
		 
			IDLE: begin
				
				HREQ <= 1'b0;
				HLOCK <= 1'b0; //master has lock
				TRANS <= `IDLE; // in idle state
				ADDR <= 16'bx;
				ADDR[15] <= TRANS;
				HADDR <= ADDR;
				HWRITE = U_WRITE;
				state <= (U_REQ == 1)?REQUEST:IDLE;
				
			end

			REQUEST : begin
				
				HWDATA <= 32'bx;
				HREQ <= U_REQ;
				HLOCK <= U_LOCK;
					if(HGRANT) begin
						
						ADDR[11:0] <= U_ADDR;
						HREQ <= 1'b1;
						HLOCK <= U_LOCK; //master has no lock
						state <= TRANS_BEGIN;
						
					end
					else state <= REQUEST;
			end
	 
			TRANS_BEGIN: begin
			
				//if(HREADY) begin
					HREQ <= 1'b0;
					TRANS <= `IDLE; // non sequence state in trans 
					ADDR[15] <= TRANS;
					ADDR[14:13] <= U_SLAVE; // Input target slave
					HWRITE = U_WRITE; // Read / Write CTRL - EXT TRIG
					//
					ADDR[12] <= HWRITE;
					HADDR <= ADDR;
					PC <= ADDR[11:0] + ADDR_INC; // Program Counter register increment	 
					state <= TRANS_END;
					//#50;
				//end
			end

			TRANS_END: begin
			
				HLOCK <= U_LOCK; 
				TRANS <= `START;
				ADDR[15] <= TRANS;
				HADDR <= ADDR;
				//R_DATA <= 0;
				
				if(HREADY == 1) begin
			
						if(U_WRITE == 1)
							begin
								HWDATA <= U_WDATA; //write the data
								state <= (HLOCK == 1 || HREADY != 1)?TRANS_BEGIN:IDLE;
							end
						else if(U_WRITE == 0)
							begin
								state <= TRANS_RD_HOLD;
							end
				
						/*else
							begin
								if(HLOCK == 1)
									begin
										state <= TRANS_BEGIN;
									end
								else 
									begin
										state <= (HREADY != 1)?TRANS_BEGIN:IDLE;
									end
							end*/
				end
					
				else if(HRESP == `SPLIT) state <= SPLIT; 
				
				else state <= TRANS_END;
				
				//end
				//else if(HRESP == `ERROR) state <= IDLE;
				//else if(HRESP == `RETRY) state <= TRANS_BEGIN;
				//else if(HRESP == `SPLIT) state <= SPLIT; 
			end
			
			TRANS_RD_HOLD: begin
			
				if (HRESP == `SPLIT) state <= SPLIT;
				else
					begin
						HLOCK <= U_LOCK;
						R_DATA <= (HRDATA !== 32'bx)?HRDATA:32'bz; //read the data 
						state <= (HLOCK == 1 || HRDATA === 32'bx || HREADY != 1)?TRANS_RD_HOLD:IDLE; 
					end
			end
			
			SPLIT: begin
				if(HGRANT) state <= TRANS_RD_HOLD;
			end 
	 endcase
 end
		 
end 
 
endmodule
