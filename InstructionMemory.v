`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:00 12/28/2017 
// Design Name: 
// Module Name:    InstructionMemory 
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
module InstructionMemory(
    input [31:0] ReadAddress,
    output reg [31:0] Instruction
    );

reg [256:0]InstructionMemory[31:0];

integer i;

	initial
		begin
			for(i = 0; i< 256; i = i+1)
				begin
					InstructionMemory[i] = 'b00000000000000000000000000000000;
				end
				
			//escrever memria de programa aqui
			//InstructionMemory[0] = 'b00000001001010100100000000100000;  //add $t0 $t1 $t2
			//InstructionMemory[0] = 'b10001101001010000000000000000000;  //lw $t0 0($t1)
			//InstructionMemory[0] = 'b00100001001010000000000000001111;  //addi $t0 $t1 15
			//InstructionMemory[0] = 'b00001000000000000000000000000001; //j 0x01
			//InstructionMemory[0] = 'b00010001000010010000000000000001; //beq $t0 $t1 0x01
			//InstructionMemory[0] = 'b00010101000010010000000000000001; //bne $t0 $t1 0x01
			
			//InstructionMemory[0] = 'b00100000000010010000000000000100; //addi $t1 $zero 4
			InstructionMemory[0] = 'b00100000000010010000000000000100; //addi $t1 $zero 4
			InstructionMemory[1] = 'b00100000000010100000000000001111; //addi $t2 $zero 15
			InstructionMemory[2] = 'b10101101010010010000000000000000; //SW $t1 0($t2)
			InstructionMemory[3] = 'b10001101001010110000000000000000; //LW $t3 0($t1)
			InstructionMemory[4] = 'b00101001011010010000000000011001; //slti $t1 $t3 0x01
			
		end



always @(ReadAddress)
	begin
		Instruction = InstructionMemory[ReadAddress];
		$display("Lendo Instrucao %d: %b", ReadAddress, Instruction);
	end
endmodule
