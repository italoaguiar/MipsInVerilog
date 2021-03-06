`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:14:22 12/29/2017 
// Design Name: 
// Module Name:    RegisterBank 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegisterBank(
    input [4:0]ReadRegister1,
    input [4:0]ReadRegister2,
    input [4:0]WriteRegister,
    input [31:0] WriteData,
    input RegWrite,
    output reg [31:0] ReadData1,
    output reg [31:0] ReadData2
    );
	 
	initial begin
		ReadData1 = 'b00000000000000000000000000000000;
		ReadData2 = 'b00000000000000000000000000000000;
	end

	//32 registradores de 32 bits
	reg [31:0]RegisterMemory[0:31];
     
	integer i;
	integer j;	
     
	initial
		begin
			for(i=0 ; i<32 ; i=i+1)
				begin
					for(j=0 ; j<32 ; j= j+1)
						RegisterMemory[i][j] = 'b0;
				end
		end
		
	always @(ReadRegister1 or ReadRegister2)
		begin				
			ReadData1 = RegisterMemory[ReadRegister1];
			ReadData2 = RegisterMemory[ReadRegister2];	
			
		end
		
	always @(posedge RegWrite or WriteData or WriteRegister)
		begin
			RegisterMemory[WriteRegister] = WriteData;
			$display("Escrevendo Registrador $t%d: %d", WriteRegister, WriteData);
		end

endmodule
