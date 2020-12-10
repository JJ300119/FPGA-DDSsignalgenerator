module amp_adj(
	
			input		wire				clk,
			input		wire				rst_n,
			input		wire	[7:0]		wave,
			input		wire	[4:0]		amp_factor,
			output	reg	[7:0]		wave_adj
		
		);

	always @(posedge clk or negedge rst_n)
	if(!rst_n)
		wave_adj <= 10'd0;
	else
		wave_adj <= wave * amp_factor/10;

endmodule
