module MUX2x1(input s,//select line 
input [31:0] a, b, 
output reg [31:0] c);

    always@(s, a, b)
    begin
        c <= s ? b : a ;
    end
endmodule