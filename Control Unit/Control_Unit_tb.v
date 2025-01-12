module control_unit_tb;

    reg Zero, op5, funct7;
    reg [6:0] op;
    reg [2:0] funct3;
    wire RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;

    Control_Unit uut (.Zero(Zero), .op(op), .funct3(funct3), .op5(op5), .funct7(funct7), .RegWrite(RegWrite), .MemWrite(MemWrite),
        .ResultSrc(ResultSrc), .ALUSrc(ALUSrc), .PCSrc(PCSrc), .ImmSrc(ImmSrc), .ALUControl(ALUControl));

    initial begin
        // Initial inputs
        Zero = 0;
        op = 7'b0000000;
        funct3 = 3'b000;
        op5 = 0;
        funct7 = 0;

        // Test Load Word (lw)
        #10 op = 7'b0000011; funct3 = 3'b000; // lw
        #10;

        // Test Store Word (sw)
        op = 7'b0100011; funct3 = 3'b000; // sw
        #10;

        // Test R-type ADD
        op = 7'b0110011; funct3 = 3'b000; op5 = 0; funct7 = 0; // ADD
        #10;

        // Test R-type SUB
        op = 7'b0110011; funct3 = 3'b000; op5 = 1; funct7 = 1; // SUB
        #10;

        // Test R-type SLT
        op = 7'b0110011; funct3 = 3'b010; // SLT
        #10;

        // Test R-type OR
        op = 7'b0110011; funct3 = 3'b110; // OR
        #10;

        // Test R-type AND
        op = 7'b0110011; funct3 = 3'b111; // AND
        #10;

        // Test Branch (beq)
        op = 7'b1100011; funct3 = 3'b000; Zero = 1; // beq, branch taken
        #10 Zero = 0; // beq, branch not taken
        #10;

        $finish;
    end
endmodule
