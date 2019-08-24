
module Control(IRQ, OpCode, Funct,
	PCSrc, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUOp,Sign);
	input IRQ;
	input [5:0] OpCode;
	input [5:0] Funct;
	output [2:0] PCSrc;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	output [3:0] ALUOp;
	output Sign;
	
	// Your code below

    assign PCSrc=
	   IRQ?3'b100:
	   ((OpCode==6'h00 && Funct!=6'h08 && Funct!=6'h09) || OpCode==6'h23 || OpCode==6'h2b || OpCode==6'h0f || OpCode==6'h08 || OpCode==6'h09 || OpCode==6'h0c || OpCode==6'h0a || OpCode==6'h0b)?3'b000:
	   (OpCode==6'h04 || OpCode==6'h06 || OpCode==6'h07 || OpCode==6'h01 || OpCode==6'h05)?3'b001:
	   (OpCode==6'h02 || OpCode==6'h03)?3'b010:
	   (OpCode==6'h00 && (Funct==6'h08 || Funct==6'h09))?3'b011:
	   3'b101;
	assign RegWrite = ( ( (OpCode == 6'h2b) || ( OpCode == 6'h04 ) || (OpCode == 6'h01) || (OpCode == 6'h05)|| (OpCode == 6'h06)|| (OpCode == 6'h07) || (OpCode == 6'h02) || ((OpCode == 6'h00) && (Funct == 6'h08))) && (~IRQ) ) ?0:1; 
	assign RegDst[1] = ( (OpCode == 6'h03) || IRQ) ?1:0; 
	assign RegDst[0] = ( (OpCode == 6'h00) || IRQ) ?1:0; 
	assign MemRead = ( OpCode == 6'h23) ?1:0; 
	assign MemWrite = ( OpCode == 6'h2b) ?1:0; 
	assign MemtoReg[1] = (( OpCode == 6'h03) || (( OpCode == 6'h00) && (Funct == 6'h09))) ?1:0; 
	assign MemtoReg[0] = ( OpCode == 6'h23) ?1:0; 
	assign ALUSrc1 = (( OpCode == 6'h00) && (( Funct ==6'h00) || (Funct == 6'h02) || (Funct == 6'h03))) ?1:0; 
	assign ALUSrc2 = (( OpCode == 6'h00) || ( OpCode == 6'h04 ) || (OpCode == 6'h01) || (OpCode == 6'h05)|| (OpCode == 6'h06)|| (OpCode == 6'h07)) ?0:1; 
	assign ExtOp = (( OpCode == 6'h0c) || ( OpCode == 6'h0b )) ?0:1; 
	assign LuOp = ( OpCode == 6'h0f) ?1:0; 
	assign Sign = (OpCode == 6'h00) ?~Funct[0]:~OpCode[0];
	
	// Your code above
	
	assign ALUOp[2:0] = 
		(OpCode == 6'h00)? 3'b010: 
		(OpCode == 6'h04)? 3'b001: 
		(OpCode == 6'h0c)? 3'b100: 
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
		3'b000;
		
	assign ALUOp[3] = OpCode[0];
	
endmodule
