module RefreshCounter(
    input clk,
    output reg [1:0] refresh_counter
);
    reg [15:0] count = 0;
    
    always @(posedge clk) begin
        count <= count + 1;
        refresh_counter <= count[15:14];  // Uses upper bits for refresh
    end
endmodule
