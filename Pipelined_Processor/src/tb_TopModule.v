`timescale 1 ns / 1 ps

module tb_TopModule();
        reg clk;
        reg reset;

        wire [7:0] result;
        wire zero;
        
        integer i;
        
    TopModule dut(clk,reset,result,zero);

    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end
    
    initial begin
        reset = 1;
        #200;
        reset = 0;
        #200;
        for (i=0;i<20;i=i+1) begin
            #200;
        end
    end
endmodule