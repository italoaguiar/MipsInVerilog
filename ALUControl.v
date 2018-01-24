`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:14:34 01/23/2018 
// Design Name: 
// Module Name:    ALUControl 
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
module ALUControl(
    input [5:0] OpCode,
    input [2:0] ALUOp,
    output reg [3:0] Output
    );

always @(OpCode or ALUOp)
	begin		
		if(ALUOp == 'b010)// Tipo R
			begin
				case(OpCode)
					'b100100: Output = 'b0000;
					'b100101: Output = 'b0001;
					'b100000: Output = 'b0010;
					'b100010: Output = 'b0110;
					'b101010: Output = 'b0111;					
				endcase
			end
		else if(ALUOp == 'b001)// Beq
			begin
				Output = 'b0110;
			end
		else if(ALUOp == 'b101)// Bne
			begin
				Output = 'b1110;
			end
		else if(ALUOp == 'b000)// LW/SW
			begin
				Output = 'b0010;
			end
		else if(ALUOp == 'b011) // addi
			begin
				Output = 'b0010;
			end
		else if(ALUOp == 'b100) // slti
			begin
				Output = 'b0111;
			end
	end

endmodule
