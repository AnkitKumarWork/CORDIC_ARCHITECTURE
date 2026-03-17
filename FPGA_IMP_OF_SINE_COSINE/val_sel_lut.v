module val_sel_lut (
    input  wire [4:0] val_sel,      // 5-bit selection input
    output reg  [15:0] xn_out       // 16-bit xn value output
);

    always @(*) begin
        case (val_sel)
            5'd0: xn_out = 16'd0999;    // 0°
            5'd1: xn_out = 16'd0859;    // 30°
            5'd2: xn_out = 16'd0706;    // 45°
            5'd3: xn_out = 16'd0510;    // 60°
            5'd4: xn_out = 16'd0006;     // 90°
            default: xn_out = 16'd0000;     // Invalid index
        endcase
    end

endmodule
