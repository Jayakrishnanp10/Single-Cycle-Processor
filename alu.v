module alu #(parameter n=32)
(
           input [n-1:0] x,y,                
           input [2:0] s,
           output [n-1:0] z, 
           output co,zero
    );
    reg [n-1:0] z1;
    assign z = z1; 
    reg carry,zero1;
assign co = carry;
assign zero = zero1;
    always @(*)

    begin
carry=0; // carry or borrow
zero1=0;

        case(s)
        3'b000: {carry,z1} = x + y; // A + B
        3'b001: {carry,z1} = x - y; // A + B
        3'b010: z1 = x & y; // A AND Bbar
        3'b011:  z1 = x | y; // A AND Bbar
         3'b101:  z1 = (x<y)?8'd1:8'd0; // SLT (set if less than)
          //default: z1 = 0 ; // default output zero
        endcase
if (z1==0) zero1=1'b1;

    end
endmodule


