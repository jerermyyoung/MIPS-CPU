`timescale 1ns / 1ps
module MEM2WB(reset,clk,
	MemtoReg_in,MemtoReg_out,RegWr_in,RegWr_out,
	pc_in,pc_out,RdData_in,RdData_out,ALUOut_in,ALUOut_out,WrAddr_in,WrAddr_out);
input reset;
input clk;
input [1:0]MemtoReg_in;
input RegWr_in;
input [31:0]pc_in;
input [31:0]RdData_in;
input [31:0]ALUOut_in;
input [4:0]WrAddr_in;

output [1:0]MemtoReg_out;
output RegWr_out;
output [31:0]pc_out;
output [31:0]RdData_out;
output [31:0]ALUOut_out;
output [4:0]WrAddr_out;

reg [1:0]MemtoReg_out;
reg RegWr_out;
reg [31:0]pc_out;
reg [31:0]RdData_out;
reg [31:0]ALUOut_out;
reg [4:0]WrAddr_out;

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
		MemtoReg_out<=0;
		RegWr_out<=0;
		pc_out<=32'h8000_0000;
		RdData_out<=0;
		ALUOut_out<=0;
		WrAddr_out<=0;
	end
	else
	begin
		MemtoReg_out<=MemtoReg_in;
		RegWr_out<=RegWr_in;
		pc_out<=pc_in;
		RdData_out<=RdData_in;
		ALUOut_out<=ALUOut_in;
		WrAddr_out<=WrAddr_in;
	end
end
endmodule
