`timescale 1 ns / 1 ps

module tb_alu;
        reg [7:0] in1,in2;
        reg [2:0] sel;

        wire [7:0] out;
        wire Z;

    alu dut(in1,in2,sel,out,Z);

    initial begin
       in1 = 0;
       in2 = 0;
       sel = 0;
    end
    
    initial begin
       #200
       in1 = 2;
       in2 = 4;
       sel = 3'b000; 
       #100;
       in1 = 5;
       in2 = 3;
       sel = 3'b000;
       #300
       in1 = 1;
       in2 = 3;
       sel = 3'b100;
    end
endmodule