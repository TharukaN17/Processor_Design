module ALU (
    input clk,
    input [7:0] op1, op2,
    input [1:0] fn,
    output reg [7:0] result,
    output reg zero
);

always @(posedge clk)
begin
    case(fn)
        2'd0: result <= op1 + op2;
        2'd1: result <= op1 - op2;
        2'd2: result <= op1 * op2;
        2'd3: result <= op1 / op2;
        default: result = op1 + op2;
    endcase

    if (result == 0)
        zero <= 1;
    else
        zero <= 0;
end
endmodule