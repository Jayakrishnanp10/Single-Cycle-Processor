module regfile( input [4:0]A1,
		input [4:0]A2,
		input [4:0]A3,
		input [31:0]WD3,
		input CLK,
		input WE3,
		output reg [31:0]RD1,
		output reg [31:0]RD2);

reg [31:0] REG [31:0];
assign REG[0]=0;

assign RD1=REG[A1];
assign RD2=REG[A2];


always @(posedge CLK) begin
if (WE3==1'b1) REG[A3]<=WD3;
end

assign REG[5] = 32'h00000006;
assign REG[6] = 32'h00000110;
assign REG[9] = 32'h00002004;

always @(CLK)
        begin
            
            $display("CLK=%h , x4=%h , x5=%h , x6=%h, x7=%h , x9=%h",
                CLK,
		REG[4],REG[5],REG[6],REG[7],REG[9]);
		
        end


endmodule


