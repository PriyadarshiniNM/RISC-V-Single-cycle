module Instr_Mem_tb;
    reg [31:0] PC;
    reg rst;
    wire [31:0] RD;

    Instr_Mem uut (.PC(PC), .rst(rst), .RD(RD););

    initial 
    begin
        rst = 1'b1; PC = 32'hABCD8745; 
        #10 rst = 1'b0; PC = 32'hABCD8745;
        #30 $finish
    end
endmodule