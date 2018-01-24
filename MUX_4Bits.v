`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:58:47 01/23/2018 
// Design Name: 
// Module Name:    MUX_4Bits 
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
module MUX_4Bits(
    input [4:0]Input0,
    input [4:0]Input1,
    input S,
    output reg [4:0]Output
    );

always @(Input0 or Input1 or S)
	begin
		Output = (S == 0)? Input0: Input1;
	end

endmodule
