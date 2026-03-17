module seven_seg_display(
    input clk, rst,
    input [3:0] digit1, digit0,
    output reg [6:0] seg,
    output reg [3:0] an
);
    reg [15:0] refresh_counter = 0;
    wire refresh_tick = refresh_counter[15];
    reg [1:0] sel = 0;
    reg [3:0] current_digit;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            refresh_counter <= 0;
            sel <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
            if (refresh_tick)
                sel <= sel + 1;
        end
    end

    always @(*) begin
        case (sel)
            2'b00: begin an = 4'b1110; current_digit = digit0; end
            2'b01: begin an = 4'b1101; current_digit = digit1; end
             2'b10: begin an = 4'b1011; current_digit = digit1; end
              2'b11: begin an = 4'b0111; current_digit = digit1; end
            default: begin an = 4'b1111; current_digit = 4'b0000; end
        endcase
    end

    always @(*) begin
        case (current_digit)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
         
            default: seg = 7'b1111111;
        endcase
    end
endmodule
