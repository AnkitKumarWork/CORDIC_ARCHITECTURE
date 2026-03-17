module y_val_sel_lut (
    input  wire [4:0] val_sel,      // 5-bit selection input
    output reg  [15:0] yn_out       // 16-bit xn value output
);

    always @(*) begin
        case (val_sel)
            5'd0: yn_out = 16'd0999;    // 90°
            5'd3: yn_out = 16'd0510;    // 60°
            5'd2: yn_out = 16'd0706;    // 45°
            5'd1: yn_out = 16'd0859;    // 30°
            5'd4: yn_out = 16'd0006;     // 0
            default: yn_out = 16'd0000;     // Invalid index
        endcase
    end

endmodule
