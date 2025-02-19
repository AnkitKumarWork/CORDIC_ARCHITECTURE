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
        z0 = 32'b00000000000000000000000000000000; // 0 degrees
        #100;
        $display("z0 = 0� -> xn: %.5f, yn: %.5f, zn: %.5f", xn/65536.0, yn/65536.0, zn/65536.0);
        
        // Test case: 45 degrees
        z0 = 32'b00000000001011010000000000000000; // 45 degrees in Q1.15.16
        #100;
        $display("z0 = 45� -> xn: %.5f, yn: %.5f, zn: %.5f", xn/65536.0, yn/65536.0, zn/65536.0);
        
        // Test case: 90 degrees
        z0 = 32'b00000000010110100000000000000000; // 90 degrees in Q1.15.16
        #100;
        $display("z0 = 90� -> xn: %.5f, yn: %.5f, zn: %.5f", xn/65536.0, yn/65536.0, zn/65536.0);
        
        #10 $finish;
    end

endmodule
