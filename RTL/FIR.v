module FIR #(parameter WIDTH = 16)(
input  wire               clk,
input  wire               rst_n,
input  wire signed [WIDTH-1: 0]  i_signal,  //x[n]
output wire signed [2*WIDTH-1: 0] o_signal //y[n]
);

// Coefficients
parameter b0  = 16'hFFB1;
parameter b1  = 16'hFEF4;
parameter b2  = 16'hFED3;
parameter b3  = 16'h0000;
parameter b4  = 16'h056D;
parameter b5  = 16'h0EAF;
parameter b6  = 16'h199A;
parameter b7  = 16'h2381;
parameter b8  = 16'h2381;
parameter b9  = 16'h199A;
parameter b10 = 16'h0EAF;
parameter b11 = 16'h056D;
parameter b12 = 16'h0000;
parameter b13 = 16'hFED3;
parameter b14 = 16'hFEF4;
parameter b15 = 16'hFFB1;



wire signed [WIDTH-1: 0] i_signal_1, i_signal_2, i_signal_3, i_signal_4, i_signal_5, i_signal_6, i_signal_7, i_signal_8, i_signal_9, i_signal_10, i_signal_11, i_signal_12, i_signal_13, i_signal_14, i_signal_15;
wire signed [2*WIDTH-1: 0] mul_0, mul_15;
wire signed [2*WIDTH-1: 0] add_1, add_2, add_3, add_4, add_5, add_6, add_7, add_8, add_9, add_10, add_11, add_12, add_13, add_14;

dff dff_u0(.d(i_signal),.clk(clk),.rst_n(rst_n),.q(i_signal_1)); //i_signal_1 is x[n-1]

multiplier multiplier_u0 (.sig(i_signal),.coeff(b0),.out(mul_0)); 

fir_block fir_block_u1(.sig(i_signal_1),.adder_in(mul_0),.coeff(b1),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_2),.adder_out(add_1));

fir_block fir_block_u2(.sig(i_signal_2),.adder_in(add_1),.coeff(b2),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_3),.adder_out(add_2));

fir_block fir_block_u3(.sig(i_signal_3),.adder_in(add_2),.coeff(b3),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_4),.adder_out(add_3));

fir_block fir_block_u4(.sig(i_signal_4),.adder_in(add_3),.coeff(b4),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_5),.adder_out(add_4));

fir_block fir_block_u5(.sig(i_signal_5),.adder_in(add_4),.coeff(b5),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_6),.adder_out(add_5));

fir_block fir_block_u6(.sig(i_signal_6),.adder_in(add_5),.coeff(b6),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_7),.adder_out(add_6));

fir_block fir_block_u7(.sig(i_signal_7),.adder_in(add_6),.coeff(b7),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_8),.adder_out(add_7));

fir_block fir_block_u8(.sig(i_signal_8),.adder_in(add_7),.coeff(b8),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_9),.adder_out(add_8));

fir_block fir_block_u9(.sig(i_signal_9),.adder_in(add_8),.coeff(b9),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_10),.adder_out(add_9));

fir_block fir_block_u10(.sig(i_signal_10),.adder_in(add_9),.coeff(b10),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_11),.adder_out(add_10));

fir_block fir_block_u11(.sig(i_signal_11),.adder_in(add_10),.coeff(b11),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_12),.adder_out(add_11));

fir_block fir_block_u12(.sig(i_signal_12),.adder_in(add_11),.coeff(b12),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_13),.adder_out(add_12));

fir_block fir_block_u13(.sig(i_signal_13),.adder_in(add_12),.coeff(b13),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_14),.adder_out(add_13));

fir_block fir_block_u14(.sig(i_signal_14),.adder_in(add_13),.coeff(b14),.clk(clk),.rst_n(rst_n),.delayed_out(i_signal_15),.adder_out(add_14));


multiplier multiplier_u14 (.sig(i_signal_15),.coeff(b15),.out(mul_15));

adder #(.WIDTH(32)) adder_u15(.in0(mul_15),.in1(add_14),.out(o_signal)); 

endmodule