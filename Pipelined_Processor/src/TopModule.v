module TopModule(
    input clk,
    input reset,
    output [7:0] result,
    output zero
);
    wire [7:0] pc,op1,op2;
    wire [17:0] instr;
    wire [1:0] fn;
    
    IM moduleIM(clk,reset,pc,instr);
    Decode moduleDecode(clk,instr,pc,op1,op2,fn);
    ALU moduleALU(clk,op1,op2,fn,result,zero);
endmodule