`timescale 1 ns / 1 ps

module tb_ALU();
        reg clk;
        reg [7:0] op1,op2;
        reg [1:0] fn;

        wire [7:0] result;
        wire zero;

    ALU dut(clk,op1,op2,fn,result,zero);

    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end
    
    initial begin
       op1 = 0;
       op2 = 0;
       fn = 0;
    end
    
    initial begin
       #200
       op1 = 2;
       op2 = 4;
       fn = 1; 
       #200;
       op1 = 5;
       op2 = 3;
       fn = 2;
       #200
       op1 = 1;
       op2 = 3;
       fn = 3;
    end
endmodule