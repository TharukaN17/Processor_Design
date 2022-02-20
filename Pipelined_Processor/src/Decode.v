module Decode (
    input clk,
    input [17:0] instr,
    output reg [7:0] pc,op1,op2,
    output reg [1:0] fn
);

reg [17:0] fetchedInstr;
reg [7:0] pcReg = 0;

always @(posedge clk)
begin
    fetchedInstr <= instr;
    pcReg <= pcReg + 1;
    pc <= pcReg;
    fn <= fetchedInstr[17:16];
    op1 <= fetchedInstr[15:8];
    op2 <= fetchedInstr[7:0];
end
endmodule