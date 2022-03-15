module main_control(
    input clk, end_receiving, end_process, end_transmitting, begin_process, begin_transmit,
    output reg [1:0] status,
    output reg l0 = 1'd0, l1 = 1'd0, l2 = 1'd0, l3 = 1'd0, g1 = 1'd0, g2 = 1'd0, g3 = 1'd0
    );
    
    reg [1:0] present = 2'b00;
    reg [1:0] next = 2'b00;
    
    parameter
    receive = 2'b00,
    process = 2'b01,
    transmit = 2'b10,
    alldone = 2'b11;
    
    always @(posedge clk) begin
        if (begin_process) begin
            g1 <= 1;
        end
        
        if (begin_transmit) begin
            g2 <= 1;
        end
        
        if (end_receiving) begin
            g3 <= 1;
        end
        
        present <= next;
    end
    
    always @(present or begin_transmit or begin_process or end_receiving or end_process or end_transmitting) begin
        case (present)
            receive: begin
                status <= 2'b00;
                l0 <= 1;
                l1 <= 0;
                l2 <= 0;
                l3 <= 0;  
                if (end_receiving && !end_process && !end_transmitting)
                    next <= process;
                else
                    next <= receive;
            end
            
            process: begin
                status <= 2'b01;
                l0 <= 1;
                l1 <= 1;
                l2 <= 0;
                l3 <= 0;
                if (end_receiving && end_process && !end_transmitting && begin_transmit)
                    next <= transmit;
                else 
                    next <= process;
            end
            
            transmit: begin
                status <= 2'b10;
                l0 <= 1;
                l1 <= 1;
                l2 <= 1;
                l3 <= 0;
                if (end_receiving && end_process && end_transmitting)
                    next <= alldone;
                else
                    next <= transmit;
            end
            
            alldone: begin
                status <= 2'b11;
                l0 <= 1;
                l1 <= 1;
                l2 <= 1;
                l3 <= 1;
                next <= alldone;
            end
        endcase            
    end
endmodule