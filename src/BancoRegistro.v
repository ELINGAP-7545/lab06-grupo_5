`timescale 1ns / 1ps

module BancoRegistro #(      		 //   #( Parametros
         parameter BIT_ADDR = 4,  //   BIT_ADDR Número de bit para la dirección
         parameter BIT_DATO = 2  //  BIT_DATO  Número de bit para el dato
)

	(
    input [BIT_ADDR-1:0] addrRa,
    input [BIT_ADDR-1:0] addrRb,
	 
    
	 output [BIT_ADDR-1:0] datOutRa,
    output [BIT_ADDR-1:0] datOutRb,
    
	 input [BIT_ADDR-1:0] addrW,
    input [BIT_ADDR-1:0] datW,
    
	 input RegWrite,
    input clk,
    input rst
    );
	 
	/* 
	 display display ( 
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
*/

// La cantdiad de registros es igual a: 
localparam NREG = 2 ** BIT_ADDR;             //16
  
//configiración del banco de registro 
reg [3: 0] breg [NREG-1:0];                  //[NREG-1:0] -> 15 registros de (reg [3: 0] breg) -> 4 bits cada registro 


assign  datOutRa = breg[addrRa];					//salidaA = banco breg en la posicion addrRa
assign  datOutRb = breg[addrRb];					//salidaB = banco breg en la posicion addrRb

integer index;

always @(posedge clk) begin

if (rst == 1)begin

    for (index=0; index<16; index=index+1) begin
      breg[index] <= 4'b1111;
   
	end
	end

	if (RegWrite == 1)
     breg[addrW] <= datW;							//ESCRITURA EN LA POSICION addrW del dato datW
  end
												


initial begin

    for (index=0; index<16; index=index+1) begin
      breg[index] <= 4'b1111;
   
	end
end


endmodule

