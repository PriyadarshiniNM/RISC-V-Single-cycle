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

    /*
  initial begin
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00832383;
    // mem[0] = 32'h0064A423;
    // mem[1] = 32'h00B62423;
    mem[0] = 32'h0062E233;
    // mem[1] = 32'h00B62423;

  end
*/
endmodule 