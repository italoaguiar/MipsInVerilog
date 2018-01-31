`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:41:30 01/23/2018 
// Design Name: 
// Module Name:    ULA 
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
module ULA(
    input [31:0] Data1,
    input [31:0] Data2,
    input [3:0] Control,
    output Zero,
    output reg[31:0] Output
    );
	 

reg Ovf;
wire Overflow;

assign Overflow = Ovf;
assign Zero = (0 == Output);

always @(Data1 or Data2 or Control)
	begin
		case(Control)
			'b0000: Output = Data1 & Data2;                  //and
			'b0001: Output = Data1 | Data2;                  //or
			'b0010: {Ovf, Output} = Data1 + Data2;           //add
			'b0110: {Ovf, Output} = Data1 - Data2;           //sub
			'b1110: Output = (Data1 - Data2) == 0;           //dif
			'b0111: Output = (Data1 < Data2)? 31'b1: 31'b0;  //slt
			'b1100: Output = ~(Data1 | Data2);               //nor
			'b1101: Output = Data1 ^ Data2;                  //xor
		endcase
	end

endmodule
