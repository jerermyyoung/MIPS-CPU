`timescale 1ns / 1ps

module innerclk(sysclk,clk);
input sysclk;
output reg clk;

reg [26:0] state;

initial begin
clk=0;
state=27'b0;
end

always @(posedge sysclk)
begin
if(state==0)
clk=~clk;
state=state+1;
if(state==27'd49_999999)
state=27'b0;
end

endmodule