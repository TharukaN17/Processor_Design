module baud_tick_gen(
    input clk, enable,
    output tick
    );
    
    parameter
    clk_frequency = 25000000,
    baud = 115200,
    oversampling = 1;
    
    function integer log2(input integer v); begin
        log2 = 0;
        while (v >> log2)
            log2 = log2 + 1;
        end
    endfunction
    
    localparam acc_width = log2(clk_frequency / baud) + 8;
    reg [acc_width : 0] acc = 0;
    localparam shift_limiter = log2(baud * oversampling >> (31 - acc_width));
    localparam inc = ((baud * oversampling << (acc_width - shift_limiter)) + (clk_frequency >> (shift_limiter + 1))) / (clk_frequency >> shift_limiter);
    
    always @(posedge clk)
        if (enable)
            acc <= acc[acc_width - 1:0] + inc[acc_width:0];
        else
            acc <= inc[acc_width:0];
    
    assign tick = acc[acc_width];
endmodule