module dds_top(

			input		wire				clk	,
			input		wire				rst_n	,
			input		wire	[2:0]		key	,
			output	wire	[7:0]		seven_tube_seg,
			output	wire	[5:0]		seven_tube_sel,
			output	wire	[3:0]		led,
			output	wire	[7:0]		wave_amp
			
		);
	
	wire	[3:0]		key_flag;
	wire	[19:0]	freq;
//	wire	[1:0]		wave_sel;
//	wire	[1:0]		amp_sel;
	
	key_manage key_manage_inst(
			
				.clk					(clk),
				.rst_n				(rst_n),
				.key					(key),	
				.edge_neg			(key_flag)
				
			); 

	led_on led_on_inst(
				.clk					(clk),
				.rst_n				(rst_n),
				.flag					(key_flag[0]),
				.led					(led)
			);
			
	dds_ctrl dds_ctrl_inst(

				.clk					(clk),
				.rst_n				(rst_n),
				.flag					(key_flag),	
				.freq					(freq)
//				.wave_sel			(wave_sel),
//				.amp_sel				(amp_sel)
		
			);
	
	dds dds_inst(

				.clk					(clk),
				.rst_n				(rst_n),
				.freq					(freq),
//				.wave_sel			(wave_sel),
//				.amp_adj				(amp_sel),
				.q			         (wave_amp)
		
	);
	
	display display_inst(
			
				.clk					(clk),
				.rst_n				(rst_n),
				.bin					(freq),	
//				.sel					(wave_sel),
//				.amp_sel				(amp_sel),		
				.seven_tube_seg	(seven_tube_seg),
				.seven_tube_sel	(seven_tube_sel)
			
		);
		
//	beep beep_inst(
//
//				.clk					(clk),
//				.rst_n				(rst_n),
//				.flag					(key_flag),
//				.beep					(beep)
//		
//		);

endmodule
