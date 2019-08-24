`timescale 1ns / 1ps
module Hazard(Branch,PCSrc,Rs_ID,Rt_ID,Rt_EX,MemRd_EX,
	flush_IF2ID,flush_ID2EX,Write_IF2ID,Write_PC);
input MemRd_EX;
input [4:0]Rt_EX, Rs_ID, Rt_ID;
input [2:0]PCSrc;
input Branch;
output flush_IF2ID,flush_ID2EX;
output Write_IF2ID,Write_PC;

assign flush_IF2ID=((PCSrc == 3'b001 && Branch) || (PCSrc == 3'b010) || (PCSrc == 3'b011))?1:0;
 
assign flush_ID2EX=((MemRd_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID)) || (PCSrc == 3'b001 && Branch) || PCSrc ==3'b010 || PCSrc == 3'b011)?1:0;  

assign Write_IF2ID=(MemRd_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID))?0:1;   

assign Write_PC=(MemRd_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID))?0:1;                     

endmodule
