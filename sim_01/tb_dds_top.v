`timescale 1 ns/1 ps
module tb_dds_top;

reg  clk;
reg  rst_n;
reg  [2:0]key;

wire [7:0]seven_tube_seg;
wire [5:0]seven_tube_sel;
wire [3:0]led;
wire [7:0]wave_amp;

dds_top i1(
            .clk(clk),
            .rst_n(rst_n),
            .key(key),
            .seven_tube_seg(seven_tube_seg),
            .seven_tube_sel(seven_tube_sel),
            .led(led),
            .wave_amp(wave_amp)
);

initial
begin
    clk<=1'b0;
    rst_n<=0;
    key<=4'b1111;

    #20 rst_n<=1'b1;

end

always   #10  clk<=~clk;  

endmodule