`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:33:38 01/23/2018
// Design Name:   ALUControl
// Module Name:   /home/ise/Desktop/Trabalho_OACII/TPOACII/TestALUControl.v
// Project Name:  TPOACII
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestALUControl;

	// Inputs
	reg [5:0] OpCode;
	wire [1:0] ALUOp;
	
	reg [31:0] Instruction;
   wire RegDst;
   wire Jump;
   wire Branch;
   wire MemRead;
   wire MemToReg;
   wire MemWrite;
   wire ALUSrc;
   wire RegWrite;

	// Outputs
	wire [3:0] Output;

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut (
		.OpCode(Instruction[5:0]), 
		.ALUOp(ALUOp), 
		.Output(Output)
	);
	
	Control uu2(
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
		//OpCode = 000000;
		//ALUOp = 0;
		Instruction = 'b00000001010010110100100000100000;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

