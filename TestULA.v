`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:42:06 01/23/2018
// Design Name:   ULA
// Module Name:   /home/ise/Desktop/Trabalho_OACII/TPOACII/TestULA.v
// Project Name:  TPOACII
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ULA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestULA;

	// Inputs
	reg [31:0] Data1;
	reg [31:0] Data2;
	reg [3:0] Control;

	// Outputs
	wire Zero;
	wire [31:0] Output;

	// Instantiate the Unit Under Test (UUT)
	ULA uut (
		.Data1(Data1), 
		.Data2(Data2), 
		.Control(Control), 
		.Zero(Zero), 
		.Output(Output)
	);

	initial begin
		// Initialize Inputs
		Data1 = 'd200;
		Data2 = 'd44;
		Control = 'b0111;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

