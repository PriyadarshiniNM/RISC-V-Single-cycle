`timescale 1ns / 1ps

module Reg_file_tb;

    reg clk, rst, WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;

    wire [31:0] RD1, RD2;

    Reg_file uut (.clk(clk), .rst(rst), .WE3(WE3), .A1(A1), .A2(A2), 
        .A3(A3), .WD3(WD3), .RD1(RD1), .RD2(RD2));

    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;        rst = 0;        WE3 = 0;
        A1 = 0;        A2 = 0;        A3 = 0;         WD3 = 0;

        // Apply Reset
        rst = 1;
        #10;        rst = 0;
        
        // Write to register 1
        A3 = 5'd1;
        WD3 = 32'h12345678;
        WE3 = 1;
        #10;
        
        // Read from register 1
        A1 = 5'd1;
        WE3 = 0;
        #10;

        // Write to register 2
        A3 = 5'd2;
        WD3 = 32'h87654321;
        WE3 = 1;
        #10;

        // Read from register 2
        A2 = 5'd2;
        WE3 = 0;
        #10;

        // Check reading from zero register
        A1 = 5'd0;
        A2 = 5'd0;
        #10;

        // Test reset functionality again
        rst = 1;
        #10;
        rst = 0;
        #10;

        $finish;
    end
endmodule