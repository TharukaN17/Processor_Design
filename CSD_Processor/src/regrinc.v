module regrinc (
    input clk, write_en,
    input [15:0] data_in,
    output reg [15:0] data_out = 16'd0,
    input inc_en
    );
    
    always @(posedge clk) begin
        if (write_en == 1)
            data_out <= data_in;
        if (inc_en == 1)
            data_out <= data_out + 16'd1;
    end
endmodule