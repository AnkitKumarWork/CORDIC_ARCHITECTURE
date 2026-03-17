module xn_lut (
    input  wire [31:0] xn,        // Input xn value (signed 32-bit)
    output reg  [4:0]  val_sel    // Output index based on xn
);

    always @(*) begin
        case (xn)
            32'd65518:        val_sel = 5'd0;   // xn for 0°
            32'd56348:        val_sel = 5'd1;   // xn for 30°
            32'd46315:        val_sel = 5'd2;   // xn for 45°
            32'd33465:        val_sel = 5'd3;   // xn for 60°
            32'd4294966233:     val_sel = 5'd4;   // xn = -63 (90°)
            default:          val_sel = 5'd31;  // Default/error
        endcase
    end

endmodule
