module Single_Cycle_Top_tb;

    reg clk, rst;
    
    Single_Cycle_Top uut (.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        clk = 0;    rst = 1;

        #20;
        rst = 0;

        // Run the simulation for a certain period
        #200;
        
        $finish;
    end
endmodule