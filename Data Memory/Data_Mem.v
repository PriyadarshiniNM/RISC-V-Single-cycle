module Data_Mem(input clk,rst, WE, 
input [31:0] A, WD, 
output reg [31:0] RD);

reg [31:0] Data_Memory [1023:0];

always@(posedge clk)
begin
    if (~WE)
        RD <= Data_Memory[A];//Read
    else if (WE)
        Data_Memory[A] <= WD;//Write
    else if (rst)
        RD <= 32'h00000000;//reset       
end
endmodule