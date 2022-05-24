module MainModule (
    input clk, data_valid, instr_valid,
    input [1:0] data_size, instr_size,
    input [31:0] data_addr, instr_addr,
    output interc_ready, data_valid_to_hart, instr_valid_to_hart,
    output [31:0] data_out, instr_out
    );
    
    wire [1:0] size;
    wire [31:0] addr, received_data;
    
    Interconnector Interconnector(.clk(clk), .data_valid(data_valid), .instr_valid(instr_valid), 
                          .data_size(data_size), .instr_size(instr_size), .data_addr(data_addr), 
                          .instr_addr(instr_addr), .received_data(received_data), .interc_ready(interc_ready), 
                          .data_valid_to_hart(data_valid_to_hart), .instr_valid_to_hart(instr_valid_to_hart), 
                          .size(size), .data_out(data_out), .instr_out(instr_out), .addr(addr));

    Memory Memory(.clk(clk), .size(size), .addr(addr), .data_out(received_data));
endmodule