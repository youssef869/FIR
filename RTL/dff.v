module dff #(parameter WIDTH = 16)(
input  wire signed [WIDTH-1: 0] d,
input  wire              clk,
input  wire              rst_n,
output reg  signed [WIDTH-1: 0]  q
);
always @(posedge clk or negedge rst_n) begin
   if(!rst_n) begin
        q <= 'b0;
   end 
   else begin
        q <= d;
   end
end
endmodule