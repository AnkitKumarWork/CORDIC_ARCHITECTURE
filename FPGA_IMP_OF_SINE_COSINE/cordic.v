`timescale 1ns/100ps
module cordic_rm #(parameter DATAWIDTH = 32)(z0,x0,y0, xn, yn, zn);
  
  input signed [DATAWIDTH-1:0] z0, x0, y0;
  output reg signed [DATAWIDTH-1:0] xn, yn, zn;

  localparam N = 20; // Number of iterations

  reg [(N-1):0] d;
  reg signed [DATAWIDTH-1:0] x [(N-1):0];
  reg signed [DATAWIDTH-1:0] y [(N-1):0];
  reg signed [DATAWIDTH-1:0] z [(N-1):0];

  wire signed [DATAWIDTH-1:0] arctan [(N-1):0];

  assign arctan[0] = 32'h002D0000;
  assign arctan[1] = 32'h001A999A;
  assign arctan[2] = 32'h000E0000;
  assign arctan[3] = 32'h0007199A;
  assign arctan[4] = 32'h0003999A;
  assign arctan[5] = 32'h0001CCCD;
  assign arctan[6] = 32'h0003A980;
  assign arctan[7] = 32'h00006667;
  assign arctan[8] = 32'h00003334;
  assign arctan[9] = 32'h0000199A;
  assign arctan[10] = 32'h00000CCCD;
  assign arctan[11] = 32'h00000667;
  assign arctan[12] = 32'h00000334;
  assign arctan[13] = 32'h00000199;
  assign arctan[14] = 32'h000000CC;
  assign arctan[15] = 32'h00000033;
  assign arctan[16] = 32'h00000019;
  assign arctan[17] = 32'h0000000C;
  assign arctan[18] = 32'h00000003;
  assign arctan[19] = 32'h00000001;

  integer i;

  always @(*) begin
  x[0] =x0; // 32'h00009B75;
  y[0] =y0;// 32'h00000000;
  z[0] = z0;

  for (i = 0; i < N; i = i + 1) begin
    d[i] = (z[i][DATAWIDTH-1] == 0) ? 0 : 1;

    if (d[i] == 0) begin
    x[i+1] = x[i] - (y[i] >>> i);
    y[i+1] = y[i] + (x[i] >>> i);
    z[i+1] = z[i] - arctan[i];
    end else begin
    x[i+1] = x[i] + (y[i] >>> i);
    y[i+1] = y[i] - (x[i] >>> i);
    z[i+1] = z[i] + arctan[i];
    end
  end

  xn = x[N-1];//>>16;
  yn = y[N-1];//>>16;
  zn = z[N-1];//>>16;
  end

endmodule
