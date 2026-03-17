module TopModule(
    input clk,      // 100 MHz FPGA clock
    input rst,      // Reset button
    input [1:0] sel,
    input mode_sel, // New input to select between xn_out and yn_out
    output [6:0] seg,           // 7-segment output
    output reg [3:0] an,        // Digit select
    output reg dp              // Decimal point control
);

    wire [3:0] bcd0, bcd1, bcd2, bcd3;
    wire clk_1Hz;
    wire [31:0] zn;
    wire [31:0] yn;
    wire [1:0] refresh_counter;
    wire [15:0] xn_out;
    wire [15:0] yn_out;
    wire [4:0] val_sel;
    wire [4:0] val_sel_y;
    wire [31:0] xn;

    // Instantiate modules
    cordic_rm_top cordic_rm_top (
        .sel(sel),
        .xn(xn),
        .yn(yn),
        .zn(zn)
    );

    xn_lut xn_lut (
        .xn(xn),
        .val_sel(val_sel)
    );

    val_sel_lut val_sel_lut (
        .val_sel(val_sel),
        .xn_out(xn_out)
    );

    yn_lut yn_lut (
        .yn(yn),
        .val_sel(val_sel_y)
    );

    y_val_sel_lut y_val_sel_lut (
        .val_sel(val_sel_y),
        .yn_out(yn_out)
    );

    clk_divider clk_divider (
        .clk(clk),
        .rst(rst),
        .clk_1Hz(clk_1Hz)
    );

    wire [15:0] selected_input;
    assign selected_input = (mode_sel == 1'b0) ? xn_out : yn_out;

    BinaryToDecimal btd (
        .binary(selected_input),
        .bcd3(bcd3),
        .bcd2(bcd2),
        .bcd1(bcd1),
        .bcd0(bcd0)
    );

    RefreshCounter refresh (
        .clk(clk),
        .refresh_counter(refresh_counter)
    );

    always @(*) begin
        case (refresh_counter)
            2'b00: begin
                an = 4'b1110;
                dp = 1'b1; // decimal point ON after first digit
            end
            2'b01: begin
                an = 4'b1101;
                dp = 1'b1;
            end
            2'b10: begin
                an = 4'b1011;
                dp = 1'b1;
            end
            2'b11: begin
                an = 4'b0111;
                dp = 1'b0;
            end
            default: begin
                an = 4'b1111;
                dp = 1'b1;
            end
        endcase
    end

    SevenSegmentDecoder ssd (
        .digit_select(refresh_counter),
        .bcd3(bcd3),
        .bcd2(bcd2),
        .bcd1(bcd1),
        .bcd0(bcd0),
        .seg(seg)
    );

endmodule
