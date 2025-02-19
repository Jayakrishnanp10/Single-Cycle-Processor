module single_cycle_processor(input clk,reset);

wire [31:0] PCNext,PC,Instruction,Result,SrcA,RD2,ImmExt,SrcB,ALUResult,ReadData,PCPlus4,PCTarget;
wire zero,RegWrite,ALUSrc,MemWrite,ResultSrc,PCSrc;
wire [1:0] ImmSrc;
wire [2:0] ALUControl;

program_counter pc(clk,reset,PCNext,PC);

instruction_memory inm1(PC,Instruction);

regfile rf1(Instruction[19:15],Instruction[24:20],Instruction[11:7],Result,clk,RegWrite,SrcA,RD2);

mux m1(RD2,ImmExt,ALUSrc,SrcB);

alu a1(SrcA,SrcB,ALUControl,ALUResult,,zero);

data_memory dm1(ALUResult,RD2,clk,MemWrite,ReadData);

mux m2(ALUResult,ReadData,ResultSrc,Result);

extend e1(Instruction[31:7],ImmSrc,ImmExt);

alu a2(PC,ImmExt,3'b000,PCTarget,,);

alu a3(PC,32'h00000004,3'b000,PCPlus4,,);

mux m3(PCPlus4,PCTarget,PCSrc,PCNext);

decoder d1(Instruction[6:0],Instruction[14:12],Instruction[30],zero,RegWrite,ALUSrc,MemWrite,ResultSrc,PCSrc,ImmSrc,ALUControl);

always @(clk)
        begin
            $display("CLK=%h , PC=%h , PCNext=%h , instr=%h",clk,PC,PCNext,Instruction);
		
        end
endmodule
 
module mux(input [31:0] X,Y,
	   input select,
	   output reg [31:0] Z);
always @(*) begin
case(select)
1'b0:Z<=X;
1'b1:Z<=Y;
endcase
end
endmodule

module extend(input [31:7] Instr,
		input [1:0] select,
		output reg [31:0] imm);
always @(*) begin
case(select)
2'b00:imm= {{20{Instr[31]}}, Instr[31:20]} ;
2'b01:imm= {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
2'b10:imm= {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
2'b11:imm= {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}
endcase

end

endmodule


