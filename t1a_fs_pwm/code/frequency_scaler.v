// EcoMender Bot : Task 1A : Frequency Scaling
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 50MHz Clock Frequency to 1MHz.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Frequency Scaling
//Inputs : clk_50MHz
//Output : clk_1MHz


module frequency_scaler (
    input clk_50MHz,
    output reg clk_1MHz
);

initial begin
    clk_1MHz = 1;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////

 localparam DIVISOR = 25;
 reg [4:0] counter = 5'd0;

    always @(posedge clk_50MHz) begin
        if (counter == DIVISOR) begin
            counter <= 6'd1;
            clk_1MHz <= ~clk_1MHz;  
				
        end else begin
            counter <= counter + 1'b1;
        end
		  
    end
	 
	

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule
