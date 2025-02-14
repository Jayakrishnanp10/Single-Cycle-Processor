module data_memory( input [31:0]A,
		input [31:0]WD,
		input CLK,
		input WE,
		output reg [31:0]RD);

reg [8:0] REG [65535:0];

assign RD={REG[A+32'h00000003],REG[A+32'h00000002],REG[A+32'h00000001],REG[A]};
always @(posedge CLK) begin
if (WE==1'b1) begin
 {REG[A+32'h00000003],REG[A+32'h00000002],REG[A+32'h00000001],REG[A]}<=WD;
end

end

assign {REG[32'h00002003],REG[32'h00002002],REG[32'h00002001],REG[32'h00002000]} = 32'h0000000A;
always @(CLK)
        begin
            
            $display("CLK=%h , x200C=%h",
                CLK,
		{REG[32'h0000200F],REG[32'h0000200E],REG[32'h0000200D],REG[32'h0000200C]});
		
        end

endmodule

