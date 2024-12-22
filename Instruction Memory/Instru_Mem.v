module Instr_Mem(rst, PC, RD );
    input [31:0] PC;
    input rst;
    output reg [31:0] RD;

    //Memory Creation 
    reg [31:0] Mem [1023:0];

    always @ (PC) 
    begin
        RD <= (rst) ? 32'd0: Mem[PC(31:2)];
    end
endmodule 