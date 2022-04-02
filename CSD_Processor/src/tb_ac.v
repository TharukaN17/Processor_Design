`timescale 1 ns / 1 ps

module tb_ac();
	reg clk, write_en, alu_to_ac, inc_en;
	reg [15:0] data_in, alu_out;
	
	wire [15:0] data_out;
	
	ac dut(clk, write_en, alu_to_ac, inc_en, data_in, alu_out, data_out);
	
	initial begin
        clk = 0;
        forever clk = #(50) ~clk;
    end
	
	initial begin
	write_en = 0;
	alu_to_ac = 0;
	inc_en = 0;
	data_in = 0;
	alu_out = 0;
	end
	
	initial begin
	#100
	inc_en = 1;
	#500
	inc_en = 0;
	data_in = 75;
	write_en = 1;
	#100
	write_en = 0;
	alu_out = 56;
	alu_to_ac = 1;
	#100;
	end

endmodule