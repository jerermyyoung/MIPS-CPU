
module InstructionMemory(Address, Instruction);
	input [30:0] Address;
	output [31:0] Instruction;
	
	(* rom_style = "distributed" *) reg [31:0] ROMDATA[63:0];
	integer i;
	
	initial begin
	ROMDATA[0] <= 32'haadf2391;
	ROMDATA[1] <= 32'h0c00001b;
	ROMDATA[2] <= 32'h08000026;
	ROMDATA[3] <= 32'h00002026;
	ROMDATA[4] <= 32'h8c960000;
	ROMDATA[5] <= 32'h20840004;
	ROMDATA[6] <= 32'h00008026;
	ROMDATA[7] <= 32'h0216402a;
	ROMDATA[8] <= 32'h11000015;
	ROMDATA[9] <= 32'h2211ffff;
	ROMDATA[10] <= 32'h2a280000;
	ROMDATA[11] <= 32'h15000009;
	ROMDATA[12] <= 32'h00114880;
	ROMDATA[13] <= 32'h00895020;
	ROMDATA[14] <= 32'h8d4b0000;
	ROMDATA[15] <= 32'h8d4c0004;
	ROMDATA[16] <= 32'h018b402a;
	ROMDATA[17] <= 32'h11000003;
	ROMDATA[18] <= 32'h0c000017;
	ROMDATA[19] <= 32'h2231ffff;
	ROMDATA[20] <= 32'h0800000a;
	ROMDATA[21] <= 32'h22100001;
	ROMDATA[22] <= 32'h08000007;
	ROMDATA[23] <= 32'had4b0004;
	ROMDATA[24] <= 32'had4c0000;
	ROMDATA[25] <= 32'h03e00008;
	ROMDATA[26] <= 32'h1000ffff;
	ROMDATA[27] <= 32'h20180001;
	ROMDATA[28] <= 32'h20190001;
	ROMDATA[29] <= 32'h0018c740;
	ROMDATA[30] <= 32'h0019cf40;
	ROMDATA[31] <= 32'h23180018;
	ROMDATA[32] <= 32'h2339000c;
	ROMDATA[33] <= 32'h8f0d0000;
	ROMDATA[34] <= 32'h000d6880;
	ROMDATA[35] <= 32'h008d6820;
	ROMDATA[36] <= 32'haf2e0000;
	ROMDATA[37] <= 32'h1000ffff;
	for(i = 38;i < 64;i = i + 1) 
	ROMDATA[i]<=32'h0000_0000;
	end
	
	assign Instruction = ROMDATA[Address[9:2]];
		
endmodule
