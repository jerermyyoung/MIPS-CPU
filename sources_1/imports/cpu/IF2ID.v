`timescale 1ns / 1ps
module IF2ID(clk,ins_in,ins_out,pc_in,pc_out,reset,wr_IF2ID,flush_IF2ID);
    input [31:0]ins_in;
    input [31:0]pc_in;
    input clk,reset,wr_IF2ID,flush_IF2ID;
    output [31:0]ins_out;
    output [31:0]pc_out;
    reg [31:0]ins_out;
    reg [31:0]pc_out;

    always @(posedge clk or posedge reset)
    begin
	   if(reset)
	   begin
	       pc_out<=32'h8000_0000;
	       ins_out<=32'h0000_0000;
	   end
	   else if(flush_IF2ID)
	   begin
	       pc_out<=32'h0000_0000;
	       ins_out<=32'h0000_0000;
       end
	   else if(wr_IF2ID)
	   begin
	       ins_out<=ins_in;
	       pc_out<=pc_in;
	   end
    end
endmodule


		
