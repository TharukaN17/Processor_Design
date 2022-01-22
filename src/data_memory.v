module data_memory (
    input clk, write_en,
    input [15:0] address,
    input [7:0] data_in,
    output reg [7:0] data_out
    );

    reg [7:0] ram [65535:0];

    always @(posedge clk) begin
        if (write_en == 1)
            ram[address] <= data_in;
        else
            data_out <= ram[address];
    end
endmodule