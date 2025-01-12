module main_decoder(
    input Zero,
    input [6:0] op,
    output reg RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc,
    output reg [1:0] ImmSrc, ALUOp
);

    reg Branch;

    always @(Zero, op) begin
        // Default assignments
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        ResultSrc = 1'b0;
        ALUSrc = 1'b0;
        ImmSrc = 2'b00;
        ALUOp = 2'b00;
        Branch = 1'b0;
        PCSrc = 1'b0;

        case (op)
            7'b0000011: begin // Load Word (lw)
                RegWrite = 1'b1;
                ResultSrc = 1'b1;
                ALUSrc = 1'b1;
                ImmSrc = 2'b00;
                ALUOp = 2'b00;
            end
            7'b0100011: begin // Store Word (sw)
                MemWrite = 1'b1;
                ALUSrc = 1'b1;
                ImmSrc = 2'b01;
                ALUOp = 2'b00;
            end
            7'b0110011: begin // R-type
                RegWrite = 1'b1;
                ALUOp = 2'b10;
            end
            7'b1100011: begin // Branch (beq)
                Branch = 1'b1;
                ImmSrc = 2'b10;
                ALUOp = 2'b01;
            end
        endcase
        
        PCSrc = Zero & Branch; // Set PCSrc based on Zero and Branch signals
    end
endmodule