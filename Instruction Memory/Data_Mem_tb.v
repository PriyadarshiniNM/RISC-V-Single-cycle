module Data_Mem_tb();
    reg clk, WE;
    reg [31:0] A, WD;
    wire [31:0] RD;
    
    Data_Mem uut (.clk(clk), .WE(WE), .A(A), .WD(WD), .RD(RD));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        WE = 0; A = 0;  WD = 0;    #10;
        A = 10;  WD = 32'hDEADBEEF;  WE = 1; #10;
        WE = 0; #10;
        A = 20; WD = 32'hCAFEBABE;  WE = 1; #10;
        WE = 0; A = 20; #10;
        WE = 0; A = 30; #10;
        $finish;
    end
endmodule