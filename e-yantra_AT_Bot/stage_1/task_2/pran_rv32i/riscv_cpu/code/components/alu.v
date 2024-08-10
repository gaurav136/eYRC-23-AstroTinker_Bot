
// alu.v - ALU module

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [3:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // zero flag
);

reg [31:0] shift, mask;

always @(*) begin

    // Default assignments to avoid latches
    shift = 32'b0;
    mask = 32'b0;
    alu_out = 32'b0;

    case (alu_ctrl)
        4'b0000:  alu_out = a + b;       // ADD
        4'b1000:  alu_out = a + ~b + 1;  // SUB
		4'b0001:  alu_out = a << {27'b0,b[4:0]}; //SLL
        4'b0010:    
                begin                   // SLT
                    if (a[31] != b[31]) alu_out = a[31] ? 1 : 0; 
                    else alu_out = a < b ? 1 : 0;
				end

	    4'b0011: alu_out = a < b ? 1 : 0; //SLTU
		4'b0100: alu_out = a ^ b; //XOR
		4'b0101: alu_out = a >> {27'b0,b[4:0]}; //SRL
		4'b1101:   
                begin
                    shift = a >> {27'b0,b[4:0]}; //SRA
                    if(a[31]==1)begin
                        mask = ~(32'hFFFF_FFFF >> {27'b0,b[4:0]});
                    end
                    else
                    begin
                        mask = 32'h00000_0000;
                    end
                    alu_out = shift | mask;
                end

		4'b0110: alu_out = a | b; //OR
		4'b0111: alu_out = a & b; //AND
		 
        default: alu_out = 0;
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0;

endmodule
