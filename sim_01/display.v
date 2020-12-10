module display(
			
			input	wire							clk,
			input	wire							rst_n,
			input	wire			[19 : 0]		bin,
			
//			input	wire			[1:0]			sel,
//			input	wire			[1:0]			amp_sel,
			
			output	wire		[7:0]			seven_tube_seg,
			output	wire		[5:0]			seven_tube_sel
			
		);
	
	wire	[27 : 0]		bcd;

	bin2bcd	bin2bcd_inst(	

				.bin			(bin),
				.bcd			(bcd)
			
		);
	
	seven_tube_drive seven_tube_drive_inst(

				.clk			(clk),
				.rst_n		(rst_n),
				.show_data	( bcd),
				.seven_tube_seg(seven_tube_seg),
				.seven_tube_sel (seven_tube_sel)
);


endmodule
