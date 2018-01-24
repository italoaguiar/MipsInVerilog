`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:59:27 12/28/2017 
// Design Name: 
// Module Name:    Adder 
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
module Adder(
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] Output,
	 output reg BitOverflow
    );

always @(A or B)
	begin
		{BitOverflow, Output} = A + B;
	end
endmodule








