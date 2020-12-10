module key_manage(
			
				input		wire				clk			,
				input		wire				rst_n			,
				input		wire	[2:0]		key			,
				output	wire	[2:0]		edge_neg		
				
			); 

	wire 	[2:0]		q_key;
	
	reg	[2:0]		reg_key;
	reg	[2:0]		r_reg_key;
	
	always @(posedge clk or negedge rst_n)	begin
		if(!rst_n)	begin
			reg_key 	 <= 3'd0;
			r_reg_key <= 3'd0;
		end
		else	begin
			reg_key 	 <= key;
			r_reg_key <= reg_key;
		end
	end
	
//	key_filter key_filter_inst1(.clk(clk), .rst_n(rst_n), .key(r_reg_key[3]), .q_key(q_key[3]));
	key_filter key_filter_inst2(.clk(clk), .rst_n(rst_n), .key(r_reg_key[2]), .q_key(q_key[2]));
	key_filter key_filter_inst3(.clk(clk), .rst_n(rst_n), .key(r_reg_key[1]), .q_key(q_key[1]));
	key_filter key_filter_inst4(.clk(clk), .rst_n(rst_n), .key(r_reg_key[0]), .q_key(q_key[0]));
	
//	edge_detect edge_detect_inst1(.clk(clk), .rst_n(rst_n), .level(q_key[3]), .edge_pos(), .edge_neg(edge_neg[3]));
	edge_detect edge_detect_inst2(.clk(clk), .rst_n(rst_n), .level(q_key[2]), .edge_pos(), .edge_neg(edge_neg[2]));
	edge_detect edge_detect_inst3(.clk(clk), .rst_n(rst_n), .level(q_key[1]), .edge_pos(), .edge_neg(edge_neg[1]));
	edge_detect edge_detect_inst4(.clk(clk), .rst_n(rst_n), .level(q_key[0]), .edge_pos(), .edge_neg(edge_neg[0]));

endmodule
