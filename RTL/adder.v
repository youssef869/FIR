module adder #(parameter WIDTH = 16)(
input  wire signed [WIDTH-1: 0]  in0,
input  wire signed [WIDTH-1: 0]  in1,
output wire signed [WIDTH-1: 0]  out
);
assign out = in0 + in1;

endmodule