module tb_cordic_top;

    reg [1:0] sel;
    wire signed [31:0] xn, yn, zn;

    cordic_rm_top uut (
        .sel(sel),
        .xn(xn),
        .yn(yn),
        .zn(zn)
    );

    initial begin
        $display("CORDIC Top Module Test");
        for (sel = 0; sel < 3; sel = sel + 1) begin
            #10;
            $display("sel = %0d -> xn = %h, yn = %h, zn = %h", sel, xn, yn, zn);
        end
        $finish;
    end

endmodule
