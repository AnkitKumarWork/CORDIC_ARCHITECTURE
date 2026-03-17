`timescale 1ns / 1ps

module BinaryToDecimal_tb;

    reg [31:0] binary;
    wire [3:0] bcd3, bcd2, bcd1, bcd0;

    // Instantiate the module under test
    BinaryToDecimal uut (
        .binary(binary),
        .bcd3(bcd3),
        .bcd2(bcd2),
        .bcd1(bcd1),
        .bcd0(bcd0)
    );

    initial begin
        // Monitor output
        $monitor("Time=%0t | Binary=%0d | BCD = %0d%0d%0d%0d", $time, binary, bcd3, bcd2, bcd1, bcd0);

        // Test cases
        binary = 0;     #10;
        binary = 5;     #10;
        binary = 42;    #10;
        binary = 123;   #10;
        binary = 999;   #10;
        binary = 1000;  #10;
        binary = 4321;  #10;
        binary = 9999;  #10;

        $finish;
    end

endmodule
