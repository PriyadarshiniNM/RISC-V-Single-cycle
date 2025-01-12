module control_unit(
    input Zero, op5, funct7,
    input [6:0] op,
    input [2:0] funct3,
    output reg RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc,
    output reg [1:0] ImmSrc,
    output reg [2:0] ALUControl
);
    reg Branch;
    reg [1:0] ALUOp;
    wire [1:0] concat = {op5, funct7};
    localparam [2:0] add = 3'b000, sub = 3'b001, slt = 3'b101, orr = 3'b011, andd = 3'b010;
        

    // Main Decoder logic
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

    // ALU Decoder logic
    always @(op5, funct7, funct3, ALUOp) begin
        case (ALUOp)
            2'b00: ALUControl = add;                 // Load/Store operations use addition
            2'b01: ALUControl = sub;                 // Branch instructions use subtraction
            2'b10: begin                             // Arithmetic operations
                case (funct3)
                    3'b000: ALUControl = (concat == 2'b11) ? sub : add; // ADD/SUB
                    3'b010: ALUControl = slt;         // SLT
                    3'b110: ALUControl = orr;         // OR
                    3'b111: ALUControl = andd;        // AND
                    default: ALUControl = add;        // Default to addition
                endcase
            end
            default: ALUControl = 3'b000;            // Default value
        endcase
    end
endmodule