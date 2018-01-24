`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:10 01/23/2018 
// Design Name: 
// Module Name:    Control 
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
module Control(
    input [31:0] Instruction,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemRead,
    output reg MemToReg,
    output reg [2:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
    );

always @(Instruction)
	begin
		if(Instruction[31:26] == 'b000000)//tipo R
			begin
				RegDst = 1;
				Jump = 0;
				Branch = 0;
				MemRead = 0;
				MemToReg = 0;
				ALUOp = 'b010;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 1;
			end
		if(Instruction[31:26] == 'b100011)//lw
			begin
				RegDst = 0;
				Jump = 0;
				Branch = 0;
				MemRead = 1;
				MemToReg = 1;
				ALUOp = 'b000;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
			end
		if(Instruction[31:26] == 'b101011)//sw
			begin
				RegDst = 0;
				Jump = 0;
				Branch = 0;
				MemRead = 0;
				MemToReg = 0;
				ALUOp = 'b000;
				MemWrite = 1;
				ALUSrc = 1;
				RegWrite = 0;
			end
		if(Instruction[31:26] =='b000100)//beq
			begin
				RegDst = 0;
				Jump = 0;
				Branch = 1;
				MemRead = 0;
				MemToReg = 0;
				ALUOp = 'b001;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 0;
			end
		if(Instruction[31:26] == 'b001000)//addi
			begin
				RegDst = 0;
				Branch = 0;
				MemRead = 0;
				MemToReg = 0;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				Jump = 0;
				ALUOp = 'b011;
			end
		if(Instruction[31:26] == 'b001010)//slti
			begin
				RegDst = 0;
				Branch = 0;
				MemRead = 0;
				MemToReg = 0;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				Jump = 0;
				ALUOp = 'b100;
			end
		if(Instruction[31:26] == 'b000101)//bne
			begin
				Branch = 1;
				MemRead = 0;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 0;
				Jump = 0;
				ALUOp = 'b101;
			end
		if(Instruction[31:26] == 'b000010)//jump
			begin
				Jump = 1;
				MemRead = 0;
				ALUOp = 'b000;
				MemWrite = 0;
				RegWrite = 0;
			end
	end

endmodule
