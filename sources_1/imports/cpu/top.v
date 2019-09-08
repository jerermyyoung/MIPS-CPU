`timescale 1ns / 1ps

module top(rst,sysclk,selreg,button,selclk,leds,digi);

    input rst;
    input sysclk;
    input [6:0] selreg;
    input button;
    input selclk;
    output [7:0] leds;
    output [11:0] digi;
    
    wire clk,clk1,clk2;
    wire [15:0] regnum;
    wire [3:0] an;
    wire [7:0] cat;
    
//    innerclk inner(sysclk,clk1);
//    debounce(sysclk,button,clk2);
//    assign clk=(selclk==0)?clk1:(selclk==1)?clk2:0;
    assign clk=sysclk;
    
    CPU cpu1(rst,clk,selreg,leds,digi);
//    CPU cpu1(rst,clk);
    
//    assign regnum=cpu1.regnum[15:0];
//    assign an=digi[11:8];
//    assign cat=digi[7:0];
//    display seereg(sysclk,regnum,an,cat);
    
endmodule
