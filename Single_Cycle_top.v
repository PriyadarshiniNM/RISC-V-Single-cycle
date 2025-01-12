`include "PC.v"
`include "Instru_Mem.v"
`include "Reg_file.v"
`include "Sign_Extend.v"

module Single_Cycle_top(input clk, rst);
    
    wire [31:0] PC_top, RD_Instr;

    PC pc1 (.PCNext(PCNext), .PC(PC_top), .rst(rst), .clk(clk));

    Instr_Mem Instruction_Memory (.rst(rst), .PC(PC_top), .RD());

    Reg_file Register_file(.clk(clk), .rst(rst), .WE3(), .A1(RD_Instr[19:15]), .A2(), .A3(),
    .WD3(), .RD1(), .RD2());

    Sign_Extend Sign_Extend(.In(RD_Instr[31:7]), .Imm_Ext());

endmodule