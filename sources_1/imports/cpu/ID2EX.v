`timescale 1ns / 1ps
module ID2EX(reset,clk,flush_ID2EX,
	ALUSrc1_in,ALUSrc1_out,ALUSrc2_in,ALUSrc2_out,Sign_in,Sign_out,ALUFun_in,ALUFun_out,MemRd_in,MemRd_out,MemWr_in,MemWr_out,MemtoReg_in,MemtoReg_out,
	DatabusA_in,DatabusA_out,DatabusB_in,DatabusB_out,pc_in,pc_out,Im_in,Im_out,ins_in,ins_out,ConBA_in,ConBA_out,
	RegDst_in,RegDst_out,RegWr_in,RegWr_out,PCSrc_in,PCSrc_out);
input reset,clk,flush_ID2EX;
input ALUSrc1_in;
input ALUSrc2_in;
input Sign_in;
input [3:0]ALUFun_in;
input MemRd_in;
input MemWr_in;
input [1:0]MemtoReg_in;
input [31:0]DatabusA_in,DatabusB_in,pc_in,Im_in,ins_in,ConBA_in;
input [1:0]RegDst_in;
input RegWr_in;
input [2:0] PCSrc_in;

output ALUSrc1_out;
output ALUSrc2_out;
output Sign_out;
output [3:0]ALUFun_out;
output MemRd_out;
output MemWr_out;
output [1:0]MemtoReg_out;
output [31:0]DatabusA_out,DatabusB_out,pc_out,Im_out,ins_out,ConBA_out;
output [1:0]RegDst_out;
output RegWr_out;
output [2:0] PCSrc_out;

reg ALUSrc1_out;
reg ALUSrc2_out;
reg Sign_out;
reg [3:0]ALUFun_out;
reg MemRd_out;
reg MemWr_out;
reg [1:0]MemtoReg_out;
reg [31:0]DatabusA_out,DatabusB_out,pc_out,Im_out,ins_out,ConBA_out;
reg [1:0]RegDst_out;
reg RegWr_out;
reg [2:0] PCSrc_out;

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
		ALUSrc1_out<=0;
		ALUSrc2_out<=0;
		Sign_out<=0;
		ALUFun_out<=0;
		MemRd_out<=0;
		MemWr_out<=0;
		MemtoReg_out<=0;
		DatabusA_out<=0;
		DatabusB_out<=0;
		Im_out<=0;
		ins_out<=0;
		ConBA_out<=0;
		RegDst_out<=0;
		RegWr_out<=0;
		pc_out<=32'h8000_0000;
		PCSrc_out<=0;
	end
	else if(flush_ID2EX)
	begin
	   ALUSrc1_out<=0;
        ALUSrc2_out<=0;
        Sign_out<=0;
        ALUFun_out<=0;
        MemRd_out<=0;
        MemWr_out<=0;
        MemtoReg_out<=0;
        DatabusA_out<=0;
        DatabusB_out<=0;
        Im_out<=0;
        ins_out<=0;
        ConBA_out<=0;
        RegDst_out<=0;
        RegWr_out<=0;
        pc_out<=32'h0000_0000;
        PCSrc_out<=0;
    end
	else
	begin
		ALUSrc1_out<=ALUSrc1_in;
		ALUSrc2_out<=ALUSrc2_in;
		Sign_out<=Sign_in;
		ALUFun_out<=ALUFun_in;
		MemRd_out<=MemRd_in;
		MemWr_out<=MemWr_in;
		MemtoReg_out<=MemtoReg_in;
		DatabusA_out<=DatabusA_in;
		DatabusB_out<=DatabusB_in;
		pc_out<=pc_in;
		Im_out<=Im_in;
		ins_out<=ins_in;
		ConBA_out<=ConBA_in;
		RegDst_out<=RegDst_in;
		RegWr_out<=RegWr_in;
		PCSrc_out<=PCSrc_in;
	end
end
endmodule
