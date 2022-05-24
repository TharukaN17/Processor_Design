`timescale 1 ns / 1 ps

module tb_MainModule();
        reg clk, data_valid, instr_valid;
        reg [1:0] data_size, instr_size;
        reg [31:0] data_addr, instr_addr;
        
        wire interc_ready, data_valid_to_hart, instr_valid_to_hart;
        wire [31:0] data_out, instr_out;
        
        integer i;
        
    MainModule dut(clk,data_valid,instr_valid,data_size,instr_size,data_addr,instr_addr,interc_ready,
                   data_valid_to_hart,instr_valid_to_hart,data_out,instr_out);

    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end
    
    initial begin
        data_valid = 1'd1;
        instr_valid = 1'd1;
        data_size = 2'd0;
        instr_size = 2'd0;
        data_addr = 31'd2;
        instr_addr = 31'd5;
        for (i=0;i<20;i=i+1) begin
            #200;
        end
    end
endmodule