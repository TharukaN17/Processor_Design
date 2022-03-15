module selector(
    input clk, dm_en, en_com,
    input [1:0] status,
    input [15:0] bus_out, dar_out, data_out_com, addr_com,
    output reg [15:0] data_in, data_addr,
    output reg data_write_en,
    output reg [7:0] data_in_com
    );
    
    always @(posedge clk)
    case (status)
        2'b00: begin
            data_in <= data_out_com;
            data_write_en <= en_com;
            data_addr <= addr_com;        
        end
        
        2'b01: begin
            data_in <= bus_out;
            data_write_en <= dm_en;
            data_addr <= dar_out;
        end
        
        2'b10: begin
            data_in_com <= bus_out[7:0];
            data_write_en <= en_com;
            data_addr <= addr_com;
        end
    endcase
endmodule