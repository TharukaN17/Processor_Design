`timescale 1 ns / 1 ps
//34152256
module tb_cpu();
	reg clk;
	reg [1:0] status;
	reg [15:0] addr;
	
	wire end_process;
	wire [7:0] out;
	
	integer f;
	
	cpu dut(clk, status, addr, end_process, out);
	
	initial begin
        clk = 0;
        forever clk = #(50) ~clk;
    end
    
    initial begin
        f = $fopen("outim.txt", "w");
        status = 2'b01;
    end
    
    integer i;
    initial begin
        for (i=0;i<34152256;i=i+1) begin
            #100;
        end
        status = 2'b00;
        for (i=0;i<256*256;i=i+1) begin
            addr = i;
            #100
            $fwrite(f, "%d\n", out);
        end
        #100
        $fclose(f);
    end 
endmodule