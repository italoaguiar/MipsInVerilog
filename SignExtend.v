`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:32:59 12/29/2017 
// Design Name: 
// Module Name:    SignExtend 
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
module SignExtend(
    input [15:0] Input,
    output reg [31:0] Output
    );

	always @(Input)
		begin
			Output[15:0]  = Input[15:0];
			Output[31:16] = {16{Input[15]}};
		end

endmodule
