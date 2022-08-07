`timescale 1ns / 1ps

module TOP_MODULE(

//Common Top Module I/O

input wire RST,
input wire CLK,

// Master 1 Control I/O

input wire U1_REQ,
input wire U1_LOCK,
input wire U1_WRITE,
input wire [11:0]U1_ADDR,
input wire [31:0]U1_WDATA,
input wire [1:0]U1_SLAVE,

//Master 2 Control I/O

input wire U2_REQ,
input wire U2_LOCK,
input wire U2_WRITE,
input wire [11:0]U2_ADDR,
input wire [31:0]U2_WDATA,
input wire [1:0]U2_SLAVE,


//Slave 1 Control I/O

input wire U_SPLIT,

// Blanks

output wire AB


);
	 
	 wire [31:0]s11,m12,m22,s21,s31;
	 wire [15:0]m11,m21;
	 wire [1:0]s12,s13,HMAS,s22,s32;
	 wire m13,m23,m14,m24,s14,MLOCK,m15,m25,s23,s33;
	 
	 //Common wires
	 
	 wire HREADY;
	 wire [1:0]HRESP;
	 wire [15:0]HADDR;
	 wire [31:0]HWDATA, HRDATA; 
		

	 
	
	 TOP_BUS_ARB BUS_ARB(.HADDR_1(m11),.HADDR_2(m21),.HRDATA_1(s11),.HRDATA_2(s21),.HRDATA_3(s31),.HRESP_1(s12),
								.HRESP_2(s22),.HRESP_3(s32),.HSPLIT(s13),.HWDATA_1(m12),.HWDATA_2(m22),.CLK(CLK),.HLOCK_1(m13),
								.HLOCK_2(m23),.HREQ_1(m14),.HREQ_2(m24),.RST(RST),.HREADY(HREADY),.SEL_1(s14),.SEL_2(s23),.SEL_3(s33),
								.MLOCK(MLOCK),.HGRANT_1(m15),.HGRANT_2(m25),.HWDATA(HWDATA),.HRESP(HRESP),.HRDATA(HRDATA),.HMAS(HMAS),
								.HADDR(HADDR),.AB(AB));
	 
	 Master MASTER_1(.CLK(CLK),.RST(RST),.HGRANT(m15),.HREADY(HREADY),.HRESP(HRESP),.HRDATA(HRDATA),.HREQ(m14),.HLOCK(m13),.HADDR(m11),
							.HWDATA(m12),.U_REQ(U1_REQ),.U_LOCK(U1_LOCK),.U_WRITE(U1_WRITE),.U_ADDR(U1_ADDR),.U_WDATA(U1_WDATA),
							.U_SLAVE(U1_SLAVE),.AB(AB));
	 
	 Master MASTER_2(.CLK(CLK),.RST(RST),.HGRANT(m25),.HREADY(HREADY),.HRESP(HRESP),.HRDATA(HRDATA),.HREQ(m24),.HLOCK(m23),.HADDR(m21),
							.HWDATA(m22),.U_REQ(U2_REQ),.U_LOCK(U2_LOCK),.U_WRITE(U2_WRITE),.U_ADDR(U2_ADDR),.U_WDATA(U2_WDATA),
							.U_SLAVE(U2_SLAVE),.AB(AB));
	 
	 Slave_2K_Split SLAVE_1(.HADDR(HADDR),.HWDATA(HWDATA),.SEL(s14),.CLK(CLK),.RST(RST),.HMAS(HMAS),.MLOCK(MLOCK),.USPLIT(U_SPLIT),.HRDATA(s11),
									.HRESP(s12),.HSPLIT(s13),.HREADY(HREADY),.AB(AB));
									
	 Slave_2K SLAVE_2(.HADDR(HADDR),.HWDATA(HWDATA),.SEL(s23),.CLK(CLK),.RST(RST),.MLOCK(MLOCK),.HRDATA(s21),
									.HRESP(s22),.HREADY(HREADY),.AB(AB));
									
	 Slave_4K SLAVE_3(.HADDR(HADDR),.HWDATA(HWDATA),.SEL(s33),.CLK(CLK),.RST(RST),.MLOCK(MLOCK),.HRDATA(s31),
									.HRESP(s32),.HREADY(HREADY),.AB(AB));


endmodule
