`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:53:56 01/23/2018
// Design Name:   Control
// Module Name:   /home/ise/Desktop/Trabalho_OACII/TPOACII/TestControl.v
// Project Name:  TPOACII
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestControl;

	// Inputs
	reg [31:0] Instruction;

	// Outputs
	wire RegDst;
	wire Jump;
	wire Branch;
	wire MemRead;
	wire MemToReg;
	wire [1:0] ALUOp;
	wire MemWrite;
	wire ALUSrc;
	wire RegWrite;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.Instruction(Instruction), 
		.RegDst(RegDst), 
		.Jump(Jump), 
		.Branch(Branch), 
		.MemRead(MemRead), 
		.MemToReg(MemToReg), 
		.ALUOp(ALUOp), 
		.MemWrite(MemWrite), 
		.ALUSrc(ALUSrc), 
		.RegWrite(RegWrite)
	);

	initial begin
		// Initialize Inputs
		//Instruction = 'b00000000000000000000000000000000; // tipo R
		Instruction = 'b10001100000000000000000000000000; // tipo LW
		//Instruction = 'b10101100000000000000000000000000; // tipo SW
		//Instruction = 'b00010000000000000000000000000000; // tipo Beq
		//Instruction = 'b00001000000000000000000000000000; // tipo Jump

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		

	end
      
endmodule

