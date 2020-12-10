module led_on (
				input clk,
				input rst_n,
				input flag,
				output reg	[3:0]led
					);
	reg [1:0]led_control;


always @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		led_control<=4'b0;
		end
	else if(flag) 
		led_control<=led_control+2'b1;
	else
		led_control<=led_control;
		
always @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		led<=2'b0;
		end
	else begin
		case(led_control) 
		 2'b00:led<=4'b1000;
		 2'b01:led<=4'b0100;
		 2'b10:led<=4'b0010;
		 2'b11:led<=4'b0001;
		 default:led<=4'b0;
		 endcase
	 end

endmodule
