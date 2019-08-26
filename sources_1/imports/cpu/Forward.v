`timescale 1ns / 1ps
module Forward(RegWr_EX,RegWr_MEM,WrAddr_EX,WrAddr_MEM,ALUSrc1,ALUSrc2,Rs_ID,Rt_ID,Rs_forward,Rt_forward,jreg_forward);
input RegWr_EX,RegWr_MEM;
input ALUSrc1,ALUSrc2;
input [4:0]WrAddr_EX,WrAddr_MEM,Rs_ID,Rt_ID;
output [1:0]Rs_forward,Rt_forward,jreg_forward;

assign Rs_forward=
	(RegWr_EX && WrAddr_EX!=5'd0 && !ALUSrc1 && Rs_ID==WrAddr_EX)?2'b10:
	(RegWr_MEM && WrAddr_MEM!=5'd0 && !ALUSrc1 && Rs_ID==WrAddr_MEM)?2'b01:2'b00;

assign Rt_forward=
	(RegWr_EX && WrAddr_EX!=5'd0 && !ALUSrc2 && Rt_ID==WrAddr_EX)?2'b10:
	(RegWr_MEM && WrAddr_MEM!=5'd0 && !ALUSrc2 && Rt_ID==WrAddr_MEM)?2'b01:2'b00;

assign jreg_forward=
	(RegWr_EX && WrAddr_EX!=5'd0 && Rs_ID==WrAddr_EX)?2'b10:
	(RegWr_MEM && WrAddr_MEM!=5'd0 && Rs_ID==WrAddr_MEM)?2'b01:2'b00;

endmodule
