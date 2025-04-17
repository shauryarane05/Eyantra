// EcoMender Bot : Task 1B : Color Detection using State Machines
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will detect colors red, green, and blue using state machine and frequency detection.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Color Detection
//Inputs : clk_1MHz, cs_out
//Output : filter, color

// Module Declaration
module t1b_cd_fd (
    input  clk_1MHz, cs_out,
    output reg [1:0] filter, color
);

// red   -> color = 1;
// green -> color = 2;
// blue  -> color = 3;

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
parameter ST_CLEAR = 2'b00, 
          ST_GREEN = 2'b01, 
          ST_BLUE  = 2'b10, 
          ST_RED   = 2'b11;

reg [1:0] state;
reg [8:0] counter;
reg [1:0] color_r ;
reg [9:0] OP [0:1];

initial begin // editing this initial block is allowed
   state = ST_GREEN;
    OP [1] <= 7'd0;
    OP [0] <= 7'd0;
    filter = 2'b00;
    color = 2'b00;
    counter = 9'd0;
end

always @(posedge clk_1MHz) begin
    case (state) 
        ST_GREEN: begin
            filter <= 2'b11;
                 if(OP [1] > OP [0]) begin
                    OP [0] <= OP [1];
                    color_r <= 2'b10;
                end
            if (counter < 9'd499) begin
                counter <= counter + 9'd1;
            end 
            else begin
                counter <= 9'd0;
                state <= ST_RED;
            end
        end

        ST_CLEAR: begin
            filter <= 2'b10;
            color <= color_r;
            OP[0] <= 7'd0;
            if (counter < 9'd0) begin
                counter <= counter + 9'd1;
            end 
            else begin
                counter <= 9'd0;
                state <= ST_GREEN;
            end
        end

        ST_BLUE: begin
            filter <= 2'b01;
               if(OP [1] > OP [0]) begin
                    OP [0] <= OP [1];
                    color_r <= 2'b11;
                end
            if (counter < 9'd499) begin
                counter <= counter + 9'd1;
            end 
            else begin
                counter <= 9'd0;
                state <= ST_CLEAR;
            end
        end

        ST_RED: begin
            filter <= 2'b00;
               if(OP [1] > OP [0]) begin
                    OP [0] <= OP [1];
                    color_r <= 2'b01;
                end
            if (counter < 9'd499) begin
                counter <= counter + 9'd1;
            end 
            else begin
                counter <= 9'd0;
                state <= ST_BLUE;
            end
        end

        default: begin
            state = ST_GREEN;
        end
    endcase
end
always @(posedge cs_out) begin
        if (counter == 9'd0) begin
                OP[1] <= 0;
        end
        else if (counter < 9'd24) begin
                OP[1] <= OP[1] + 10'd1;
        end
    end
////////////////// DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////
endmodule