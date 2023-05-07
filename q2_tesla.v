module tesla_model_X (speed_limit,car_speed,leading_distance,clk,rst,unlock_doors,accelerate_car);
parameter MIN_DISTANCE =7'd40 ;
parameter STOP = 2'b00 ;
parameter ACCELERATE = 2'b01 ;
parameter DECELERATE = 2'b11 ;
input [7:0] speed_limit;
input [7:0] car_speed ;
input [6:0] leading_distance ;
input clk , rst ;
output reg unlock_doors,accelerate_car ;
reg [1:0] ns , cs ;

always @(posedge clk or posedge rst) begin
	if (rst) 
		cs <= STOP ;
	else 
		cs <= ns ;
end

always @(*) begin
	case (cs)
		STOP : begin
			if (leading_distance >= MIN_DISTANCE) 
				ns = ACCELERATE ;
			else 
				ns = STOP ;
				end
		ACCELERATE : begin
			if ((leading_distance >= MIN_DISTANCE) && (car_speed < speed_limit))
				ns = ACCELERATE ;
			else 
				ns = DECELERATE ;
				end
		DECELERATE : begin
			if ((leading_distance >= MIN_DISTANCE) && (car_speed < speed_limit))
				ns = ACCELERATE ;
			else 
				ns = STOP;
				end
		default : ns = STOP ;
	endcase
end

always @(*)begin
	if (cs == STOP)
		unlock_doors = 1 ;
	else 
		unlock_doors = 0 ;
	if (cs == ACCELERATE)
		accelerate_car = 1 ;
	else 
		accelerate_car = 0 ;
end

endmodule 