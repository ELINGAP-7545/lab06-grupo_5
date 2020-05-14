`timescale 1ns / 1ps



module display(

    output [3:0] datOutRa,
	 output [3:0] datOutRb,
    input clk,
    output [0:6] sseg,
    output reg [1:0] an,
	 input rst,
	 
	 input [3:0] addrRa,
    input [3:0] addrRb,
    
	 input [3:0] addrW,
    input [3:0] datW,
    
	 input RegWrite
    );
	 
	 
	 BancoRegistro display ( 
	 .datOutRa (datOutRa), 
	 .datOutRb(datOutRb), 
	 .addrRa (addrRa), 
	 .addrRb (addrRb),
	 .addrW (addrW),
	 .datW (datW),	
	 .RegWrite (RegWrite),
	 .clk (clk),
	 .rst (rst) 
	 
	);
	 

reg [3:0]bcd = 0;
 
BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));

reg [26:0] cfreq=0;
wire enable;

// Divisor de frecuecia

assign enable = cfreq[16];
assign led = enable;

always @(posedge clk) begin
  if(rst==1) begin
		cfreq <= 0;
	end else begin
		cfreq <=cfreq+1;
	end
end

reg count = 0;

always @(posedge enable) begin

		if(rst==1) begin
			count<= 0; 
			an <= 2'b11;
			end else begin 
			count<= count+1;
			an<=2'b10; 

			case (count) 
			   2'h0: begin bcd <= datOutRa;   an<=2'b10; end 
				2'h1: begin bcd <= datOutRb;   an<=2'b01; end 
				
			endcase
		end
end

endmodule
