`include "PC.v"
`include "Instr_Mem.v"
`include "Reg_file.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Mem.v"
`include "PC_Adder.v"
`include "MUX2x1.v"

module Single_Cycle_Top(input clk, rst);
    
    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite,MemWrite,ALUSrc,ResultSrc, Z_Top;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;

    //MUX2X1 MUX0(.s(PC_Src_Top), .a(RD2_Top), .b(Imm_Ext_Top), .c(SrcB));
    
    PC PC(.PCNext(PCPlus4), .PC(PC_Top), .rst(rst), .clk(clk));

    PC_Adder PC_Adder(.a(PC), .b(32'd4), .c(PCPlus4));

    Instr_Mem Instruction_Memory (.rst(rst), .PC(PC_Top), .RD(RD_Instr));

    Reg_file Register_file(.clk(clk), .rst(rst), .WE3(RegWrite), .A1(RD_Instr[19:15]), .A2(RD_Instr[24:20]), 
    .A3(RD_Instr[11:7]), .WD3(Result), .RD1(RD1_Top), .RD2(RD2_Top));

    Sign_Extend Sign_Extend(.In(RD_Instr[31:7]), .ImmSrc(ImmSrc), .Imm_Ext(Imm_Ext_Top));

    MUX2X1 Mux_Reg_to_ALU(.s(ALUSrc), .a(RD2_Top), .b(Imm_Ext_Top), .c(SrcB));

    ALU ALU(.A(RD1_Top), .B(SrcB), .ALUControl(ALUControl_Top), .Result(ALUResult), .Z(Z_Top), .N(RD_Instr[31]), .V(RD_Instr[29]), .C(RD_Instr[30]));

    Control_Unit_Top Control_Unit(.Zero(Z_Top), .op(RD_Instr[6:0]), .funct3(RD_Instr[14:12]), .op5(RD_Instr[5]), .funct7(RD_Instr[30]), 
    .RegWrite(RegWrite), .MemWrite(MemWrite), .ResultSrc(ResultSrc_Top), .ALUSrc(ALUSrc_Top), .PCSrc(PC_Src_Top),.ImmSrc(), .ALUControl(ALUControl_Top));

    Data_Mem Data_Memory(.clk(clk), .rst(rst), .WE(MemWrite), .A(ALUResult), .WD(RD2_Top),.RD(ReadData));

    MUX2X1 Mux_DataMem_to_Reg(.s(ResultSrc), .a(ALUResult), .b(ReadData), .c(Result));
endmodule