`timescale 1ns / 1ps



module TestBench;

	// Inputs
	reg [3:0] addrRa;
	reg [3:0] addrRb;
	reg [3:0] addrW;
	reg [3:0] datW;
	reg RegWrite;
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] datOutRa;
	wire [3:0] datOutRb;
	wire [0:6] sseg;
	wire [1:0] an;

	// Instantiate the Unit Under Test (UUT)
	display uut (
		.addrRa(addrRa), 
		.addrRb(addrRb), 
		.datOutRa(datOutRa), 
		.datOutRb(datOutRb), 
		.addrW(addrW), 
		.datW(datW), 
		.RegWrite(RegWrite), 
		.clk(clk), 
		.rst(rst),
		.sseg(sseg),
		.an(an)
		
	);

	initial begin
		// Initialize Inputs
		addrRa = 0;
		addrRb = 0;
		addrW = 0;
		datW = 0;
		RegWrite = 0;
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
		rst = 0;
		
		datW=9;
		RegWrite=1;
		addrW = 11;
		
		#10;
		RegWrite=0;
		
		addrRa = 1;
		addrRb = 11;
		
//		#100;
		
//		rst = 1;
		
	end
	
	
	always #1 clk = ~clk;
      
endmodule

