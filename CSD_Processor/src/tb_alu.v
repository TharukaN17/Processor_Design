`timescale 1 ns / 1 ps

module tb_alu();
        reg clk;
        reg [15:0] in1, in2;
        reg [2:0] alu_op;

        wire [15:0] alu_out, z;

    alu dut(clk, in1, in2, alu_op, alu_out, z);
    
    initial begin
        clk = 0;
        forever clk = #(50) ~clk;
    end

    initial begin
       in1 	  = 0;
       in2 	  = 0;
       alu_op = 0;
    end
    
    initial begin
       #100;
       in1    = 2;
       in2    = 4;
       alu_op = 3'd1; 
       #100;
       in1    = 5;
       in2    = 3;
       alu_op = 3'd2;
       #100;
       in1    = 4;
       in2    = 2;
       alu_op = 3'd3;
       #100;
       in1    = 16;
       in2    = 2;
       alu_op = 3'd4;
       #100;
    end
endmodule