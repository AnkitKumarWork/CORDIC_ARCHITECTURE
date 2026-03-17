module yn_lut (
    input  wire [31:0] yn,        // Input xn value (signed 32-bit)
    output reg  [4:0]  val_sel    // Output index based on xn
);

    always @(*) begin
        case (yn)
            32'd65518:        val_sel = 5'd0;   // yn for 90°
            32'd56348:        val_sel = 5'd1;   // yn for 60°
            32'd46368:        val_sel = 5'd2;   // yn for 45°
            32'd33465:        val_sel = 5'd3;   // yn for 30°
            32'd4294966233:   val_sel = 5'd4;   // yn = (0°)
            default:          val_sel = 5'd0;   // Default/error
        endcase
    end

endmodule
