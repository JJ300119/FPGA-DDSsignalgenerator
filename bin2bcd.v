module bin2bcd	#(parameter WIDTH_BIN = 20, parameter WIDTH_BCD = 28)(	

			input	 wire		[WIDTH_BIN - 1 : 0]				bin,
			output	 wire		[WIDTH_BCD - 1 : 0]				bcd
			
		);

	wire [WIDTH_BIN + WIDTH_BCD - 1 : 0]		tmp_data [WIDTH_BIN : 0];
	genvar i;
	
	assign tmp_data[0] =  bin;
	
	generate
	for(i = 0; i < WIDTH_BIN - 1; i = i + 1'b1) begin	:	b2b
		shift_adjust #(.WIDTH_BIN(20),.WIDTH_BCD(28)) shift_adjust_inst(.idata(tmp_data[i]), .odata(tmp_data[i + 1'b1]));	
	end
	endgenerate
	
	assign tmp_data[WIDTH_BIN] = tmp_data[WIDTH_BIN - 1] << 1;
	assign bcd = tmp_data[WIDTH_BIN][WIDTH_BIN + WIDTH_BCD - 1 : WIDTH_BIN];
	

endmodule
