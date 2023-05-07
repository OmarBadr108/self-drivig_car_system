module tesla_model_X_tb ();
reg [7:0] speed_limit,car_speed;
reg [6:0] leading_distance ;
reg clk , rst ;
wire unlock_doors,accelerate_car ;
wire [1:0] ns ,cs ;

tesla_model_X m1 (speed_limit,car_speed,leading_distance,clk,rst,unlock_doors,accelerate_car);
	integer i ;
	initial begin 
 		clk = 0; 
 		for(i=0;i<10000;i=i+1) 
 		#2 clk = ~clk;
	end

	initial begin 
	rst = 1 ;
	#10;
	rst = 0 ;
	car_speed = 0 ;
	//cs = 2'b00 ;
	//ns = 2'b00 ;
	speed_limit = 8'd120;
	#10;
	@(negedge clk);
	leading_distance = 7'd50 ; //leading distance > min dist (should accelerate)
	#10;
	@(negedge clk);
	leading_distance = 7'd50 ;// should remain accelerate
	car_speed = 8'd80 ; 
	#10;
	@(negedge clk);
	leading_distance = 7'd50 ;// should decelerate
	car_speed = 8'd125 ; 
	#10;
	@(negedge clk);
	leading_distance = 7'd50 ;// should back to accelerate
	car_speed = 8'd100 ; 
	#10;
	@(negedge clk);
	leading_distance = 7'd30 ; // should back to decelerate
	car_speed = 8'd110 ; 
	#10;
	@(negedge clk);
	leading_distance = 7'd20 ;// should stop
	car_speed = 8'd100 ; 
	#10;
	@(negedge clk);
	leading_distance = 7'd50 ;
	//car_speed = 8'd100 ; // should accelerate
	end
endmodule

