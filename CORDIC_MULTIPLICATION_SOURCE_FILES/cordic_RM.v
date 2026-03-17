`timescale 1ns/100ps
module cordic_RM #(parameter DATAWIDTH = 32)(zin,xin, yin, xn, yn, zn);
  
  input signed [DATAWIDTH-1:0] zin, xin, yin;
  output reg signed [DATAWIDTH-1:0] xn, yn, zn;

  localparam N = 20;

  reg [(N-1):0] d;
  reg signed [DATAWIDTH-1:0] x [(N-1):0];
  reg signed [DATAWIDTH-1:0] y [(N-1):0];
  reg signed [DATAWIDTH-1:0] z [(N-1):0];

  wire signed [DATAWIDTH-1:0] negpow2 [(N-1):0];
  assign negpow2[0] = 32'h394a3d71;
  assign negpow2[1] = 32'h1ca51eb9;
  assign negpow2[2] = 32'h0e528f5d;
  assign negpow2[3] = 32'h072947af;
  assign negpow2[4] = 32'h0394a3d8;
  assign negpow2[5] = 32'h01ca51ec;
  assign negpow2[6] = 32'h00e528f6;
  assign negpow2[7] = 32'h0072947b;
  assign negpow2[8] = 32'h00394a3e;
  assign negpow2[9] = 32'h001ca51f;
  assign negpow2[10] = 32'h000e528f;
  assign negpow2[11] = 32'h00072948;
  assign negpow2[12] = 32'h000394a4;
  assign negpow2[13] = 32'h0001ca52;
  assign negpow2[14] = 32'h0000e529;
  assign negpow2[15] = 32'h00007295;
  assign negpow2[16] = 32'h0000394a;
  assign negpow2[17] = 32'h00001ca5;
  assign negpow2[18] = 32'h00000e52;
  assign negpow2[19] = 32'h00000729;

  

  integer i;

  always @(*) begin
  x[0] = xin;
  y[0] = yin;
  z[0] = zin;

  for (i = 0; i < N; i = i + 1) begin
    d[i] = (z[i][DATAWIDTH-1] == 0) ? 0 : 1;

    if (d[i] == 0) begin
    x[i+1] = x[i] ;
    y[i+1] = y[i] + (x[i] >>> i);
    z[i+1] = z[i] - negpow2[i];
    end else begin
    x[i+1] = x[i] ;
    y[i+1] = y[i] - (x[i] >>> i);
    z[i+1] = z[i] + negpow2[i];
    end
  end

  xn = x[N-1];
  yn = y[N-1];
  zn = z[N-1];
  end

endmodule
