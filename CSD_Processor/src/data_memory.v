module data_memory (
    input clk, write_en,
    input [15:0] addr, data_in, ext_addr,
    output reg [7:0] data_out, ext_out
    );

    reg [7:0] ram [65535:0];

    always @(posedge clk) begin
        if (write_en == 1)
            ram[addr] <= data_in;
        else
            data_out <= ram[addr];
            ext_out <= ram[ext_addr];
    end
endmodule