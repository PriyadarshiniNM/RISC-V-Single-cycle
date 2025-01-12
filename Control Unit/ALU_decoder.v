module ALU_decoder(
    input op5, funct7, 
    input [2:0] funct3,
    input [1:0] ALUOp, 
    output reg [2:0] ALUControl
);
    wire [1:0] concat;
    localparam [1:0] lw_sw = 2'b00, beq = 2'b01, arithmetic = 2'b10;
    localparam [2:0] add = 3'b000, sub = 3'b001, slt = 3'b101, orr = 3'b011, andd = 3'b010; //slt - set less than

    // Concatenation of op5 and funct7 into a 2-bit signal
    assign concat = {op5, funct7};

    always @(op5. funct7, funct3, ALUOp) begin
        case (ALUOp)
            lw_sw: ALUControl = add;                // Load/Store operations use addition
            beq: ALUControl = sub;                  // Branch instructions use subtraction
            arithmetic: begin
                case (funct3)
                    3'b000: ALUControl = (concat == 2'b11) ? sub : add; // R-type: ADD/SUB
                    3'b010: ALUControl = slt;        // SLT (Set Less Than)
                    3'b110: ALUControl = orr;        // OR operation
                    3'b111: ALUControl = andd;       // AND operation
                    default: ALUControl = add;       // Default to addition
                endcase
            end
            default: ALUControl = 3'b000;           // Default value
        endcase
    end
endmodule