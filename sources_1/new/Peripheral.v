`timescale 1ns/1ps
module Peripheral(PCSrc,reset,clk,rd,wr,addr,wdata,rdata,led,digi,selreg,irqout,PC_31);
input [2:0]PCSrc;
input reset,clk;
input rd,wr,PC_31;
input [31:0] addr;
input [31:0] wdata;
input [6:0] selreg;
output [31:0] rdata;
output [7:0] led;
output [11:0] digi;
output irqout;

reg [7:0] led;
reg [11:0] digi;
reg [2:0] TCON;
reg [31:0] TH,TL;
reg [31:0] systick;

assign irqout = (PC_31 || PCSrc==3'b001 || PCSrc==3'b010 || PCSrc==3'b011)?0:TCON[2];

assign rdata = (rd == 0)? 32'b0 :
			   (addr == 32'h40000000)? TH:
			   (addr == 32'h40000004)? TL:
			   (addr == 32'h40000008)? {29'b0,TCON}:
			   (addr == 32'h4000000c)? {24'b0,led}:
			   (addr == 32'h40000010)? {20'b0,digi}:
			   (addr == 32'h40000014)? systick:
			   (addr == 32'h40000018)? {25'b0,selreg}:32'h0000_0000;


always@(posedge reset or posedge clk) 
begin
	if(reset) 
	begin
		TH <= 32'b0;
		TL <= 32'b0;
		TCON <= 3'b0;
		systick <= 32'h0;
	end
	else 
	begin
		if(TCON[0]) 
		begin
			if(TL==32'h499_999) 
			begin
				TL <= TH;
				if(TCON[1]) TCON[2] <= 1'b1;
			end
			else TL <= TL + 1;
		end
		if(wr)
		begin
		case(addr)
			32'h40000000: TH <= wdata;
			32'h40000004: TL <= wdata;
			32'h40000008: TCON <= wdata[2:0];
			//32'h4000000c: led <= wdata[7:0];
			//32'h40000010: digi <= wdata[11:0];
			default:;
		endcase
		end
		systick <= systick+1;
	end
end

endmodule

