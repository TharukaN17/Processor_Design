module top_module (
    input data_from_pc, fast_clock, start_process, start_transmit,
    output data_to_pc, l0, l1, l2, l3, g1, g2, g3
    );
    
    wire [7:0] dm_out;
    wire [15:0] im_out;
    wire [15:0] bus_out; 
    wire dm_en;
    wire [15:0] dar_out;
    wire im_en;
    wire [15:0] pc_out;
    wire end_receiving; 
    wire end_process;
    wire end_transmitting; 
    wire [1:0] status;
    wire [15:0] data_out_com;
    wire en_com;
    wire [15:0] addr_com;
    wire [7:0] data_in_com;
    wire clk;

    reg begin_process;
    reg begin_transmit;

    wire [15:0] data_in; 
    wire data_write_en;
    wire [15:0] data_addr;
    wire [15:0] instr_in;
    wire instr_write_en;
    wire [15:0] instr_addr;

    reg [9:0] process_switch_buffer = 10'd0;
    reg [9:0] transmit_switch_buffer = 10'd0;

    always @(posedge clk) begin
        if (start_process) begin
            if (process_switch_buffer == 10'd1023) begin
                process_switch_buffer <= process_switch_buffer;
                begin_process <=1;
            end
            else begin
                process_switch_buffer <= process_switch_buffer + 10'd1;
                begin_process <=0;
            end
        end
        else begin
            process_switch_buffer <= 10'd0;
            begin_process <= 0;
        end
    end
    
    always @(posedge clk) begin
        if (start_transmit) begin
            if (transmit_switch_buffer == 10'd1023) begin
                transmit_switch_buffer <= transmit_switch_buffer ;
                begin_transmit <=1;
            end
            else begin
                transmit_switch_buffer <= transmit_switch_buffer + 10'd1;
                begin_transmit <=0;
            end
        end
        else begin
            transmit_switch_buffer <= 10'd0;
            begin_transmit <= 0;
        end
    end
    
    slowclock slowclock1 (.clockin(fast_clock ), .clockout (clk));

    instr_memory instr_memory1 (.clk(clk), .write_en (im_en), .addr(pc_out), .instr_out (im_out), .instr_in (bus_out));

    data_memory datamemory1 ( .clk(clk), .write_en (data_write_en ), .addr(data_addr ), .data_in(data_in), .data_out(dm_out));

    processor processor1 (.clk(clk), .dm_out(dm_out), .im_out(im_out), .dm_en(dm_en), .im_en(im_en), .pc_out(pc_out), .dar_out(dar_out), .status(status), .bus_out(bus_out), .end_process (end_process ));

    selector selector1 ( .clk(clk), .status(status), .bus_out(bus_out), .dm_en(dm_en), .dar_out(dar_out), .data_out_com (data_out_com ), .en_com(en_com), .addr_com (addr_com ), .data_in(data_in), .data_write_en(data_write_en ), .data_addr(data_addr ), .data_in_com(data_in_com ));

//    communicate communicate1 ( .clk(clk), .status(status), .end_receiving (end_receiving ), .end_transmitting (end_transmitting ), .data_in_com (data_in_com ), .data_out_com (data_out_com ), .addr_com (addr_com ), .data_to_pc (data_to_pc ), .data_from_pc (data_from_pc ), .en_com(en_com));

    main_control main_control1 (.clk(clk), .end_receiving (end_receiving ), .end_process (end_process ), .end_transmitting (end_transmitting ), .begin_process (begin_process ), .begin_transmit (begin_transmit ), .status(status), .l0(l0), .l1(l1), .l2(l2), .l3(l3), .g1(g1), .g2(g2), .g3(g3));
endmodule