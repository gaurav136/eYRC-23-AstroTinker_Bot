// AstroTinker Bot : Task 1A : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 3.125MHz Clock Frequency to 195.125KHz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : clk_3125KHz, duty_cycle
//Output : clk_195KHz, pwm_signal


module pwm_generator(
    input clk_3125KHz,
    input [3:0] duty_cycle,
    output reg clk_195KHz, pwm_signal
);

initial begin
    clk_195KHz = 0; pwm_signal = 1;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////
reg [2:0] counter0 =0;
reg [3:0] counter1 =0;

always @ (posedge clk_3125KHz) begin
    if (!counter0) clk_195KHz = ~clk_195KHz; // toggles clock signal
    counter0 = counter0 + 1'b1; // increment counter // after 7 it resets to 0
end

always @ (posedge clk_3125KHz) begin
    if (counter1 < duty_cycle) pwm_signal =1;
	 else pwm_signal = 0;
	 counter1 = counter1 + 1;
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule