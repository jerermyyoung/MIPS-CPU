`timescale 1ns / 1ps

module display(clk,regnum,an,cat);
input clk;
input [15:0] regnum;
output [3:0] an;
output [7:0] cat;

reg [1:0] stat;
wire [3:0] num;
wire khz;
reg khz_reg;
reg [15:0] state;

always @(posedge clk)
begin
if(state==0)
khz_reg=~khz_reg;
state=state+1;
if(state==16'd49999)
state=16'b0;
end

assign khz=khz_reg;

always @(posedge khz)
begin
stat<=stat+1;
end

assign an=(stat==0)?4'b1110:
(stat==1)?4'b1101:
(stat==2)?4'b1011:
(stat==3)?4'b0111:4'b1111;

assign num=(stat==0)?regnum[3:0]:
(stat==1)?regnum[7:4]:
(stat==2)?regnum[11:8]:
(stat==3)?regnum[15:12]:4'b0000;

BCD7 bcd(num,cat);
endmodule

