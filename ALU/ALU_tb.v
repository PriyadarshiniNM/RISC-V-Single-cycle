module ALU_tb;
    reg [31:0] A, B;
    reg [2:0] ALUControl;
    wire [31:0] Result;
    wire Z, N, V, C;

    ALU uut (.A(A),.B(B),.ALUControl(ALUControl),.Result(Result), .Z(Z), .N(N), .V(V), .C(C));

    initial begin
        // Test Case 1: Addition
        A = 32'd10;
        B = 32'd20;
        ALUControl = 3'b000;
        #10;
        
        // Test Case 2: Subtraction
        A = 32'd30;
        B = 32'd10;
        ALUControl = 3'b001;
        #10;
        
        // Test Case 3: AND operation
        A = 32'hFFFF0000;
        B = 32'h0000FFFF;
        ALUControl = 3'b010;
        #10;
        
        // Test Case 4: OR operation
        A = 32'hFFFF0000;
        B = 32'h0000FFFF;
        ALUControl = 3'b011;
        #10;
       
        // Test Case 5: Set on Less Than (SLT)
        A = 32'd10;
        B = 32'd20;
        ALUControl = 3'b101;
        #10;
        
        // Test Case 6: Zero flag check
        A = 32'd0;
        B = 32'd0;
        ALUControl = 3'b000;
        #10;

        // Test Case 7: Negative flag check
        A = -32'd10;
        B = 32'd5;
        ALUControl = 3'b000;
        #10;

        // Test Case 8: Overflow flag check
        A = 32'h7FFFFFFF;
        B = 32'd1;
        ALUControl = 3'b000;
        #10;

        // Test Case 9: Carry flag check
        A = 32'h7FFFFFFF;
        B = 32'd1;
        ALUControl = 3'b000;
        #10;
        
        A = 32'hFFFFFFFF;
        B = 32'd1;
        ALUControl = 3'b000;
        #10;
        $finish;
    end
endmodule