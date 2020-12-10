module freq_ctrl(

				input		wire				clk,
				input		wire				rst_n,
//				input		wire	[1:0]		wave_sel,
				input		wire	[19:0]	freq,
				output	wire	[31:0]	step_val
		
			);
	
	
	reg [63:0]	tmp_step_val;
	
	always @(posedge clk  or negedge rst_n)
	if(!rst_n)
		tmp_step_val <= 0;
	else
		tmp_step_val <= {freq * 20, 32'd0};
	
	divider_ip divider_ip_inst(
			.clock			(clk),
			.denom			(64'd1000000000),
			.numer			(tmp_step_val),
			.quotient		(step_val),
			.remain			()
		);

endmodule