module uart_tx #(parameter CLKS_PER_BIT = 217)(
    input clk, tx_dv,
    input [7:0] tx_byte,
    output tx_active, tx_done,
    output reg tx_serial
    );
    
    parameter
    idle = 3'b000,
    tx_start_bit = 3'b001,
    tx_data_bits = 3'b010,
    tx_stop_bit = 3'b011,
    cleanup = 3'b100;
    
    reg [2:0] r_state = 0;
    reg [7:0] r_clock_count = 0;
    reg [2:0] r_bit_index = 0;
    reg [7:0] r_tx_data = 0;
    reg r_tx_done = 0;
    reg r_tx_active = 0;
    
    always @(posedge clk) begin
        case(r_state)
            idle: begin
                tx_serial <= 1'b1;
                r_tx_done <= 1'b0;
                r_clock_count <= 0;
                r_bit_index <= 0;
                if (tx_dv == 1'b1) begin
                    r_tx_active <= 1'b1;
                    r_tx_data <= tx_byte;
                    r_state <= tx_start_bit;
                end
                else
                    r_state <= idle;
            end
            
            tx_start_bit: begin
                tx_serial <= 1'b0;
                if (r_clock_count < CLKS_PER_BIT - 1) begin
                    r_clock_count <= r_clock_count + 1;
                    r_state <= tx_start_bit;
                end
                else begin
                    r_clock_count <= 0;
                    r_state <= tx_data_bits;
                end
            end
            
            tx_data_bits: begin
                tx_serial <= r_tx_data[r_bit_index];
                if (r_clock_count < CLKS_PER_BIT - 1) begin
                    r_clock_count <= r_clock_count + 1;
                    r_state <= tx_data_bits;
                end
                else begin
                    r_clock_count <= 0;
                    if (r_bit_index < 7) begin
                        r_bit_index <= r_bit_index + 1;
                        r_state <= tx_data_bits;
                    end
                    else begin
                        r_bit_index <= 0;
                        r_state <= tx_stop_bit;
                    end
                end
            end
            
            tx_stop_bit: begin
                tx_serial <= 1'b1;
                if (r_clock_count < CLKS_PER_BIT -1) begin
                    r_clock_count <= r_clock_count + 1;
                    r_state <= tx_stop_bit;
                end
                else begin
                    r_tx_done <= 1'b1;
                    r_clock_count <= 0;
                    r_state <= cleanup;
                    r_tx_active <= 1'b0;
                end
            end
            
            cleanup: begin
                r_tx_done <= 1'b1;
                r_state <= idle;
            end
            
            default:
                r_state <= idle;
        endcase
    end
    
    assign tx_active = r_tx_active;
    assign tx_done = r_tx_done;
endmodule