`timescale 1ns / 1ps

module fir_tb();

localparam CORDIC_CLK_PERIOD = 2;                  
localparam FIR_CLK_PERIOD = 10;                    

localparam signed [15:0] PI_POS = 16'h6488;       
localparam signed [15:0] PI_NEG = 16'h9B78;        

localparam phase_inc_2MHZ = 262;                   
localparam phase_inc_30MHZ= 3932; 
localparam phase_inc_45MHZ = 5900;          


localparam TEST_CASE = 1; // possible values of TEST_CASE are 1 (2MHz input), 2 (30MHz input), 3 (2MHz input + noise at 45MHz)

reg signed [15:0] in_signal;


reg cordic_clk;
reg fir_clk;
reg rst_n;
reg phase_tvalid = 1'b0;
reg signed [15:0] phase_2M  = 0;                 
reg signed [15:0] phase_30M = 0;              
reg signed [15:0] phase_45M = 0;  

wire tvalid_2M;                           
wire signed [15:0] sin_2M,cos_2M;             

wire tvalid_30M;                         
wire signed [15:0] sin_30M,cos_30M;


wire tvalid_45M;                         
wire signed [15:0] sin_45M,cos_45M;


reg signed [15:0] noise = 'b0;             
wire signed [31:0] filtered_signal;               


initial begin
    cordic_clk = 1'b0;
    forever #(CORDIC_CLK_PERIOD/2) cordic_clk = ~cordic_clk;
end   

initial begin
    rst_n = 0;
    #(5 * FIR_CLK_PERIOD);
    rst_n = 1;
end 

initial begin
    fir_clk = 1'b0;
    forever #(FIR_CLK_PERIOD/2) fir_clk = ~fir_clk;
end

always @(*) begin
        if(TEST_CASE == 1) begin
             in_signal = sin_2M;   
        end
        else if(TEST_CASE == 2) begin
             in_signal = sin_30M;
        end
        else begin
             in_signal = sin_2M + noise;
        end
end

always@(posedge cordic_clk) begin
        phase_tvalid <= 1'b1;

        if(phase_2M+ phase_inc_2MHZ < PI_POS ) begin
            phase_2M <= phase_2M + phase_inc_2MHZ;
        end

        else begin
            phase_2M <= PI_NEG + (phase_2M+ phase_inc_2MHZ - PI_POS);
        end 

        if(phase_30M+ phase_inc_30MHZ <= PI_POS ) begin
            phase_30M <= phase_30M + phase_inc_30MHZ;
        end

        else begin
            phase_30M <= PI_NEG + (phase_30M+ phase_inc_30MHZ - PI_POS);
        end


        if(phase_45M+ phase_inc_45MHZ < PI_POS ) begin
            phase_45M <= phase_45M + phase_inc_45MHZ;
        end

        else begin
            phase_45M <= PI_NEG + (phase_45M+ phase_inc_45MHZ - PI_POS);
        end 
end

    
always@(posedge fir_clk) begin
     noise <= (sin_30M + sin_45M) / 2; 
end


 FIR DUT
(
.clk(fir_clk),
.rst_n(rst_n),
.i_signal(in_signal),
.o_signal(filtered_signal)
);


cordic_0 cordic_u0 (
.aclk(cordic_clk),
.s_axis_phase_tvalid(phase_tvalid),
.s_axis_phase_tdata(phase_2M),
.m_axis_dout_tvalid(tvalid_2M),
.m_axis_dout_tdata({sin_2M,cos_2M})
);


cordic_0 cordic_u1 (
.aclk(cordic_clk),
.s_axis_phase_tvalid(phase_tvalid),
.s_axis_phase_tdata(phase_30M),
.m_axis_dout_tvalid(tvalid_30M),
.m_axis_dout_tdata({sin_30M,cos_30M})
);

cordic_0 cordic_u2 (
.aclk(cordic_clk),
.s_axis_phase_tvalid(phase_tvalid),
.s_axis_phase_tdata(phase_45M),
.m_axis_dout_tvalid(tvalid_45M),
.m_axis_dout_tdata({sin_45M,cos_45M})
);
endmodule
