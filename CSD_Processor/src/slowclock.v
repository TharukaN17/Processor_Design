module slowclock(
    input clockin,
    output reg clockout = 1'b0
    );
    
    reg counter = 1'b0;
    
    always @(posedge clockin) begin
        counter <= counter + 1'b1;
        if (counter == 1'b1)
            clockout <= ~clockout;
    end
endmodule