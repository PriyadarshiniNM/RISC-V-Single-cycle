`include "PC.v"
`include "Instru_Mem.v"
`include "Reg_file.v"
`include "Sign_Extend.v"
`include "Control_Unit_Top.v"
`include "Data_Mem.v"
`include "PC_Adder.v"
`include "MUX2x1.v"

module Single_Cycle_top(input clk, rst);
    
    wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top, ALUControl_Top, ALUResult, ReadData, PCPlus4, WriteData, SrcB;
    wire RegWrite, MemWrite;

    PC pc1 (.PCNext(PCNext), .PC(PC_Top), .rst(rst), .clk(clk));

    PC_Adder PC_Adder(.a(PC), .b(32'd4), .c(PCPlus4));

    Instr_Mem Instruction_Memory (.rst(rst), .PC(PC_Top), .RD(RD_Instr));

    Reg_file Register_file(.clk(clk), .rst(rst), .WE3(RegWrite), .A1(RD_Instr[19:15]), .A2(RD_Instr[24:20]), 
    .A3(RD_Instr[11:7]), .WD3(ReadData), .RD1(RD1_Top), .RD2(WriteData));

    MUX2X1 MUX2X1(.s(ALUSrc_Top), .a(WriteData), .b(Imm_Ext_Top), .c(SrcB));
    
    Sign_Extend Sign_Extend(.In(RD_Instr[31:7]), .Imm_Ext(Imm_Ext_Top));

    ALU ALU(.A(RD1_Top), .B(SrcB), .ALUControl(ALUControl_Top), .Result(ALUResult), .Z(RD_Instr[]), .N(.RD_Instr[31]), .V(V), .C(RD_Instr[]));

    Control_Unit_Top Control_Unit(.Zero(Zero), .op(RD_Instr[6:0]), .funct3(RD_Instr[14:12]), .op5(), .funct7(RD_Instr[30]), 
    .RegWrite(RegWrite), .MemWrite(MemWrite), .ResultSrc(), .ALUSrc(), .PCSrc(),.ImmSrc(), .ALUControl(ALUControl_Top));

    Data_Mem Data_Memory(.clk(clk), .rst(rst), .WE(ALUControl_Top), .A(ALUResult), .WD(WriteData),.RD(ReadData));

    
endmodule