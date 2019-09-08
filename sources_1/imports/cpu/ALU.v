
module ALU(in1, in2, ALUCtl, Sign, out);
	input [31:0] in1, in2;
	input [4:0] ALUCtl;
	input Sign;
	output reg [31:0] out;
	
	reg[31:0] SLL,SRL,SRA;
	
	wire ss;
	assign ss = {in1[31], in2[31]};
	
	wire lt_31;
	assign lt_31 = (in1[30:0] < in2[30:0]);
	
	wire lt_signed;
	assign lt_signed = (in1[31] ^ in2[31])? 
		((ss == 2'b01)? 0: 1): lt_31;
	//shift
    always @(*)begin
	case (in1[4:0])
		5'b00000:
			begin
				SLL<=in2;SRL<=in2;SRA<=in2;	
			end		
		5'b00001:begin
				SLL<={in2[30:0],1'b0};SRL<={1'b0,in2[31:1]};SRA<={in2[31],in2[31:1]};
			end
			5'b00010:begin
				SLL<={in2[29:0],2'b0};SRL<={2'b0,in2[31:2]};SRA<={{2{in2[31]}},in2[31:2]};
			end
			5'b00011:begin
				SLL<={in2[28:0],3'b0};SRL<={3'b0,in2[31:3]};SRA<={{3{in2[31]}},in2[31:3]};
			end
			5'b00100:begin
				SLL<={in2[27:0],4'b0};SRL<={4'b0,in2[31:4]};SRA<={{4{in2[31]}},in2[31:4]};
			end
			5'b00101:begin
				SLL<={in2[26:0],5'b0};SRL<={5'b0,in2[31:5]};SRA<={{5{in2[31]}},in2[31:5]};
			end
			5'b00110:begin
				SLL<={in2[25:0],6'b0};SRL<={6'b0,in2[31:6]};SRA<={{6{in2[31]}},in2[31:6]};
			end
			5'b00111:begin
				SLL<={in2[24:0],7'b0};SRL<={7'b0,in2[31:7]};SRA<={{7{in2[31]}},in2[31:7]};
			end
			5'b01000:begin
				SLL<={in2[23:0],8'b0};SRL<={8'b0,in2[31:8]};SRA<={{8{in2[31]}},in2[31:8]};
			end
			5'b01001:begin
				SLL<={in2[22:0],9'b0};SRL<={9'b0,in2[31:9]};SRA<={{9{in2[31]}},in2[31:9]};
			end
			5'b01010:begin
				SLL<={in2[21:0],10'b0};SRL<={10'b0,in2[31:10]};SRA<={{10{in2[31]}},in2[31:10]};
			end
			5'b01011:begin
				SLL<={in2[20:0],11'b0};SRL<={11'b0,in2[31:11]};SRA<={{11{in2[31]}},in2[31:11]};
			end
			5'b01100:begin
				SLL<={in2[19:0],12'b0};SRL<={12'b0,in2[31:12]};SRA<={{12{in2[31]}},in2[31:12]};
			end
			5'b01101:begin
				SLL<={in2[18:0],13'b0};SRL<={13'b0,in2[31:13]};SRA<={{13{in2[31]}},in2[31:13]};
			end
			5'b01110:begin
				SLL<={in2[17:0],14'b0};SRL<={14'b0,in2[31:14]};SRA<={{14{in2[31]}},in2[31:14]};
			end
			5'b01111:begin
				SLL<={in2[16:0],15'b0};SRL<={15'b0,in2[31:15]};SRA<={{15{in2[31]}},in2[31:15]};
			end
			5'b10000:begin
				SLL<={in2[15:0],16'b0};SRL<={16'b0,in2[31:16]};SRA<={{16{in2[31]}},in2[31:16]};
			end
			5'b10001:begin
				SLL<={in2[14:0],17'b0};SRL<={17'b0,in2[31:17]};SRA<={{17{in2[31]}},in2[31:17]};
			end
			5'b10010:begin
				SLL<={in2[13:0],18'b0};SRL<={18'b0,in2[31:18]};SRA<={{18{in2[31]}},in2[31:18]};
			end
			5'b10011:begin
				SLL<={in2[12:0],19'b0};SRL<={19'b0,in2[31:19]};SRA<={{19{in2[31]}},in2[31:19]};
			end
			5'b10100:begin
				SLL<={in2[11:0],20'b0};SRL<={20'b0,in2[31:20]};SRA<={{20{in2[31]}},in2[31:20]};
			end
			5'b10101:begin
				SLL<={in2[10:0],21'b0};SRL<={21'b0,in2[31:21]};SRA<={{21{in2[31]}},in2[31:21]};
			end
			5'b10110:begin
				SLL<={in2[9:0],22'b0};SRL<={22'b0,in2[31:22]};SRA<={{22{in2[31]}},in2[31:22]};
			end
			5'b10111:begin
				SLL<={in2[8:0],23'b0};SRL<={23'b0,in2[31:23]};SRA<={{23{in2[31]}},in2[31:23]};
			end
			5'b11000:begin
				SLL<={in2[7:0],24'b0};SRL<={24'b0,in2[31:24]};SRA<={{24{in2[31]}},in2[31:24]};
			end
			5'b11001:begin
				SLL<={in2[6:0],25'b0};SRL<={25'b0,in2[31:25]};SRA<={{25{in2[31]}},in2[31:25]};
			end
			5'b11010:begin
				SLL<={in2[5:0],26'b0};SRL<={26'b0,in2[31:26]};SRA<={{26{in2[31]}},in2[31:26]};
			end
			5'b11011:begin
				SLL<={in2[4:0],27'b0};SRL<={27'b0,in2[31:27]};SRA<={{27{in2[31]}},in2[31:27]};
			end
			5'b11100:begin
				SLL<={in2[3:0],28'b0};SRL<={28'b0,in2[31:28]};SRA<={{28{in2[31]}},in2[31:28]};
			end
			5'b11101:begin
				SLL<={in2[2:0],29'b0};SRL<={29'b0,in2[31:29]};SRA<={{29{in2[31]}},in2[31:29]};
			end
			5'b11110:begin
				SLL<={in2[1:0],30'b0};SRL<={30'b0,in2[31:30]};SRA<={{30{in2[31]}},in2[31:30]};
			end
			5'b11111:begin
				SLL<={in2[0],31'b0};SRL<={31'b0,in2[31]};SRA<={32{in2[31]}};
			end
		endcase	
	end
	
	always @(*)
		case (ALUCtl)
			5'b00000: out <= in1 & in2;
			5'b00001: out <= in1 | in2;
			5'b00010: out <= in1 + in2;
			5'b00110: out <= in1 - in2;
			5'b00111: out <= {31'h00000000, Sign? lt_signed: (in1 < in2)};
			5'b01100: out <= ~(in1 | in2);
			5'b01101: out <= in1 ^ in2;
			5'b10000: out <= SLL;
			5'b11000: out <= SRL;
			5'b11001: out <= SRA;
			default: out <= 32'h00000000;
		endcase
	
endmodule