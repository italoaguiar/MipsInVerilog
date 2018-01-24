`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:05:43 01/23/2018
// Design Name:   Adder
// Module Name:   /home/ise/Desktop/Trabalho_OACII/TPOACII/TestAdder.v
// Project Name:  TPOACII
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestAdder;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] Output;
	wire BitOverflow;

	// Instantiate the Unit Under Test (UUT)
	Adder uut (
		.A(A), 
		.B(B), 
		.Output(Output), 
		.BitOverflow(BitOverflow)
	);

	initial begin
		// Initialize Inputs
		A = 'b00000000000000000000000000100100;
		B = 'b00000000000000000000000000010101;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		$display("SOMA %d + %d = %d", A, B, Output);

	end
      
endmodule

