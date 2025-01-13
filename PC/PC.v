module PC(PCNext, pc, rst, clk);
    input [31:0] PCNext;
    input clk, rst;
    output reg [31:0] pc;

    always @(posedge clk, posedge rst)
    begin
        if (rst)    
            pc <= 32'h00000000;
        else   
            pc <= PCNext;
    end
endmodule