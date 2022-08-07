`timescale 1ns / 1ps

`define IDLE 1'b0
`define START 1'b1

// Responses
`define OKAY 2'b00
`define ERROR 2'b01
`define RETRY 2'b10

module Slave_2K(SEL,HADDR,HWDATA,HRDATA,HRESP,CLK,HREADY,RST,MLOCK,AB);

input [15:0] HADDR;
input [31:0] HWDATA;
input SEL;
input RST,CLK;
input MLOCK;

//input HWRITE;

output reg [31:0] HRDATA;
output reg [1:0] HRESP;
output reg HREADY;
output reg AB;

// Slave States
parameter IDLE = 3'd0;
parameter ACTIVE = 3'd1;
parameter WRITE = 3'd2;
parameter READ = 3'd3;


parameter MSB_ADDR = 10; // MSB for 2K Address

reg [2:0] state;
reg [10:0] S_ADDR;
reg HWRITE;
reg TRANS;

// 2K Memory Addresses

reg [31:0] S_REG [2047:0]; //2K, 32-bit registers

initial begin
 HREADY <= 1'bz;
 AB = 1'bz;
end

always @ (posedge CLK or posedge RST )
	
	begin
		if(RST == 1) 
			begin
				HRDATA <= 32'bx;
				HRESP <= `OKAY;
				HREADY <= 1'bz;
				S_ADDR <= 11'bx;
				HWRITE <= 1'bx;
				TRANS <= 1'bx;
				state <= IDLE;
			end
	else
		begin
			
			state <= IDLE;
			
			case(state)
				
				IDLE:begin

					HRESP <= `OKAY;
					HREADY <= 1'bz;
					state <= (SEL == 1)?ACTIVE:IDLE;		
			
				end
				
				ACTIVE:begin
					
					HRESP <= `OKAY;
					HREADY <= 1'b1;
					S_ADDR <= HADDR[MSB_ADDR:0];
					HWRITE <= HADDR[12];
					TRANS <= HADDR[15];
						if(TRANS == 1'b1)
							begin
								HREADY <= 1'b1; // toggles the HREADY line only if selected as active device
								HRESP <= `OKAY;
								state <= (HWRITE == 1)?WRITE:READ;

							end
						else 
							begin
								HRESP <= `ERROR;
								state <= (SEL == 1)?ACTIVE:IDLE;
							end
				end
				
				WRITE:begin
				
					S_ADDR <= HADDR[MSB_ADDR:0];
					HWRITE <= HADDR[12];
					TRANS <= HADDR[15];
					
					if(TRANS == `START)
						begin
							S_REG[S_ADDR] <= HWDATA;
							if(HWDATA == S_REG[S_ADDR])
								begin
									HRESP <= `OKAY;
									HREADY <= 1'b1;
									state <= ACTIVE;
								end
							else if(HWDATA !== S_REG[S_ADDR] && MLOCK == 1)
								begin
									HRESP <= `RETRY;
									HREADY <= 1'b0;
									state <= WRITE;
								end
							else
								begin
									HRESP <= `ERROR;
									HREADY <= 1'b0;
									state <= ACTIVE;
								end
						end
					else
						begin
							HRESP <= `RETRY;
							state <= ACTIVE;
						end
				end
				
				READ:begin
				
					S_ADDR <= HADDR[MSB_ADDR:0];
					HWRITE <= HADDR[12];
					TRANS <= HADDR[15];
		
					if(TRANS == `START)
						begin
							
							HRDATA <= S_REG[S_ADDR];

						end
					else
						begin
							HRESP <= `RETRY;
							state <= ACTIVE;
						end
								
					if(HRDATA == S_REG[S_ADDR])
						begin
							HRESP <= `OKAY;
							HREADY <= 1'b1;
							state <= ACTIVE;
						end
					else if(HRDATA != S_REG[S_ADDR] && MLOCK == 1)
						begin
							HRESP <= `RETRY;
							HREADY <= 1'b0;
							state <= READ;
						end
					else
						begin
							HRESP <= `ERROR;
							HREADY <= 1'b0;
							state <= ACTIVE;
						end
				end
			endcase
		end
	end
endmodule
