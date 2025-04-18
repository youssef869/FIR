module multiplier #(parameter WIDTH = 16)(
input  wire signed [WIDTH-1: 0]  sig,
input  wire signed [WIDTH-1: 0]  coeff,
output wire signed [2*WIDTH-1: 0] out
);

assign out = sig * coeff;

endmodule