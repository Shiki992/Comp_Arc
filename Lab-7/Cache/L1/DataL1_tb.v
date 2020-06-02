`include "DataL1.v"

module test;

reg [16:1] wafull;
reg [16:1] writeval;
reg [16:1] ReadAddress_Full;
wire [16:1] readval;
wire WriteHit, ReadHit;
reg write;
reg read;
reg clk;

Data_L1 datacache (wafull, writeval, 
    ReadAddress_Full, readval, 
    WriteHit, ReadHit, 
    clk, write, read);

initial begin
    $monitor($time, ": WriteAdd = %b (%d), WriteVal = %b (%d) : WHit -  %b \n\t\t\t\t\tReadAdd = %b (%d), ReadVal = %b (%d) : RHit -  %b", 
    wafull, wafull,
    writeval, writeval,
    WriteHit,  
    ReadAddress_Full, ReadAddress_Full, 
    readval, readval, 
    ReadHit);
end

initial begin
    clk = 1'b0;
    write = 1'b1;
    read = 1'b1;
    wafull = 16'd0;
    writeval = 16'd23;
    ReadAddress_Full = 16'd0;

    #100 wafull = 16'd0; writeval = 16'd31; ReadAddress_Full = 16'd0;
    #100 wafull = 16'd1; writeval = 16'd42; ReadAddress_Full = 16'd0;
    #100 wafull = 16'd2; writeval = 16'd51; ReadAddress_Full = 16'd1;
    #100 wafull = 16'd8; writeval = 16'd62; ReadAddress_Full = 16'd2;
    #1000 $finish;
end

always #100 clk = !clk; 

endmodule