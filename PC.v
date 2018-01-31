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
	 input clk,
    output reg [31:0] Output
    );
	 
	 reg [31:0] _pc;
	 reg start;
	 
	 
	initial
		begin
			_pc = 'b00000000000000000000000000000000;
			start = 0;
			Output = _pc;
		end

	always @(posedge clk)
		begin
			if(start == 1) begin
				_pc = _pc + 1;
				Output = _pc;
			end
			start = 1;
		end

	always @(Input)
		begin
			if(Input !== 32'bx && Input > 0)
				begin
					_pc = Input;
					$display("Salto programado: %d", Input);
				end
		end

endmodule
