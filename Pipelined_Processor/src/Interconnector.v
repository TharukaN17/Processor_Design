module Interconnector (
    input             clk, data_valid, instr_valid,
    input      [1:0]  data_size, instr_size,
    input      [31:0] data_addr, instr_addr, received_data,
    output reg        interc_ready, data_valid_to_hart, instr_valid_to_hart,
    output reg [1:0]  size,
    output reg [31:0] data_out, instr_out, addr
);

    reg [2:0]  present = 3'd0;
    reg [2:0]  next    = 3'd0;
    
    reg [31:0] data_buf;
    reg [31:0] instr_buf;
    reg [31:0] received_data_buf;
    reg [1:0]  data_size_buf;
    reg [1:0]  instr_size_buf;
    reg        is_data_buf;
    reg        is_instr_buf;
    reg        is_data_req;
    reg        is_instr_req;

    parameter
    interconnect_ready                  = 3'd0,
    send_data_request_to_memory         = 3'd1,
    send_instruction_request_to_memory  = 3'd2,
    buffer_both_requests                = 3'd3,
    get_data                            = 3'd4,
    get_datax                           = 3'd5,
    send_data_to_hart                   = 3'd6,
    send_instruction_to_hart            = 3'd7;
    
    always @(posedge clk)
        present <= next;

    always @(present, data_valid, instr_valid)
    case(present)
        interconnect_ready: begin
            interc_ready <= 1'd1;
            if (data_valid == 1'd1 && instr_valid == 1'd0)
                next <= send_data_request_to_memory;
            else if (data_valid == 1'd0 && instr_valid == 1'd1)
                next <= send_instruction_request_to_memory;
            else if (data_valid == 1'd1 && instr_valid == 1'd1)
                next <= buffer_both_requests;
        end
        
        send_data_request_to_memory: begin
            data_valid_to_hart <= 1'd0;
            interc_ready <= 1'd0;
            if (is_data_buf == 1'd1) begin
                is_data_buf <= 1'd0;
                addr <= data_buf;
                size <= data_size_buf;
            end
            else begin
                addr <= data_addr;
                size <= data_size;
            end
            is_data_req <= 1'd1;
            next        <= get_data; 
        end
        
        send_instruction_request_to_memory: begin
            instr_valid_to_hart <= 1'd0;
            interc_ready        <= 1'd0;
            if (is_instr_buf == 1'd1) begin
                is_instr_buf <= 1'd0;
                addr <= instr_buf;
                size <= instr_size_buf;
            end
            else begin
                addr <= instr_addr;
                size <= instr_size;
            end
            is_instr_req        <= 1'd1;
            next                <= get_data;
        end
        
        buffer_both_requests: begin
            interc_ready   <= 1'd0;
            data_buf       <= data_addr;
            instr_buf      <= instr_addr;
            data_size_buf  <= data_size;
            instr_size_buf <= instr_size;
            is_data_buf    <= 1'd1;
            is_instr_buf    <= 1'd1;
            next           <= send_data_request_to_memory;
        end
        
        get_data: begin
            next <= get_datax;
        end
        
        get_datax: begin
            received_data_buf <= received_data;
            if (is_data_req == 1'd1) begin
                is_data_req <= 1'd0;
                next <= send_data_to_hart;
            end
            else if (is_instr_req == 1'd1) begin
                is_instr_req <= 1'd0;
                next         <= send_instruction_to_hart;
                end       
        end
        
        send_data_to_hart: begin
            data_valid_to_hart <= 1'd1;
            data_out           <= received_data_buf;
            if (is_instr_buf == 1'd1)
               next <= send_instruction_request_to_memory; 
            else
               next <= interconnect_ready;
        end
        
        send_instruction_to_hart: begin
            instr_valid_to_hart <= 1'd1;
            instr_out           <= received_data_buf;
            next                <= interconnect_ready;
        end
    endcase
endmodule