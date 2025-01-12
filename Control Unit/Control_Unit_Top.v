module control_unit(
    input Zero,
    input [6:0] op,
    input [2:0] funct3,
    input op5,
    input funct7,
    output RegWrite,
    output MemWrite,
    output ResultSrc,
    output ALUSrc,
    output PCSrc,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
);

    // Internal signals
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
