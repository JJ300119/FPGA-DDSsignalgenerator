module phase_adder(

				input		wire				clk,
				input		wire				rst_n,
//				input		wire	[1:0]		wave_sel,
				input		wire	[31:0]	step_val,
				output	reg	[5:0]		addr
				
);
	
	reg [31:0]	cnt;
	reg [31:0]	reg_step;
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)	cnt <= 32'd0;
	else	cnt <= cnt + reg_step;
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)	begin
		addr <= 0;
		reg_step <= 0;
	end
	else	begin
		addr <= cnt[31:26];
		reg_step <= step_val;
	end

endmodule
