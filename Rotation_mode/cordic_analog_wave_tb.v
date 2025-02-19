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

    real decimal_input; 
    reg signed [DATAWIDTH-1:0] q1_15_16bin; // Q1.15.16 representation (32-bit signed binary)

    initial begin
       for (j = 0; j< 10; j = j+1)begin
       for (i = 0; i<360;i=i+1) begin
        decimal_input = i;
        convert_to_fixed_point(decimal_input);
        z0 = q1_15_16bin;
        #10;
        end
       end
     #10000;
        $finish();
    end
    task convert_to_fixed_point;
        input real num;
        begin
            q1_15_16bin = num * 65536; // Shift left by 16 (2^16) to represent in Q1.15.16

            $display("Decimal: %f | Binary (Q1.15.16): %b ", num, q1_15_16bin);
        end
    endtask

endmodule
