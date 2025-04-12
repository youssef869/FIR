module multiplier #(parameter WIDTH = 16)(
input  wire [WIDTH-1: 0]  sig,
input  wire [WIDTH-1: 0]  coeff,
output wire [2*WIDTH-1: 0] out
);

assign out = sig * coeff;

endmodule