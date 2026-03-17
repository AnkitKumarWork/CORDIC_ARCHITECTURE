module cordic_rom_rm #(DATAWIDTH = 32) (
    input  wire [2:0] sel,       // 2-bit select line (0 to 7)
    output reg  [DATAWIDTH-1:0] z0_out,    // 32-bit test vector output
    output reg  [DATAWIDTH-1:0] x0_out,    // 32-bit test vector output
    output reg  [DATAWIDTH-1:0] y0_out     // 32-bit test vector output
);

    always @(*) begin
        // Assigning values to x0_out based on the select line
        x0_out = 32'h00009B75; // 0.6072 in Q1.15.16 format
        y0_out = 32'h00000000; // 0.0 in Q1.15.16 format
        case (sel)
            3'd0: z0_out = 32'h00000000; // 0°
            3'd1: z0_out =  32'h001e0000; // 30 degrees in Q1.15.16
            3'd2: z0_out= 32'h002d0000; // 45
            3'd3: z0_out=32'h003c0000;//60
            3'd4: z0_out=32'h005a0000;//90
            default: z0_out = 32'h00000000;
        endcase
    end

endmodule
