`timescale 1ns/100ps
module cordic_linear_mode_vm #(parameter DATAWIDTH = 32)(zin,xin, yin, xn, yn, zn);
  
  input signed [DATAWIDTH-1:0] zin, xin, yin;
  output reg signed [DATAWIDTH-1:0] xn, yn, zn;

  localparam N = 17;

  reg [(N-1):0] d;
  reg signed [DATAWIDTH-1:0] x [(N-1):0];
  reg signed [DATAWIDTH-1:0] y [(N-1):0];
  reg signed [DATAWIDTH-1:0] z [(N-1):0];

  wire signed [DATAWIDTH-1:0] negpow2 [(N-1):0];
  assign negpow2[0] = 32'd65536;
  assign negpow2[1] = 32'd32768;
  assign negpow2[2] = 32'd16384;
  assign negpow2[3] = 32'd8192;
  assign negpow2[4] = 32'd4096;
  assign negpow2[5] = 32'd2048;
  assign negpow2[6] = 32'd1024;
  assign negpow2[7] = 32'd512;
  assign negpow2[8] = 32'd256;
  assign negpow2[9] = 32'd128;
  assign negpow2[10] = 32'd64;
  assign negpow2[11] = 32'd32;
  assign negpow2[12] = 32'd16;
  assign negpow2[13] = 32'd8;
  assign negpow2[14] = 32'd4;
  assign negpow2[15] = 32'd2;
  assign negpow2[16] = 32'd1;

  //assign negpow2[17] = 32'h00001ca5;
 // assign negpow2[18] = 32'h00000e52;
 // assign negpow2[19] = 32'h00000729;

  

  integer i;

  always @(*) begin
  x[0] = xin;
  y[0] = yin;
  z[0] = zin;

  for (i = 0; i < N; i = i + 1) begin
    //d[i] = (z[i][DATAWIDTH-1] == 0) ? 0 : 1;

     if (y[i] < 0) begin
    x[i+1] = x[i] ;
    y[i+1] = y[i] + (x[i] >>> i);
    z[i+1] = z[i] - negpow2[i];
    end else begin
    x[i+1] = x[i] ;
    y[i+1] = y[i] - (x[i] >>> i);
    z[i+1] = z[i] + negpow2[i];
    end
  end
 

  xn = x[N-1] ;
  yn = y[N-1] ;
  zn = z[N-1];

  end

endmodule
