module ALU_decoder_tb;
    reg op5, funct7;
    reg [2:0] funct3;
    reg [1:0] ALUOp;
    wire [2:0] ALUControl;

    // Instantiate the ALU_decoder module
    ALU_decoder uut (.op5(op5), .funct7(funct7), .funct3(funct3), .ALUOp(ALUOp),
        .ALUControl(ALUControl));

    initial begin
        // Test Load/Store (ALUOp = lw_sw, ALUControl = add)
        ALUOp = 2'b00; // lw_sw
        op5 = 0; funct7 = 0; funct3 = 3'b000; #10;
        
        // Test BEQ (ALUOp = beq, ALUControl = sub)
        ALUOp = 2'b01; // beq
        op5 = 0; funct7 = 0; funct3 = 3'b000; #10;

        // Test R-type Arithmetic (ALUOp = arithmetic)
        ALUOp = 2'b10; // arithmetic
        
        // Case 1: ADD (funct3 = 3'b000, op5 = 0, funct7 = 0)
        op5 = 0; funct7 = 0; funct3 = 3'b000; #10;

        // Case 2: SUB (funct3 = 3'b000, op5 = 1, funct7 = 1)
        op5 = 1; funct7 = 1; funct3 = 3'b000; #10;

        // Case 3: SLT (funct3 = 3'b010)
        op5 = 0; funct7 = 0; funct3 = 3'b010; #10;   

        // Case 4: OR (funct3 = 3'b110)
        op5 = 0; funct7 = 0; funct3 = 3'b110; #10;
        
        // Case 5: AND (funct3 = 3'b111)
        op5 = 0; funct7 = 0; funct3 = 3'b111; #10;

        $finish;
    end
endmodule