`timescale 1 ns / 1 ps
//34152256
module tb_cpu();
	reg clk;
	reg [1:0] status;
	reg [15:0] addr;
	reg [7:0] data;
	
	wire end_process;
	wire [7:0] out;
	
	integer f;
	reg [7:0] read_data [0:65535];
	
	cpu dut(clk, status, data, addr, end_process, out);
	
	initial begin
        clk = 0;
        forever clk = #(50) ~clk;
    end
    
    initial begin
        $readmemb("image.txt", read_data);
        f = $fopen("output.txt", "w");
        status = 2'b10;
    end
    
    integer i;
    initial begin
        for (i=0;i<256*256;i=i+1) begin
            addr = i;
            data = read_data[i];
            #100;
        end
        status = 2'b01;
        #100;
        while (end_process != 1'b1) begin
            #100;
        end
        #100
        status = 2'b11;
        for (i=0;i<64*64;i=i+1) begin
            addr = i;
            #100
            $fwrite(f, "%d\n", out);
        end
        #100
        $fclose(f);
    end 
endmodule