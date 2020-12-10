module shift_adjust #(parameter WIDTH_BIN = 18, parameter WIDTH_BCD = 24)(

				input	wire	[WIDTH_BIN + WIDTH_BCD - 1 : 0]		idata,
				output	wire	[WIDTH_BIN + WIDTH_BCD - 1 : 0]		odata
	
			);
	
	wire [WIDTH_BIN + WIDTH_BCD - 1 : 0] tmp_data;
	
	genvar i;
	
	assign tmp_data = idata << 1;
	
	generate
	for(i = 0; i <WIDTH_BCD/4 ; i = i + 1'b1) begin	:	s_a
		modify modify_inst(.dat_org(tmp_data[4*i + 3 + WIDTH_BIN : 4*i+ WIDTH_BIN]), .dat_modify(odata[4*i + 3 + WIDTH_BIN : 4*i+ WIDTH_BIN]));
	end
	endgenerate
	
	assign odata[WIDTH_BIN -1 : 0] = tmp_data[WIDTH_BIN -1 : 0];

endmodule
