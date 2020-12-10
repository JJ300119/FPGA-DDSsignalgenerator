module dds(

		input		wire				clk,
		input		wire				rst_n,
		input		wire	[19:0]	freq,
//		input		wire	[1:0]		wave_sel,
//		input		wire	[4:0]		amp_adj,
		output	wire	[7:0]		q
		
	);
	
	wire	[31:0]	step_val;
	wire	[5:0]		addr;
//	wire	[7:0]		q;
	
	freq_ctrl freq_ctrl_inst(

				.clk			(clk),
				.rst_n		(rst_n),
//				.wave_sel	(wave_sel),
				.freq			(freq),
				.step_val	(step_val)
		
			);

	phase_adder phase_adder_inst(

				.clk			(clk),
				.rst_n		(rst_n),
//				.wave_sel	(wave_sel),
				.step_val	(step_val),
				.addr			(addr)
				
			);
	
	sim_rom	sim_rom_inst (
				.address ( addr ),
				.clock 	( clk ),
				.q 		( q )
			);
	
//	amp_adj amp_adj_inst(
//	
//				.clk			(clk),
//				.rst_n		(rst_n),
//				.wave			(q),
//				.amp_factor	(amp_adj),
//				.wave_adj	(wave_adj)
//		
//			);
			
endmodule
