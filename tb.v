module tb;
reg clk,reset;
integer i;
single_cycle_processor p1(clk,reset);
initial begin
clk=1'b1;
reset=1'b1;

#5 reset=1'b0;
 

for(i=0;i<30;i=i+1) begin
	#5 clk=~clk;
end

end



endmodule
