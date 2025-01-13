module Instr_Mem(rst, PC, RD);
    input [31:0] PC;
    input rst;
    output reg [31:0] RD;

    //Memory Creation 
    reg [31:0] Mem [1023:0];

    always @ (PC) 
    begin
        RD <= rst ? 32'd0: Mem[PC[31:2]];
    end

  module Instr_Mem(rst, PC, RD);
    input [31:0] PC;
    input rst;
    output reg [31:0] RD;

    //Memory Creation 
    reg [31:0] Mem [1023:0];

    always @ (PC) 
    begin
        RD <= rst ? 32'd0: Mem[PC[31:2]];
    end
    
  initial begin
    Mem[0] = 32'hFFC4A303;
    //Mem[1] = 32'h00832383;
    // Mem[0] = 32'h0064A423;
    // Mem[1] = 32'h00B62423;
    //Mem[0] = 32'h0062E233;
    // Mem[1] = 32'h00B62423;
  end
endmodule 