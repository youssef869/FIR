module fir_block #(parameter WIDTH = 16)(
input  wire signed [WIDTH-1: 0] sig, //from prev block delay element 
input  wire signed [2*WIDTH-1: 0]   adder_in, // from prev adder
input  wire signed [WIDTH-1: 0] coeff,
input  wire              clk,
input  wire              rst_n,
output wire signed [WIDTH-1: 0] delayed_out,
output wire signed [2*WIDTH-1: 0]   adder_out
);

wire signed [2*WIDTH-1: 0] multiplier_out;

dff #(.WIDTH(WIDTH)) dff_u0(.d(sig),.clk(clk),.rst_n(rst_n),.q(delayed_out));

multiplier # (.WIDTH(WIDTH)) multiplier_u0(.sig(sig),.coeff(coeff),.out(multiplier_out));

adder #(.WIDTH(2*WIDTH)) adder_u0(.in0(multiplier_out), .in1(adder_in), .out(adder_out));


endmodule