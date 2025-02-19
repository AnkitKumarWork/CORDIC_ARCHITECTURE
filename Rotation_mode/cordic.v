`timescale 1ns/100ps
module cordic #(parameter DATAWIDTH = 32)(z0, xn, yn, zn);
  
  input signed [DATAWIDTH-1:0] z0;
  output reg signed [DATAWIDTH-1:0] xn, yn, zn;

  localparam N = 10; // Number of iterations

  reg [(N-1):0] d;
  reg signed [DATAWIDTH-1:0] x [(N-1):0];
  reg signed [DATAWIDTH-1:0] y [(N-1):0];
  reg signed [DATAWIDTH-1:0] z [(N-1):0];

  wire signed [DATAWIDTH-1:0] arctan [(N-1):0];

  // Arctan values in Q1.15.16 format
  
  assign arctan[0] = 32'b00000000001011010000000000000000; // 45.0
  assign arctan[1] = 32'b00000000000110101001100110011010; // 26.6
  assign arctan[2] = 32'b00000000000011100000000000000000; // 14.0
  assign arctan[3] = 32'b00000000000001110001100110011010; // 7.1 
  assign arctan[4] = 32'b00000000000000111001100110011010; // 3.6
  assign arctan[5] = 32'b00000000000000011100110011001101; // 1.8
  assign arctan[6] = 32'b00000000000000001110011001100110; // 0.9
  assign arctan[7] = 32'b00000000000000000110011001100110; // 0.4
  assign arctan[8] = 32'b00000000000000000011001100110011; // 0.2
  assign arctan[9] = 32'b00000000000000000001100110011010; // 0.1

  integer i;

  always @(*) begin
    x[0] = 32'b00000000000000001001101101110101;  // 0.60725 (CORDIC gain compensation)
    y[0] = 32'b00000000000000000000000000000000;    // y0 = 0
    z[0] = z0;

    // CORDIC Iterations
    for (i = 0; i < N; i = i + 1) begin
      d[i] = (z[i][DATAWIDTH-1] == 0) ? 0 : 1; // Check sign bit at MSB

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

    xn = x[N-1]; // cos(z0)
    yn = y[N-1]; // sin(z0)
    zn = z[N-1]; // Final angle
  end

endmodule
