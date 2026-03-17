`timescale 1ns/100ps

module cordic_tb;
    parameter DATAWIDTH = 32; // Data width
    parameter N = 10; // Number of iterations
    
    reg signed [DATAWIDTH-1:0] z0;
    wire signed [DATAWIDTH-1:0] xn, yn, zn;

    // Instantiate CORDIC Module
    cordic C1
    (
        .z0(z0), 
        .xn(xn), 
        .yn(yn), 
        .zn(zn)
    );

    initial begin
        // Test case: 0 degrees
        z0 = 32'h00000000; // 0 degrees in Q1.15.16
        #100;

        
        // Test case: 45 degrees
        z0 = 32'h002D0000; // 45 degrees in Q1.15.16
        #100;

        
        // Test case: 90 degrees
        z0 = 32'h005A0000; // 90 degrees in Q1.15.16
        #100;
       
        
        #10 $finish;
    end

endmodule
