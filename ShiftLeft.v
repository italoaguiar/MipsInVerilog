`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:05:28 12/28/2017 
// Design Name: 
// Module Name:    ShiftLeft 
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
module ShiftLeft(
    input [31:0] Input,
    output reg [31:0] Output
    );
	 
	 always @(Input)
		begin
			Output = Input << 2;
		end
endmodule
