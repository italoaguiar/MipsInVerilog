`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:20:17 12/29/2017 
// Design Name: 
// Module Name:    MipsProcessor 
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
module MipsProcessor(
		input instAddress,
		output pc,
		output pcInput,
		output instWire
		/*output shiftWire,
		output shiftWire2,
		output mux1_I1,
		output mux1_S,
		output mux1_O,
		output mux2_O,
		output writeData,
		output readData1,
		output readData2,
		output signWire,
		output adder1_i,
		output adder1_o,
		output adder2_o*/
    );
	 

wire [31:0] pc;

wire regDst;
wire regWrite;
wire branch;

wire ALUZero;

wire [31:0] instAddress;
wire [31:0] instWire;

wire [31:0] pcInput;

PC programCounter(pcInput, pc);

InstructionMemory instructionMemory(instAddress, instWire);

wire [31:0] shiftWire;
ShiftLeft shiftLeft(instWire,shiftWire);

wire [31:0]mux1_I1;
wire mux1_S;
MUX mux1(shiftWire, mux1_I1, mux1_S, pcInput);

wire [31:0] mux2_O;
MUX mux2(instWire[20:16], instWire[15:11], regDst, mux2_O);

wire [31:0] writeData;
wire [31:0] readData1;
wire [31:0] readData2;
RegisterBank registerBank(instWire[25:21], instWire[20:16], mux2_O, writeData, regWrite, readData1, readData2);

wire [31:0] signWire;
SignExtend signExtend(instWire[15:0], signWire);

wire [31:0] shiftWire2;
ShiftLeft shiftLeft2(signWire, shiftWire2);

wire [31:0] adder1_i;
wire [31:0] adder1_o;
Adder adder1(pc, adder1_i, adder1_o);

wire [31:0] adder2_o;
Adder adder2(shiftWire2, adder1_o, adder2_o);

MUX mux3(adder1_o, adder2_o, branch & ALUZero, mux1_I1); 


endmodule








