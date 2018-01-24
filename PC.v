`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:07:28 12/28/2017 
// Design Name: 
// Module Name:    PC 
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
module PC(
	 input [31:0] Input,
    output reg [31:0] Output
    );
	 
initial
	begin
		Output = 'b00000000000000000000000000000000;
	end

always @(Input)
	begin
		Output = Input;
	end

endmodule
