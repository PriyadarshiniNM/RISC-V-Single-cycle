module ALU (
    input [31:0] A, B,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output Z, N, V, C
);

    reg cout;
    reg [31:0] B_comp;  // Complement of B for subtraction or SLT

    always @(A, B, ALUControl) begin
        // Precompute B complement for subtraction and SLT
        B_comp = (ALUControl == 3'b001) ? ~B + 1 : B;

        case (ALUControl)
            3'b000: {cout, Result} = A + B;           // ADD
            3'b001: {cout, Result} = A + B_comp;      // SUB
            3'b010: Result = A & B;                   // AND
            3'b011: Result = A | B;                   // OR
            3'b101: Result = (A < B) ? 32'b1 : 32'b0; // SLT
            default: Result = 32'b0;                  // Default
        endcase
    end

    // Assign flags
    assign Z = (Result == 32'b0);
    assign N = Result[31];
    assign C = (ALUControl == 3'b000 || ALUControl == 3'b001) ? cout : 1'b0;
    assign V = (ALUControl == 3'b000 || ALUControl == 3'b001) &&
               (A[31] == B_comp[31]) && (Result[31] != A[31]);

endmodule