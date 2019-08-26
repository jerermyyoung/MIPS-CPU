
module CPU(reset, clk, select);
//module CPU(reset, clk);
	input reset, clk;
	input [1:0] select;
	
	reg [31:0] PC;
	wire [31:0] regnum;
    wire [2:0] PCSrc;
	wire IRQ;
	
	//IF stage var
    wire [31:0]PC_IF;
    wire [31:0]ins_IF, ins_IRQ_IF;

    //ID stage var
    wire [31:0]ins_ID, ins_IRQ_ID;
    wire [31:0]PC_ID;
    wire [1:0]RegDst_ID,MemtoReg_ID;
    wire [3:0]ALUOp_ID;
    wire RegWrite_ID,ALUSrc1_ID,ALUSrc2_ID,Sign_ID,MemWrite_ID,MemRead_ID,ExtOp_ID,LuOp_ID,Branch_ID;
    wire [31:0]Imm32,Immzero32,Im_ID,ConBA_ID;
    wire [15:0]Imm16;
    wire [31:0]DataBusA_ID,DataBusB_ID;

    //EX stage var
    wire [1:0]RegDst_EX,MemtoReg_EX;
    wire [3:0]ALUOp_EX;
    wire [31:0]DataBusA_EX,DataBusB_EX,Im_EX,PC_EX,ins_EX;
    wire RegWrite_EX,ALUSrc1_EX,ALUSrc2_EX,Sign_EX,MemWrite_EX,MemRead_EX;
    wire [31:0]JT_ID;
    wire [31:0]ALUin_1, ALUin_2;
    wire [31:0]ALUOut_EX;
    wire [4:0] ALUCtl;
    wire [4:0] RegWraddr_EX;
    wire [4:0] Xp,Ra;
    wire [31:0] PC_next;
    wire Zero;

    //MEM stage var
    wire RegWrite_MEM, MemWrite_MEM, MemRead_MEM;
    wire [1:0] MemtoReg_MEM;
    wire [31:0] ALUOut_MEM, PC_MEM, MemWrdata_MEM, DataBusB_MEM, MemRddata_MEM;
    wire [4:0] RegWraddr_MEM;

    //WB stage var == ID stage var
    wire [1:0] MemtoReg_WB;
    wire [31:0] ALUOut_WB, MemRddata_WB,PC_WB,RegWrdata_WB;
    wire [4:0]RegWraddr_WB;
    wire RegWrite_WB;

    //flush fucntion var
    wire flush_IF2ID,Wr_IF2ID,flush_ID2EX,Wr_PC;

    //forward function var 
    wire [31:0]DataBusA_forward_ID,DataBusB_forward_ID,DataBusA_jr_ID;
    wire [1:0]ForwardA_EX,ForwardB_EX,ForwardJr;
    
    wire RegWrite;
    wire [31:0] RegWrdata;
    wire [4:0] RegWraddr;

    parameter ILLOP = 32'h80000004;
    parameter XADR = 32'h80000008;
    assign IRQ=0;
	//PC+4
	wire [31:0] PC_plus_4;
	assign PC_plus_4 = PC + 32'd4;
	//IF
	InstructionMemory instruction_memory1(.Address(PC_IF[30:0]), .Instruction(ins_IF));
	assign ins_IRQ_IF=(IRQ)?32'b0:ins_IF;
    IF2ID rr1(clk,ins_IRQ_IF,ins_ID,PC_IF,PC_ID,reset,Wr_IF2ID,flush_IF2ID);
    //ID
    assign ins_IRQ_ID=(IRQ)?32'b0:ins_ID;
	Control control1(.IRQ(IRQ), 
		.OpCode(ins_IRQ_ID[31:26]), .Funct(ins_IRQ_ID[5:0]),
		.PCSrc(PCSrc), .RegWrite(RegWrite_ID), .RegDst(RegDst_ID), 
		.MemRead(MemRead_ID),	.MemWrite(MemWrite_ID), .MemtoReg(MemtoReg_ID),
		.ALUSrc1(ALUSrc1_ID), .ALUSrc2(ALUSrc2_ID), .ExtOp(ExtOp_ID), .LuOp(LuOp_ID), .ALUOp(ALUOp_ID), .Sign(Sign_ID));
	
   assign RegWrite=(ins_IRQ_ID[31:26] == 6'h03)?RegWrite_ID:RegWrite_WB;
   assign RegWraddr=(ins_IRQ_ID[31:26] == 6'h03)?5'b11111:RegWraddr_WB;
   assign RegWrdata=(ins_IRQ_ID[31:26] == 6'h03)?PC_IF:RegWrdata_WB;
   RegisterFile register_file1(.reset(reset), .clk(clk), .RegWrite(RegWrite), 
		.Read_register1(ins_IRQ_ID[25:21]), .Read_register2(ins_IRQ_ID[20:16]), .Write_register(RegWraddr),
		.Write_data(RegWrdata), .Read_data1(DataBusA_ID), .Read_data2(DataBusB_ID));
		
    assign DataBusA_forward_ID = (ForwardA_EX == 2'b01)?(MemRead_MEM?MemRddata_MEM:ALUOut_MEM):(ForwardA_EX == 2'b10)?ALUOut_EX:DataBusA_ID;
    assign DataBusB_forward_ID = (ForwardB_EX == 2'b01)?(MemRead_MEM?MemRddata_MEM:ALUOut_MEM):(ForwardB_EX==2'b10)?ALUOut_EX:DataBusB_ID;
    assign DataBusA_jr_ID = (ForwardJr == 2'b01)?(MemRead_MEM?MemRddata_MEM:ALUOut_MEM):(ForwardJr==2'b10)?ALUOut_EX:DataBusA_ID;

    assign Imm32=(Imm16[15]==1 && ExtOp_ID)?{16'hffff,Imm16}:{16'h0000,Imm16};
    assign Imm16=ins_IRQ_ID[15:0];
    assign Immzero32={Imm16,16'b0};
    assign Im_ID=(LuOp_ID)?Immzero32:Imm32;
    assign Branch_ID=((ins_IRQ_ID[31:26]==6'h04)&&(DataBusA_forward_ID==DataBusB_forward_ID)) || ((ins_IRQ_ID[31:26]==6'h05)&&(DataBusA_forward_ID!=DataBusB_forward_ID));
    assign ConBA_ID={Imm32[29:0],2'b00}+PC_ID+3'd4;
    
    ID2EX rr2( reset,clk,flush_ID2EX,
	   ALUSrc1_ID,ALUSrc1_EX,ALUSrc2_ID,ALUSrc2_EX,Sign_ID,Sign_EX,ALUOp_ID,ALUOp_EX,MemRead_ID,MemRead_EX,MemWrite_ID,MemWrite_EX,MemtoReg_ID,MemtoReg_EX,
	   DataBusA_forward_ID,DataBusA_EX,DataBusB_forward_ID,DataBusB_EX,PC_ID,PC_EX,Im_ID,Im_EX,ins_IRQ_ID,ins_EX,
	   RegDst_ID,RegDst_EX,RegWrite_ID,RegWrite_EX);
	assign regnum=(select==0)?register_file1.RF_data[4]:
	(select==1)?register_file1.RF_data[2]:
	(select==2)?register_file1.RF_data[29]:
	(select==3)?register_file1.RF_data[31]:16'h0000;
	//EX
	assign ALUin_1=(ALUSrc1_EX)?{27'b0,ins_EX[10:6]}:DataBusA_EX;
    assign ALUin_2=(ALUSrc2_EX)?Im_EX:DataBusB_EX;
    assign Ra=5'b1_1111;
    assign Xp=5'b1_1010;
    assign JT_ID = {PC_ID[31:28],ins_IRQ_ID[25:0],2'b0};
    assign RegWraddr_EX=(RegDst_EX==2'b00)?ins_EX[20:16]:
	   (RegDst_EX==2'b01)?ins_EX[15:11]:
	   (RegDst_EX==2'b10)?Ra:Xp;
	ALUControl alucontrol1(.ALUOp(ALUOp_EX), .Funct(ins_EX[5:0]), .ALUCtl(ALUCtl));
	ALU alu1(.in1(ALUin_1), .in2(ALUin_2), .ALUCtl(ALUCtl), .Sign(Sign_EX), .out(ALUOut_EX), .zero(Zero));
    EX2MEM rr3(
	   clk,reset,
	   MemRead_EX,MemRead_MEM,MemWrite_EX,MemWrite_MEM,MemtoReg_EX,MemtoReg_MEM,RegWrite_EX,RegWrite_MEM,
	   ALUOut_EX,ALUOut_MEM,DataBusB_EX,DataBusB_MEM,PC_EX,PC_MEM,RegWraddr_EX,RegWraddr_MEM
    );
	
	assign MemWrdata_MEM=DataBusB_MEM;
	DataMemory data_memory1(.reset(reset), .clk(clk), .Address(ALUOut_MEM), .Write_data(MemWrdata_MEM), .Read_data(MemRddata_MEM), .MemRead(MemRead_MEM), .MemWrite(MemWrite_MEM));

    MEM2WB rr4(
	   reset,clk,
	   MemtoReg_MEM,MemtoReg_WB,RegWrite_MEM,RegWrite_WB,
	   PC_MEM,PC_WB,MemRddata_MEM,MemRddata_WB,ALUOut_MEM,ALUOut_WB,RegWraddr_MEM,RegWraddr_WB
	);
    
    assign RegWrdata_WB=(MemtoReg_WB==2'b00)?ALUOut_WB:
        (MemtoReg_WB == 2'b01)?MemRddata_WB:
        (RegWraddr_WB==5'b11010)?PC_IF:PC_IF+3'b100;
        
    //forward
    Forward fo(
        RegWrite_EX,RegWrite_MEM,RegWraddr_EX,RegWraddr_MEM,ALUSrc1_ID,ALUSrc2_ID,
        ins_IRQ_ID[25:21],ins_IRQ_ID[20:16],ForwardA_EX,ForwardB_EX,ForwardJr);
    
    //hazard
    Hazard ha(
        Branch_ID,PCSrc,ins_IRQ_ID[25:21],ins_IRQ_ID[20:16],ins_EX[20:16],MemRead_EX,
        flush_IF2ID,flush_ID2EX,Wr_IF2ID,Wr_PC);
	
	//PC related
    assign PC_next= (PCSrc==3'b000) ? PC_plus_4:
	   (PCSrc==3'b001 && Branch_ID)?ConBA_ID:
	   (PCSrc==3'b001 && !Branch_ID)?PC_plus_4:
	   (PCSrc==3'b010)?JT_ID:
	   (PCSrc==3'b011)?DataBusA_jr_ID:
	   (PCSrc==3'b100)?ILLOP:XADR;
	   
    always @(posedge clk or posedge reset)
	   begin
	   if(reset)
			PC<=32'h80000000;
	   else if (Wr_PC)
			PC<=PC_next;       
	end

    assign PC_IF=PC;    
endmodule	
