`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:50:58 12/28/2017 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
    input [31:0] I1,
    input [31:0] I2,
    input S,
    output reg [31:0] Output
    );
	 
	 always @(I1 or I2 or S)
		begin			
			if(S == 0)
				Output = I1;
			else
				Output = I2;
				
		end


endmodule
