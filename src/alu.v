module alu (
    input [7:0] in1, in2,
    input [2:0] sel,
    output reg [7:0] out,
    output reg Z
);

always @(in1 or in2 or sel)
begin
    case(sel)
        3'b000: out = in1 + in2;
        3'b010: out = in1 - in2;
        3'b011: out = in1 & in2;
        3'b100: out = in1 | in2;
        3'b101: out = in1 ^ in2;
        3'b110: out = in1 << in2;
        3'b111: out = in1 >> in2;
        default: out = in1 + in2;
    endcase

    if (out == 0)
        Z = 1;
    else
        Z = 0;
end
endmodule