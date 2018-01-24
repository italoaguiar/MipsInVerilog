`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:25:51 12/28/2017 
// Design Name: 
// Module Name:    DataMemory 
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
module DataMemory(
    input [31:0] Address,
    input [31:0] WriteData,
    output reg [31:0] ReadData,
    input MemRead,
    input MemWrite
    );

reg [0:255]InternalMemory[0:31];

integer i;

	initial
		begin
			for(i = 0; i< 20; i = i+1)
				begin
					InternalMemory[i] = 'b00000000000000000000000000000000;
				end
		end

always @(Address or MemRead)
	begin
		if(MemRead == 1)
			begin
				ReadData = InternalMemory[Address];
				$display("Lendo Memoria na posição %d: %d", Address, ReadData);
			end
	end
	
always @(WriteData)
	begin
		if(MemWrite == 1)
			begin
				InternalMemory[Address] = WriteData;
				$display("Escrevendo Memoria na posição %d: %d", Address, WriteData);
			end
	end

endmodule








