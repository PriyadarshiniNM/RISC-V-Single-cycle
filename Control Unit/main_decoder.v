module main_decoder(
    input Zero,
    input [6:0] op,
    output RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc,
    output [1:0] ImmSrc, ALUOp
);

    wire Branch;
    localparam [6:0] lw = 7'b0000011, sw = 7'b0100011, R_type = 7'b0110011, beq = 7'b1100011;

    assign RegWrite = ((op == lw) | (op == R_type)) ? 1'b1 : 1'b0;
    assign MemWrite = (op == sw) ? 1'b1 : 1'b0;
    assign ResultSrc = (op == lw) ? 1'b1 : 1'b0;
    assign ALUSrc = ((op == lw) | (op == sw)) ? 1'b1 : 1'b0;
    assign ImmSrc = (op == sw) ? 2'b01 : (op == beq) ? 2'b10 : 2'b00;
    assign ALUOp = (op == R_type) ? 2'b10 : (op == beq) ? 2'b01 : 2'b00;
    assign Branch = (op == beq); // Branch is high when `op` is `beq`
    assign PCSrc = Zero & Branch; // `PCSrc` is high when both `Zero` and `Branch` are true
endmodule