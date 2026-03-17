`timescale 1ns/100ps

module cordic_tb;
   parameter DATAWIDTH = 32; // Data width
    parameter N = 10; // Number of iterations
    
    reg signed [DATAWIDTH-1:0] z0;
    wire signed [DATAWIDTH-1:0] xn, yn, zn;
    integer i;
    integer j;
    
    cordic C1 (
        .z0(z0), 
        .xn(xn), 
        .yn(yn), 
        .zn(zn)
    );

    real degree_input; 
    reg signed [DATAWIDTH-1:0] q1_15_16bin;
    initial begin
       for (j = 0; j< 10; j = j+1) begin
           for (i = 0; i<360; i = i+1) begin
              degree_input = i;
               q1_15_16bin =degree_input * 65536; 
               z0 = q1_15_16bin;
               #10;
           end
       end
       #10000;
       $finish();
    end

endmodule
