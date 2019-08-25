`timescale 1ns / 1ps

module top(rst,sysclk,selreg,button,selclk,cur_pc,an,cat);
//module top(rst,sysclk,button,selclk,cur_pc);
//module top(sysclk,cur_pc,an,cat);
//module top(rst,sysclk,cur_pc);

    input rst;
    input sysclk;
    input [1:0] selreg;
    input button;
    input selclk;
    output [7:0] cur_pc;
    output [3:0] an;
    output [7:0] cat;
    
    wire clk,clk1,clk2;
    wire [15:0] regnum;
    
//    innerclk inner(sysclk,clk1);
//    debounce(sysclk,button,clk2);
//    assign clk=(selclk==0)?clk1:(selclk==1)?clk2:0;
    assign clk=sysclk;
    
    CPU cpu1(rst,clk,selreg);
//    CPU cpu1(rst,clk);
    
    assign regnum=cpu1.regnum[15:0];
    display seereg(sysclk,regnum,an,cat);
    assign cur_pc=cpu1.PC[7:0];
    
endmodule
