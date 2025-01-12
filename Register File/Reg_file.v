//A1, A2, A3 - Addresses of register to be read from the register file
//A3 - address to which data(WD3) needs to be written
//Data from address A3 is read from RD2
//WE3 - Write Enable
module Reg_file (
    input clk, rst, WE3, 
    input [4:0] A1, A2, A3, 
    input [31:0] WD3, 
    output reg [31:0] RD1, RD2
);

    reg [31:0] Register [31:0]; // Register file with 32 registers, each 32 bits wide
    integer i;
    
    // Read Block
    always @ (posedge clk) begin
        RD1 <= Register[A1];
        RD2 <= Register[A2];
    end

    // Write and Reset Block
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                Register[i] <= 32'd0; // Reset all registers to 0 on reset
            end
        end 
        else if (WE3 && A3 != 5'h00) begin
            Register[A3] <= WD3;
        end
    end

endmodule