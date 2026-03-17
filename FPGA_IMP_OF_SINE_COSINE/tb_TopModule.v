`timescale 1ns/1ps

module tb_TopModule;

    // Inputs
    reg clk;
    reg rst;
    reg [1:0] sel;

    // Outputs
    wire [6:0] seg;
    wire [3:0] an;
    wire [31:0] xn;
    wire [3:0] bcd0, bcd1, bcd2, bcd3;
    wire [4:0] val_sel;
    wire [15:0] xn_out;

    // Instantiate DUT
    TopModule uut (
        .clk(clk),
        .rst(rst),
        .sel(sel),
        .seg(seg),
        .an(an),
        .xn(xn),
        .bcd0(bcd0),
        .bcd1(bcd1),
        .bcd2(bcd2),
        .bcd3(bcd3),
        .val_sel(val_sel),
        .xn_out(xn_out)
    );

    // Clock generation: 100 MHz => 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        rst = 1;
        sel = 2'b00;
        #100;
        rst = 0;

        #10000000;
        sel = 2'b01;
        #10000000;

        sel = 2'b10;
        #10000000;

        sel = 2'b11;
        #10000000;

        $finish;
    end

endmodule
