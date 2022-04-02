`timescale 1 ns / 1 ps

module tb_data_memory();
    reg clk, write_en;
    reg [15:0] addr,data_in;

    wire [7:0] data_out;

    data_memory dut(clk, write_en, addr, data_in, data_out);
    
    initial begin
        clk = 0;
        forever clk = #(50) ~clk;
    end
    
    initial begin 
    write_en = 0;
    addr = 0;
    data_in = 0;
	end
	
	initial begin
    #100
    write_en = 1;
    addr = 2;
    data_in = 25;
    #100
    write_en = 0;
    addr = 2;
    #100
    write_en = 1;
    addr = 5;
    data_in = 50;
    #100
    write_en = 0;
    addr = 5;
    #100;
    end
endmodule