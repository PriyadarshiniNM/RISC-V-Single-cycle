module PC_tb;
    reg [31:0] PCNext;
    reg clk, rst;
    wire [31:0] PC;

    PC uut (.PCNext(PCNext), .clk(clk), .rst(rst), .PC(PC));

    initial 
    begin
        rst = 1'b1; PCNext = 32'h00000000; #10
        rst = 1'b0; PCNext = 32'h234567AB; #10
        PCNext = 32'h00003697;  #10
        $finish;
    end

    initial clk = 1'b1;
    always #5 clk = ~clk;
endmodule