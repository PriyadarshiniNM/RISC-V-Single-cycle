module PC(PCNext, PC, rst, clk);
    input [31:0] PCNext;
    input clk, rst;
    output reg [31:0] PC;

    always @(posedge clk, posedge rst)
    begin
        if (rst)    
            PC <= 32'h00000000;
        else   
            PC <= PCNext;
    end
endmodule