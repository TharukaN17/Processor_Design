`timescale 1 ns / 1 ps

module tb_IM();
    reg clk;
    reg [7:0] pc;

    wire [17:0] instr;

    IM dut(clk,pc,instr);
    
    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end
    
    initial begin
    
    pc = 0;
    
    #200
    pc = 1;

    
    #200
    pc = 2;

    
    #200
    pc = 3;

    
    #200
    pc = 4;
    
    #200;
    end
endmodule