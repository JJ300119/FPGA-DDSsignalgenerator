module edge_detect(
			
				input		wire			clk,
				input		wire			rst_n,
				input		wire			level,
				output	wire			edge_pos,
				output	wire			edge_neg
				
			);
	
	reg		reg_syn;
	reg		reg_edge;
	
	always @(posedge clk or negedge rst_n)
	if(!rst_n)	begin
		reg_syn <= 1'b1;
		reg_edge <= 1'b1;
	end
	else	begin
		reg_syn <= level;
		reg_edge <= reg_syn;
	end
	
	assign edge_pos = reg_syn & (~reg_edge);
	assign edge_neg = (~reg_syn) & reg_edge;
	
endmodule
