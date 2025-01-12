module Sign_Extend(input [24:0] In,
output reg [31:0] Imm_Ext);

    always @(In)
    begin
        Imm_Ext <= In[24] ? {{7{1'b1}},In} : {{7{1'b0}}, In};
    end
endmodule