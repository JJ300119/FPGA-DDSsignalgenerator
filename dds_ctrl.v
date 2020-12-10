module dds_ctrl(

				input		wire				clk,
				input		wire				rst_n,
				input		wire	[2:0]		flag,	
				output	reg	[19:0]	freq
//				output	reg	[1:0]		wave_sel,
//				output	reg	[1:0]		amp_sel
		
			);
	
	reg [19:0]	freq_sin;
   reg [1:0]	function_sel;
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)
		function_sel <= 2'b00;
	else	if(flag[0] == 1'b1)	function_sel <= function_sel + 1'b1;
	else	function_sel <= function_sel;
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)	begin
		freq_sin 		<= 	600_000;

	end
	else	begin
		case(function_sel)
			2'b00	:	begin
				if(flag[1] == 1'b1)			freq_sin <= freq_sin + 20'd100_000;
				else if(flag[2] == 1'b1)	freq_sin <= freq_sin - 20'd100_000;
				else								freq_sin <= freq_sin;
//				if(flag[0] == 1'b1)			amp_sin <= amp_sin + 1'b1;
//				else								amp_sin <= amp_sin;
			end
			2'b01	:	begin
				if(flag[1] == 1'b1)			freq_sin <= freq_sin + 20'd10_000;
				else if(flag[2] == 1'b1)	freq_sin <= freq_sin - 20'd10_000;
				else								freq_sin <= freq_sin;
//				if(flag[0] == 1'b1)			amp_tri <= amp_tri + 1'b1;
//				else								amp_tri <= amp_tri;
			end
			2'b10	:	begin
				if(flag[1] == 1'b1)			freq_sin <= freq_sin + 20'd1000;
				else if(flag[2] == 1'b1)	freq_sin <= freq_sin - 20'd1000;
				else								freq_sin <= freq_sin;
//				if(flag[0] == 1'b1)			amp_squr <= amp_squr + 1'b1;
//				else								amp_squr <= amp_squr;
			end
			2'b11	:	begin
				if(flag[1] == 1'b1)			freq_sin <= freq_sin + 20'd100;
				else if(flag[2] == 1'b1)	freq_sin <= freq_sin - 20'd100;
				else								freq_sin <= freq_sin;
//				if(flag[0] == 1'b1)			amp_sawtooth <= amp_sawtooth + 1'b1;
//				else								amp_sawtooth <= amp_sawtooth;
			end
			default	:	begin
				freq_sin 		<= 	50000;
			end
		endcase
	end
	
	always @(posedge clk or negedge rst_n)
		if(!rst_n)	begin
			freq 		<= 	20'd0;
//			amp_sel 	<= 	2'd0;
		end
		else	begin
			freq 		<= 	freq_sin;
		end
//			case(wave_sel)
//				2'b00	:	begin
//					freq 		<= 	freq_sin;
//					amp_sel 	<= 	amp_sin;
//				end
//				2'b01	:	begin
//					freq 		<= 	freq_sin;
//					amp_sel 	<= 	amp_tri;
//				end
//				2'b10	:	begin
//					freq 		<= 	freq_squr;
//					amp_sel 	<= 	amp_squr;
//				end
//				2'b11	:	begin
//					freq 		<= 	freq_sawtooth;
//					amp_sel 	<= 	amp_sawtooth;
//				end	
//				default	:	begin
//					freq 		<= 	freq_sin;
//					amp_sel 	<= 	amp_sin;
//				end
			
	
endmodule
