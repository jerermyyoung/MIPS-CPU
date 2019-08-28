`timescale 1ns / 1ps
module EX2MEM(clk,reset,
	MemRd_in,MemRd_out,MemWr_in,MemWr_out,MemtoReg_in,MemtoReg_out,RegWr_in,RegWr_out,
	ALUOut_in,ALUOut_out,DatabusB_in,DatabusB_out,pc_in,pc_out,WrAddr_in,WrAddr_out,Ra_in,Ra_out,PCSrc_in,PCSrc_out,
	addr_in,addr_out
	);
input clk;
input reset;
input MemRd_in;
input MemWr_in;
input [1:0]MemtoReg_in;
input [31:0]ALUOut_in;
input [31:0]DatabusB_in;
input [31:0]pc_in,Ra_in;
input RegWr_in;
input [4:0]WrAddr_in;
input [2:0]PCSrc_in;
input [1:0] addr_in;

output MemRd_out;
output MemWr_out;
output [1:0]MemtoReg_out;
output [31:0]ALUOut_out;
output [31:0]DatabusB_out;
output [31:0]pc_out,Ra_out;
output RegWr_out;
output [4:0]WrAddr_out;
output [2:0]PCSrc_out;
output [1:0] addr_out;

reg MemRd_out;
reg MemWr_out;
reg [1:0]MemtoReg_out;
reg [31:0]ALUOut_out;
reg [31:0]DatabusB_out;
reg [31:0]pc_out,Ra_out;
reg RegWr_out;
reg [4:0]WrAddr_out;
reg [2:0]PCSrc_out;
reg [1:0] addr_out;

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
		MemRd_out<=0;
		MemWr_out<=0;
		MemtoReg_out<=0;
		ALUOut_out<=0;
		DatabusB_out<=0;
                Ra_out<=0;
		RegWr_out<=0;
		WrAddr_out<=0;
		pc_out<=32'h8000_0000;
		PCSrc_out<=0;
		addr_out<=0;
	end
	else
	begin
		MemRd_out<=MemRd_in;
		MemWr_out<=MemWr_in;
		MemtoReg_out<=MemtoReg_in;
		ALUOut_out<=ALUOut_in;
		DatabusB_out<=DatabusB_in;
		pc_out<=pc_in;
                Ra_out<=Ra_in;
		RegWr_out<=RegWr_in;
		WrAddr_out<=WrAddr_in;
		PCSrc_out<=PCSrc_in;
		addr_out<=addr_in;
	end
end
endmodule