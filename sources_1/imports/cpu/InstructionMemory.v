
module InstructionMemory(Address, Instruction);
	input [30:0] Address;
	output [31:0] Instruction;
	
	(* rom_style = "block" *) reg [31:0] ROMDATA[22:0];
	
	initial begin
	ROMDATA[0] <= 32'h08000003;
	ROMDATA[1] <= 32'h0c000015;
	ROMDATA[2] <= 32'h08000016;
	ROMDATA[3] <= 32'h20040003;
	ROMDATA[4] <= 32'h0c000006;
	ROMDATA[5] <= 32'h1000ffff;
	ROMDATA[6] <= 32'h23bdfff8;
	ROMDATA[7] <= 32'hafbf0004;
	ROMDATA[8] <= 32'hafa40000;
	ROMDATA[9] <= 32'h28880001;
	ROMDATA[10] <= 32'h11000003;
	ROMDATA[11] <= 32'h00001026;
	ROMDATA[12] <= 32'h23bd0008;
	ROMDATA[13] <= 32'h03e00008;
	ROMDATA[14] <= 32'h2084ffff;
	ROMDATA[15] <= 32'h0c000006;
	ROMDATA[16] <= 32'h8fa40000;
	ROMDATA[17] <= 32'h8fbf0004;
	ROMDATA[18] <= 32'h23bd0008;
	ROMDATA[19] <= 32'h00821020;
	ROMDATA[20] <= 32'h03e00008;
	ROMDATA[21] <= 32'h00000000;
	ROMDATA[22] <= 32'h1000ffff;
	end
	
	assign Instruction = ROMDATA[Address[9:2]];
		
endmodule
