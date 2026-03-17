`timescale 1ns/100ps

module cordic_tb;
    parameter DATAWIDTH = 32; // Data width
    parameter N = 20; // Number of iterations
    
    reg signed [DATAWIDTH-1:0] zin, xin, yin; // Input signals
    wire signed [DATAWIDTH-1:0] xn, yn, zn;

    // Instantiate CORDIC Module
    cordic_RM C1
    (
        .zin(zin),
        .xin(xin),
        .yin(yin), 
        .xn(xn), 
        .yn(yn), 
        .zn(zn)
    );

    initial begin
        // Test case: 0 degrees
        xin = 32'h00DDB22E; // 0.866 in Q1.7.24 
        yin = 32'h00000000; // 0.0 in Q1.7.24 
        zin = 32'h1E000000; // 0.5234 in Q1.7.24 
        #100;

/*        xin = 32'h02000000; // 2 in Q1.7.24 
        yin = 32'h00000000; // 0.0 in Q1.7.24 
        zin = 32'hAC000000; // 0.5234 in Q1.7.24 
        #100;
  */

        
        #10 $finish;
    end

endmodule
