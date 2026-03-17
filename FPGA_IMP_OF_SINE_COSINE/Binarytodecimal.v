module BinaryToDecimal(
    input [15:0] binary,
    output reg [3:0] bcd3,
    output reg [3:0] bcd2,
    output reg [3:0] bcd1,
    output reg [3:0] bcd0
);
    always @(*) begin
        bcd3 = (binary / 1000) %10;             // Extract thousands place
        bcd2 = (binary /100) % 10;    // Extract hundreds place
        bcd1 = (binary / 10) % 10;      // Extract tens place
        bcd0 = binary % 10;              // Extract ones place
    end
endmodule
