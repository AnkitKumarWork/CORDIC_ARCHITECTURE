`timescale 1ns/100ps

module tb_cordic_linear_mode_vm;

  // Parameters
  localparam DATAWIDTH = 32;

  // Inputs
  reg signed [DATAWIDTH-1:0] zin, xin, yin;

  // Outputs
  wire signed [DATAWIDTH-1:0] xn, yn, zn;

  // Instantiate the CORDIC Linear Mode VM module
  cordic_linear_mode_vm #(DATAWIDTH) uut (
    .zin(zin),
    .xin(xin),
    .yin(yin),
    .xn(xn),
    .yn(yn),
    .zn(zn)
  );

  initial begin
    $monitor($time, " zin=%d, xin=%d, yin=%d => xn=%d, yn=%d, zn=%d", zin, xin, yin, xn, yn, zn);

    // Test Case 1: 128 / 2
    yin = 32'd8388608; // Q15.16 format of 128
    xin = 32'd131072;  // Q15.16 format of 2
    zin = 32'd0;
    #10;

    // Test Case 2: 50 / 5
    yin = 32'd3276800; // Q15.16 format of 50
    xin = 32'd327680;  // Q15.16 format of 5
    zin = 32'd0;
    #10;

    // Test Case 3: 100 / 10
    yin = 32'd6553600; // Q15.16 format of 100
    xin = 32'd655360;  // Q15.16 format of 10
    zin = 32'd0;
    #10;

    // Test Case 4: 10 / 2
    yin = 32'd655360; // Q15.16 format of 10
    xin = 32'd131072; // Q15.16 format of 2
    zin = 32'd0;
    #10;

    $finish;
  end

endmodule
