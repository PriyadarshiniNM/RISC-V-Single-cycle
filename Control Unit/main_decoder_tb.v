module main_decoder_tb;
    reg Zero;
    reg [6:0] op;
    wire RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc;
    wire [1:0] ImmSrc, ALUOp;

    main_decoder uut (.Zero(Zero), .op(op), .RegWrite(RegWrite), .MemWrite(MemWrite),
        .ResultSrc(ResultSrc), .ALUSrc(ALUSrc), .PCSrc(PCSrc),.ImmSrc(ImmSrc), .ALUOp(ALUOp));

    initial begin
        // Test Case 1: lw (Load Word)
        op = 7'b0000011; Zero = 0; #10;
       
        // Test Case 2: sw (Store Word)
        op = 7'b0100011; Zero = 0; #10;
        
        // Test Case 3: R-type (Arithmetic/Logical Instructions)
        op = 7'b0110011; Zero = 0; #10;
        
        // Test Case 4: beq (Branch if Equal, Zero = 0)
        op = 7'b1100011; Zero = 0; #10;
        
        // Test Case 5: beq (Branch if Equal, Zero = 1)
        op = 7'b1100011; Zero = 1; #10;
        
        $finsih;
    end
endmodule