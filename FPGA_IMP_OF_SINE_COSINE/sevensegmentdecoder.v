module SevenSegmentDecoder(
    input [1:0] digit_select,
    input [3:0] bcd3,
    input [3:0] bcd2,
    input [3:0] bcd1,
    input [3:0] bcd0,
    output reg [6:0] seg
);
    reg [3:0] selected_digit;
    
    always @(*) begin
        case(digit_select)
            2'b00: selected_digit = bcd0;
            2'b01: selected_digit = bcd1;
            2'b10: selected_digit = bcd2;
            2'b11: selected_digit =bcd3;
            default: selected_digit = 4'b0000;
        endcase
    end

    always @(*) begin
        case(selected_digit)
            4'b0000: seg = 7'b1000000;
            4'b0001: seg = 7'b1111001;
            4'b0010: seg = 7'b0100100;
            4'b0011: seg = 7'b0110000;
            4'b0100: seg = 7'b0011001;
            4'b0101: seg = 7'b0010010;
            4'b0110: seg = 7'b0000010;
            4'b0111: seg = 7'b1111000;
            4'b1000: seg = 7'b0000000;
            4'b1001: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
