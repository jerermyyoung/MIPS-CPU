`timescale 1ns / 1ps
module BCD7(din, dout);
    input [3:0] din;
    output [6:0] dout;
    
    wire [6:0] dout;
    
    assign    dout=(din==4'h0)?7'b1000000:
                 (din==4'h1)?7'b1111001:
                 (din==4'h2)?7'b0100100:
                 (din==4'h3)?7'b0110000:
                 (din==4'h4)?7'b0011001:
                 (din==4'h5)?7'b0010010:
                 (din==4'h6)?7'b0000010:
                 (din==4'h7)?7'b1111000:
                 (din==4'h8)?7'b0000000:
                 (din==4'h9)?7'b0010000:
                 (din==4'ha)?7'b0001000:
                 (din==4'hb)?7'b0000011:
                 (din==4'hc)?7'b1000110:
                 (din==4'hd)?7'b0100001:
                 (din==4'he)?7'b0000110:
                 (din==4'hf)?7'b0001110:7'b1111111;

endmodule

