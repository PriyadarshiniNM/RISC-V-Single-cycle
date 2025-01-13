module Sign_Extend_tb;

    reg [31:0] In;
    reg [1:0] ImmSrc;
    wire [31:0] Imm_Ext;

    Sign_Extend uut (
        .In(In),
        .ImmSrc(ImmSrc),
        .Imm_Ext(Imm_Ext)
    );

    initial begin
        In = 32'b0;
        ImmSrc = 2'b00;

        // Test case 1: Immediate from I-type instruction (ImmSrc = 2'b00)
        #10 In = 32'b00000000000000000001010101011010; ImmSrc = 2'b00; // Test with positive number
        #10 In = 32'b11111111111111111111111111100000; ImmSrc = 2'b00; // Test with negative number

        // Test case 2: Immediate from S-type instruction (ImmSrc = 2'b01)
        #10 In = 32'b00000000000000000011010101011010; ImmSrc = 2'b01; // Test with positive number
        #10 In = 32'b11111111111111111100111111100000; ImmSrc = 2'b01; // Test with negative number

        // Test case 3: Immediate from B-type instruction (ImmSrc = 2'b10)
        #10 In = 32'b00000000000000000000010101011010; ImmSrc = 2'b10; // B-type (should be same as S-type for this case)
        #10 In = 32'b11111111111111111110111111100000; ImmSrc = 2'b10; // B-type with negative number

        #10 $finish;
    end

endmodule