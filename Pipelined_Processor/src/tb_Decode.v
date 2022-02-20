`timescale 1 ns / 1 ps

module tb_Decode();
        reg clk;
        reg [17:0] instr;

        wire [7:0] pc,op1,op2;
        wire [1:0] fn;

    Decode dut(clk,instr,pc,op1,op2,fn);

    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end
    
    initial begin
       instr = 0;
    end
    
    initial begin
       #200
       instr = 104056; 
       
       #200;
       instr = 131604;
       
       #200
       instr = 222233;
       
       #200;
    end
endmodule