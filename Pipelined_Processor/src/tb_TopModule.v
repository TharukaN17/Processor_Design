`timescale 1 ns / 1 ps

module tb_TopModule();
        reg clk;

        wire [7:0] result;
        wire zero;
        
        integer i;
        
    TopModule dut(clk,result,zero);

    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end

    initial begin
        for (i=0;i<20;i=i+1) begin
            #200;
        end
    end
endmodule