module clk_divider(
    input clk,       // 100 MHz FPGA clock
    input rst,       // Reset signal
    output reg clk_1Hz // 1Hz clock output
);
    reg [26:0] count; // 27-bit counter (log2(100M) ≈ 27)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            clk_1Hz <= 0;
        end else if (count == 50000000) begin // 100M / 2 = 50M
            count <= 0;
            clk_1Hz <= ~clk_1Hz;
        end else begin
            count <= count + 1;
        end
    end
endmodule
