module pwm_generator(
    input clk_1MHz,
    input [3:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);

initial begin
    clk_500Hz = 1; pwm_signal = 1;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

reg[10:0] counter = 11'd0;
reg delayed_clk_500Hz = 1;

always @ (posedge clk_1MHz) begin
		
		if(counter == 1999)begin
			delayed_clk_500Hz <= ~delayed_clk_500Hz;
			counter <= 0;
		end
		else if(counter == 999)begin
			delayed_clk_500Hz <= ~delayed_clk_500Hz;
			counter <= counter + 1;
		end
		else begin
			counter <= counter + 1;
		end
		clk_500Hz <= delayed_clk_500Hz;
		if(counter < (pulse_width*100))begin
			pwm_signal <= 1;
		end
		else begin
			pwm_signal <= 0;
		end
		
end


//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule