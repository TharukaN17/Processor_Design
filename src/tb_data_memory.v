`timescale 1 ns / 1 ps

module tb_data_memory();
    reg clk, write_en;
    reg [15:0] address;
    reg [7:0] data_in;

    wire [7:0] data_out;

    data_memory dut(clk,write_en,address,data_in,data_out);
    
    initial begin
        clk = 0;
        forever clk = #(100) ~clk;
    end
    
    initial begin
    
    write_en = 0;
    address = 0;
    data_in = 0;
    
    #200
    write_en = 1;
    address = 2;
    data_in = 25;
    
    #200
    write_en = 0;
    address = 2;
    
    #200
    write_en = 1;
    address = 5;
    data_in = 50;
    
    #200
    write_en = 0;
    address = 5;
    
    #200;
    end
endmodule