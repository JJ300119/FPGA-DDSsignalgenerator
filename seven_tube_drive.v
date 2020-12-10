module seven_tube_drive (

	input	wire				clk,
	input	wire				rst_n,
	
	input	wire			[23:0]		show_data,
	
	output	reg		[7:0]		seven_tube_seg,
	output	reg		[5:0]		seven_tube_sel
);

	localparam	T_1ms		=	50_000;
	parameter SCAN_FREQ = 200;     //scan frequency
   parameter CLK_FREQ = 50000000; //clock frequency

   parameter SCAN_COUNT = CLK_FREQ /(SCAN_FREQ * 6) - 1;
	
	
	localparam	ONE			=	6'b111_110;
	localparam	TWO			=	6'b111_101;
	localparam	THREE			=	6'b111_011;
	localparam	FOUR			=	6'b110_111;
	localparam	FIVE			=	6'b101_111;
	localparam	SIX			=	6'b011_111;
	
	reg				[5:0]		c_state;
	reg				[5:0]		n_state;
	
	reg				[15:0]	cnt_1ms;
	wire							flag_1ms;
	reg				[3:0]		temp;
	
	reg				[23:0]	reg_show_data;
	
	
reg[31:0] scan_timer;  //scan time counter
reg[3:0] scan_sel;     //Scan select counter

always @(posedge clk or negedge rst_n)
	if(!rst_n)
		reg_show_data <= 0;
	else
		reg_show_data <= show_data;

always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		scan_timer <= 32'd0;
		scan_sel <= 4'd0;
	end
	else if(scan_timer >= SCAN_COUNT)
	begin
		scan_timer <= 32'd0;
		if(scan_sel == 4'd5)
			scan_sel <= 4'd0;
		else
			scan_sel <= scan_sel + 4'd1;
	end
	else
		begin
			scan_timer <= scan_timer + 32'd1;
		end
end

always@(posedge clk or negedge rst_n)
	if(rst_n == 1'b0)
	begin
		seven_tube_sel <= 6'b11_1111;
	end
	else begin
		case(scan_sel)
			//first digital led
			4'd0:seven_tube_sel <= 6'b11_1110;
			4'd1:seven_tube_sel <= 6'b11_1101;
			4'd2:seven_tube_sel <= 6'b11_1011;
			4'd3:seven_tube_sel <= 6'b11_0111;
			4'd4:seven_tube_sel <= 6'b10_1111;
			4'd5:seven_tube_sel <= 6'b01_1111;
			default:	seven_tube_sel <= 6'b11_1111;
		endcase
	end




	
	always @(*) begin
		case (seven_tube_sel)
			ONE			:	temp = reg_show_data[23:20];
			TWO			:	temp = reg_show_data[19:16];
			THREE			:	temp = reg_show_data[15:12];
			FOUR			:	temp = reg_show_data[11:8];
			FIVE			:	temp = reg_show_data[7:4];
			SIX			:	temp = reg_show_data[3:0];
			default		:	temp = 4'd0;
		endcase
	end
	
	always @ (posedge clk, negedge rst_n) begin

	if(rst_n == 1'b0)
	begin
		seven_tube_seg <= 8'hff;
	end
			case (temp)
				0		:	seven_tube_seg <= 8'b1100_0000;
				1		:	seven_tube_seg <= 8'b1111_1001;
				2		:	seven_tube_seg <= 8'b1010_0100;
				3		:	seven_tube_seg <= 8'b1011_0000;
				4		:	seven_tube_seg <= 8'b1001_1001;
				5		:	seven_tube_seg <= 8'b1001_0010;
				6		:	seven_tube_seg <= 8'b1000_0010;
				7		:	seven_tube_seg <= 8'b1111_1000;
				8		:	seven_tube_seg <= 8'b1000_0000;
				9		:	seven_tube_seg <= 8'b1001_0000;
				10		:	seven_tube_seg <= 8'b1000_1000;
				11		:	seven_tube_seg <= 8'b1000_0011;
				12		:	seven_tube_seg <= 8'b1100_0110;
				13		:	seven_tube_seg <= 8'b1010_0001;
				14		:	seven_tube_seg <= 8'b1000_0110;
				15		:	seven_tube_seg <= 8'b1000_1110;
				default:seven_tube_seg <= 8'hFF; //8'b1111_1111
			endcase
	end
	
endmodule 