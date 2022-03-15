module IM (
    input clk,
    input reset,
    input [7:0] pc,
    output reg [17:0] instr
    );

    reg [17:0] regFile [7:0];
    
    always @(posedge clk) begin
        if (reset) begin
        regFile[0] <= {2'd0,8'd100,8'd50};
        regFile[1] <= {2'd1,8'd150,8'd120};
        regFile[2] <= {2'd2,8'd2,8'd20};
        regFile[3] <= {2'd3,8'd100,8'd25};
        regFile[4] <= {2'd3,8'd100,8'd30};
        regFile[5] <= {2'd2,8'd5,8'd50};
        regFile[6] <= {2'd0,8'd20,8'd50};
        regFile[7] <= {2'd1,8'd90,8'd45};
        end
        else
        instr <= regFile[pc];
    end
endmodule