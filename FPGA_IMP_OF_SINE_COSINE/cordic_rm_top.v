`timescale 1ns/100ps
module cordic_rm_top #(DATAWIDTH = 32) (
    input  wire [2:0] sel,              // Select line for ROM
    output wire signed [DATAWIDTH-1:0] xn,       // CORDIC output x
    output wire signed [DATAWIDTH-1:0] yn,       // CORDIC output y
    output wire signed [DATAWIDTH-1:0] zn        // CORDIC output z
);

    wire [DATAWIDTH-1:0] x0, y0, z0;

    // Instantiate ROM module
    cordic_rom_rm rom_inst (
        .sel(sel),     // using only 2 bits since ROM has 3 entries (can be extended)
        .z0_out(z0),
        .x0_out(x0),
        .y0_out(y0)
    );

    // Instantiate CORDIC module
    cordic_rm cordic_inst (
        .z0(z0),
        .x0(x0),
        .y0(y0),
        .xn(xn),
        .yn(yn),
        .zn(zn)
    );

endmodule
