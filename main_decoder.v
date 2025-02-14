module main_decoder(input [6:0] opcode,
			output reg RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,Jump
			output reg [1:0] ImmSrc,ALUOp);

always @(opcode) begin
case(opcode)
7'b0000011 : begin 
	RegWrite=1'b1;
	ImmSrc=2'b00;
	ALUSrc=1'b1;
	MemWrite=1'b0;
	ResultSrc=2'b01;
	Branch=1'b0;
	ALUOp=2'b00;
	Jump=1'b0;
end
7'b0100011 : begin 
	RegWrite=1'b0;
	ImmSrc=2'b01;
	ALUSrc=1'b1;
	MemWrite=1'b1;
	//ResultSrc=1'b1;
	Branch=1'b0;
	ALUOp=2'b00;
	Jump=1'b0;
end
7'b0110011 : begin 
	RegWrite=1'b1;
	//ImmSrc=2'b00;
	ALUSrc=1'b0;
	MemWrite=1'b0;
	ResultSrc=2'b00;
	Branch=1'b0;
	ALUOp=2'b10;
	Jump=1'b0;
end
7'b1100011 : begin 
	RegWrite=1'b0;
	ImmSrc=2'b10;
	ALUSrc=1'b0;
	MemWrite=1'b0;
	//ResultSrc=1'b1;
	Branch=1'b1;
	ALUOp=2'b01;
	Jump=1'b0;
end
7'b0010011 : begin 
	RegWrite=1'b1;
	ImmSrc=2'b00;
	ALUSrc=1'b1;
	MemWrite=1'b0;
	ResultSrc=2'b00;
	Branch=1'b0;
	ALUOp=2'b10;
	Jump=1'b0;
end
7'b1101111 : begin 
	RegWrite=1'b1;
	ImmSrc=2'b11;
	//ALUSrc=1'b1;
	MemWrite=1'b0;
	ResultSrc=2'b10;
	Branch=1'b0;
	//ALUOp=2'b10;
	Jump=1'b1;
end

endcase
end


endmodule

module alu_decoder(input [1:0] ALUOp,
			input [2:0] funct3,
			input op5,funct75,
			output reg [2:0] ALUControl);

always @(*) begin
case(ALUOp)
2'b00: ALUControl = 3'b000;
2'b01: ALUControl = 3'b001;
2'b10: case(funct3)
	3'b000: case({op5,funct75})
		2'b11: ALUControl = 3'b001;
		default:ALUControl = 3'b000;
		endcase
	3'b010:ALUControl = 3'b101;
	3'b110:ALUControl = 3'b011;
	3'b111:ALUControl = 3'b010;
	endcase
endcase
end
endmodule

module decoder(input [6:0] opcode,
		input [2:0] funct3,
		input funct75,
		input zero,
		output RegWrite,ALUSrc,MemWrite,ResultSrc,PCSrc,
		output [1:0] ImmSrc,
		output [2:0] ALUControl
		);
wire Branch1,Branch2;
wire [1:0] ALUOp;
main_decoder md1(opcode,RegWrite,ALUSrc,MemWrite,ResultSrc,Branch1,Jump,ImmSrc,ALUOp);
alu_decoder ad1(ALUOp,funct3,opcode[5],funct75,ALUControl);
and a1(Branch2,Branch1,zero);
or o1(PCSrc,Jump,Branch2)



endmodule

