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

reg [31:0]InstructionMemory[256:0];

integer i;

	initial
		begin
			//Instruction = 'b00000000000000000000000000000000;
			
			for(i = 0; i< 256; i = i+1)
				begin
					InstructionMemory[i] = 'b00000000000000000000000000000000;
				end
				
			
			/*// PROGRAMA DE TESTE 1
			// Este programa  destinado a testar as funes ADDI, ADD e Bne
			InstructionMemory[0] = 'b00100000000010010000000000000001; //addi $t1 $zero 1 - carrega 1 em $t1
			InstructionMemory[1] = 'b00100000000010100000000000000111; //addi $t2 $zero 7 - carrega 7 em $t2
			InstructionMemory[2] = 'b00100000000010110000000000001001; //addi $t3 $zero 9 - carrega 9 em $t3
			InstructionMemory[3] = 'b00000001001010100110000000100000; //add $t4 $t1 $t2  - $t4 = 1 + 7
			InstructionMemory[4] = 'b00010101011011000000000000000010; //bne $t3 $t4 0x3  - salta para 0x03 se $t4 != $t3
			*/
			
			/*// PROGRAMA DE TESTE 2
			// Este programa  destinado a testar as funes SLT e SLTI
			// Saida Esperada: $t1 = 16, $t2 = 3 $t3 = 25, $t4 = 1, $t5 = 1
			InstructionMemory[0] = 'b00100000000010010000000000010000; //addi $t1 $zero 16 - carrega 16 em $t1
			InstructionMemory[1] = 'b00100000000010100000000000000011; //addi $t2 $zero 3  - carrega 3 em $t2
			InstructionMemory[2] = 'b00100001001010110000000000001001; //addi $t3 $t1 9    - $t3 = 16 + 9
			InstructionMemory[3] = 'b00000001010010110110000000101010; //slt $t4 $t2 $t3   - $t4 = $t2 < $t3
			InstructionMemory[4] = 'b00101001010011010000000000010101; //slti $t5 $t2 0x15 - $t5 = $t2 < 15
			*/
			
			/*// PROGRAMA DE TESTE 3
			// Este programa  destinado a testar as funes J e Sub
			// Saida Esperada: $t3 = 6
			InstructionMemory[0] = 'b00100000000010010000000000000111; //addi $t1 $zero 7  - carrega 7 em $t1          
			InstructionMemory[1] = 'b00100000000010100000000000000001; //addi $t2 $zero 1  - carrega 1 em $t2
			InstructionMemory[2] = 'b00001000000000000000000000000011; //j 0x4  
			InstructionMemory[3] = 'b00100000000010010000000000000110; //NOP (No Executada - saltada)
			InstructionMemory[4] = 'b00000001001010100101100000100010; //sub $t3 $t1 $t2   - $t3 = $t1 - $t2    
			InstructionMemory[5] = 'b00000001010010110110000000101010; //slt $t4 $0 $t3   - $t4 =  0 < $t3
			*/
         
			/*// PROGRAMA DE TESTE 4
			// Este programa  destinado a testar as funes LW e SW
			// Saida Esperada: $t3 = 4
			InstructionMemory[0] = 'b00100000000010010000000000000100; //addi $t1 $zero 4   //dado
			InstructionMemory[1] = 'b00100000000010100000000000001111; //addi $t2 $zero 15  //endereco
			InstructionMemory[2] = 'b10101101010010010000000000000000; //SW $t1 0($t2)
			InstructionMemory[3] = 'b10001101001010110000000000000000; //LW $t3 0($t1)
			InstructionMemory[4] = 'b00101001011010010000000000011001; //slti $t1 $t3 25
			*/
			
			// PROGRAMA DE TESTE 5
			// Este programa  destinado a testar as funes BEQ, AND e OR
			InstructionMemory[0] = 'b00100000000010010000000000000100; //addi $t1 $zero 4
			InstructionMemory[1] = 'b00100000000010100000000000000100; //addi $t2 $zero 4
			InstructionMemory[2] = 'b00010001001010100000000000000011; //beq $t1 $t2 0x4
			InstructionMemory[3] = 'b00000000000000000000000000000000; //NOP (no executada - saltada)
			InstructionMemory[4] = 'b00000001001010100101100000100100; //and $t3 $t1 $t2
			InstructionMemory[5] = 'b00000001001010100101100000100101; //or $t3 $t1 $t2
			
			
		end



always @(ReadAddress)
	begin
		$display("Lendo Instrucao %d: %b", ReadAddress, InstructionMemory[ReadAddress]);
		Instruction = InstructionMemory[ReadAddress];
	end
endmodule
