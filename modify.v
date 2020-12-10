module modify (

		input		wire		[3:0]		dat_org,
		output		wire		[3:0]		dat_modify

	);

	assign dat_modify = (dat_org > 4) ? (dat_org + 3'd3) :	dat_org;

endmodule
