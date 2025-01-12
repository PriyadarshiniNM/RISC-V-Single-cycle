module Sign_Extend_tb;

    reg [24:0] In;
    wire [31:0] Imm_Ext;

    Sign_Extend uut (
        .In(In),
        .Imm_Ext(Imm_Ext)
    );

    initial begin
        // Test case 1: Zero input
        In = 25'b0000000000000000000000000;
        #10;

        // Test case 2: Positive input (LSB 0)
        In = 25'b0000000000000000000000010;
        #10;

        // Test case 3: Positive input (MSB 0)
        In = 25'b0111111111111111111111111;
        #10;

        // Test case 4: Negative input (MSB 1)
        In = 25'b1111111111111111111111111;
        #10;

        // Test case 5: Negative input with non-zero lower bits
        In = 25'b1000000000000000000000001;
        #10;

        // Test case 6: Middle range input
        In = 25'b0000000111111111111111111;
        #10;

        // Test case 7: Another negative input
        In = 25'b1000000000000000000000010;
        #10;

        $finish;
    end
endmodule