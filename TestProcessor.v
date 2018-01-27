`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:53:26 01/23/2018
// Design Name:   MipsProcessor
// Module Name:   /home/ise/Desktop/Trabalho_OACII/TPOACII/TestProcessor.v
// Project Name:  TPOACII
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MipsProcessor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestProcessor;

		// Inputs
   
	reg Clk;

	// Outputs
	wire [31:0] Instruction;
	wire [3:0] Output;
	wire RegDst;
   wire Jump;
   wire Branch;
   wire MemRead;
   wire MemToReg;
   wire MemWrite;
   wire ALUSrc;
   wire RegWrite;
	wire [2:0] ALUOp;
	wire ZERO;
	wire [31:0] ULAOutput;
	wire [31:0] PCInput;
	wire [31:0] PC;
	wire [4:0] WriteRegister;
	wire [31:0] WriteData;
	wire [31:0] RegisterData2;	
	wire [31:0] ULAData1;
	wire [31:0] ULAData2;
	wire [31:0] SignExtended;
	wire [31:0] MemoryOutput;
	wire [31:0] MUXOutput;
	wire [31:0] JumpAddress;
	
	// Instantiate the Unit Under Test (UUT)
	
	assign JumpAddress = {{6{Instruction[25]}}, Instruction[25:0]};
	
	PC uu0(
		.Input(PCInput),
		.clk(Clk),
		.Output(PC)
	);
	
	InstructionMemory uu4(
		.ReadAddress(PC),
		.Instruction(Instruction)
	);
	
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
	
	ULA uu3(
		.Data1(ULAData1),
		.Data2(ULAData2),
		.Control(Output),
		.Zero(ZERO),
		.Output(ULAOutput)
	);
	
	MUX_4Bits uu5(
		.Input0(Instruction[20:16]),
		.Input1(Instruction[15:11]),
		.S(RegDst),
		.Output(WriteRegister)
	);
	
	RegisterBank uu6(
		.ReadRegister1(Instruction[25:21]),
		.ReadRegister2(Instruction[20:16]),
		.WriteRegister(WriteRegister),
		.WriteData(WriteData),
		.RegWrite(RegWrite),
		.ReadData1(ULAData1),
		.ReadData2(RegisterData2)
	);
	
	SignExtend uu7(
		.Input(Instruction[15:0]),
		.Output(SignExtended)
	);
	
	MUX uu8(
		.I1(RegisterData2),
		.I2(SignExtended),
		.S(ALUSrc),
		.Output(ULAData2)
	);
	
	DataMemory uu9(
		.Address(ULAOutput),
		.WriteData(RegisterData2),
		.ReadData(MemoryOutput),
		.MemRead(MemRead),
		.MemWrite(MemWrite)
	);
	
	MUX uu10(
		.I1(ULAOutput),
		.I2(MemoryOutput),
		.S(MemToReg),
		.Output(WriteData)
	);	
	
	MUX uu14(
		.I1(PC),
		.I2(SignExtended),
		.S(Branch & ZERO),
		.Output(MUXOutput)
	);
	
	MUX uu15(
		.I1(MUXOutput),
		.I2(JumpAddress),
		.S(Jump),
		.Output(PCInput)
	);
	
	

	initial begin
		// Initialize Inputs
		Clk = 1;
		
		
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always Clk = #200 ~Clk; 
	
      
endmodule

