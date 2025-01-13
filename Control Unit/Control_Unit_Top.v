module Control_Unit_Top(
    input Zero, op5, funct7,
    input [6:0] op,
    input [2:0] funct3,
    output RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
);

    wire [1:0] ALUOp;

    main_decoder u_main_decoder (
        .Zero(Zero),
        .op(op),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc),
        .ALUOp(ALUOp)
    );

    ALU_decoder u_ALU_decoder (
        .op5(op5),
        .funct7(funct7),
        .funct3(funct3),
        .ALUOp(ALUOp),
        .ALUControl(ALUControl)
    );

endmodule
