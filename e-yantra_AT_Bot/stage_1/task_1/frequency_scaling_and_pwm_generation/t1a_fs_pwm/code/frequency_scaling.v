
// AstroTinker Bot : Task 1A : Frequency Scaling
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 50M Clock Frequency to 3.125MHz.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Frequency Scaling
//Inputs : clk_50M
//Output : clk_3125KHz


module frequency_scaling (
    input clk_50M,
    output reg clk_3125KHz
);

initial begin
    clk_3125KHz = 0;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
reg[2:0] counter = 0;

always @(posedge clk_50M) begin
	if(!counter) clk_3125KHz= ~clk_3125KHz;
	counter = counter +1'b1;
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule
