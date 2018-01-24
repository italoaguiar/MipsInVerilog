`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:40:01 01/22/2018
// Design Name:   DataMemory
// Module Name:   /home/ise/Desktop/Trabalho_OACII/TPOACII/TestDataMemory.v
// Project Name:  TPOACII
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DataMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestDataMemory;

	// Inputs
	reg [31:0] Address;
	reg [31:0] WriteData;
	reg MemRead;
	reg MemWrite;
	


	// Outputs
	wire [31:0] ReadData;

	// Instantiate the Unit Under Test (UUT)
	DataMemory uut (
		.Address(Address), 
		.WriteData(WriteData), 
		.ReadData(ReadData), 
		.MemRead(MemRead), 
		.MemWrite(MemWrite)
	);

	initial begin
		// Initialize Inputs
		Address = 0;
		WriteData = 0;
		MemRead = 0;
		MemWrite = 0;

		// Wait 100 ns for global reset to finish
		#100;
		  
		// Add stimulus here
		$display("Valor antigo da posiçao 10: %d", ReadData);
		
		Address = 'b00000000000000000000000000000010;
		WriteData = 'b00000000000000000000000000000001;
		MemWrite = 1;
		
		#100
		
		MemWrite = 0;
		MemRead = 1;
		Address = 'b00000000000000000000000000000011;
		$display("Valor em posição 3: %d", ReadData);
		
		Address = 'b00000000000000000000000000000010;
		$display("Valor novo da posiçao 2: %d", ReadData);;

	end
      
endmodule

