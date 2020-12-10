module key_filter(

				input		wire			clk,
				input		wire			rst_n,
				input		wire			key,
				output	reg			q_key
				
			);
	
	parameter T5MS = 18'd250_000;
	
	localparam S0  = 4'b0001;
	localparam S1  = 4'b0010;
	localparam S2  = 4'b0100;
	localparam S3  = 4'b1000;
	
	reg [3:0]	curr_st, next_st;
	
	reg [17:0]	cnt;
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)
		cnt <= 18'd0;
	else 
	case(curr_st)
		S0, S2	:						cnt <= 18'd0;
		S1, S3	:	if(cnt < T5MS - 1)	cnt <= cnt + 1'b1;
					else 				cnt <= 18'd0;
	endcase

	always @(posedge clk or negedge rst_n)
	if(!rst_n)	curr_st <= S0;
	else		curr_st <= next_st;
	
	always @(*)
	case(curr_st)
		S0	:	if(key == 1'b0)						next_st = S1;
				else								next_st = S0;
		S1	:	if(key == 1'b0 && cnt == T5MS - 1)	next_st = S2;
				else if(key == 1'b0)				next_st = S1;
				else 								next_st = S0;
		S2	:	if(key == 1'b1)						next_st = S3;
				else								next_st = S2;
		S3	:	if(key == 1'b1 && cnt == T5MS - 1)	next_st = S0;
				else if(key == 1'b1)				next_st = S3;
				else								next_st = S2;
		default	:	next_st = S0;
	endcase
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)
		q_key <= 1'b1;
	else 
	case(curr_st)
		S0, S1	:	q_key <= 1'b1;
		S2, S3	:	q_key <= 1'b0;
		default	:	q_key <= 1'b1;
	endcase
	
endmodule
