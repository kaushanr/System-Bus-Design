`timescale 1ns / 1ps

module TOP_BUS_ARB(

//Common I/O

input wire RST,CLK,
input wire HREADY,

//Arbiter I/O

input wire HLOCK_1,HLOCK_2,
input wire HREQ_1,HREQ_2,
input wire [1:0]HSPLIT,

output wire HGRANT_1,HGRANT_2,
output wire [1:0]HMAS,
output wire MLOCK,


//BUS I/O


input wire [15:0]HADDR_1,HADDR_2,
input wire [31:0]HWDATA_1,HWDATA_2,
input wire [31:0]HRDATA_1,HRDATA_2,
input wire [31:0]HRDATA_3,
input wire [1:0]HRESP_1,HRESP_2,HRESP_3,

output wire [31:0]HWDATA,
output wire [31:0]HRDATA,
output wire [15:0]HADDR,
output wire [1:0] HRESP,
output wire SEL_1,SEL_2,SEL_3,
 
//Blank wire

output wire AB

);


wire [1:0]SEL;




Arbiter Arbiter(.CLK(CLK),.RST(RST),.HLOCK_1(HLOCK_1),
						.HLOCK_2(HLOCK_2),.HREQ_1(HREQ_1),.HREQ_2(HREQ_2),
						.HRESP(HRESP),.HSPLIT(HSPLIT),.SEL(SEL),.HMAS(HMAS),
						.HGRANT_1(HGRANT_1),.HGRANT_2(HGRANT_2),
						.MLOCK(MLOCK),.AB(AB),.HREADY(HREADY));
					
BUS BUS(.CLK(CLK),.RST(RST),.SEL(SEL),.HADDR_1(HADDR_1),.HADDR_2(HADDR_2),
			.HADDR(HADDR),.HWDATA_1(HWDATA_1),.HWDATA_2(HWDATA_2),.HWDATA(HWDATA),
			.HRDATA_1(HRDATA_1),.HRDATA_2(HRDATA_2),.HRDATA_3(HRDATA_3),.HRDATA(HRDATA),
			.HRESP_1(HRESP_1),.HRESP_2(HRESP_2),.HRESP_3(HRESP_3),.HRESP(HRESP),.SEL_1(SEL_1),
			.SEL_2(SEL_2),.SEL_3(SEL_3),.AB(AB));


endmodule
