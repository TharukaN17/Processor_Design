module Memory (
    input clk,
    input [1:0] size,
    input [31:0] addr,
    output reg [31:0] data_out
    );

    reg [31:0] ram [31:0];

    initial begin
        ram[0] = 31'd10;
        ram[1] = 31'd20;
        ram[2] = 31'd30;
        ram[3] = 31'd40;
        ram[4] = 31'd50;
        ram[5] = 31'd60;
        ram[6] = 31'd70;
        ram[7] = 31'd80;
        ram[8] = 31'd90;
        ram[9] = 31'd100;
    end
    
    always @(posedge clk) begin
        data_out <= ram[addr];
    end
endmodule