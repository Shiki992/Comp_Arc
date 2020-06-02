`include "Instruction_L1.v"

module test;

reg [16:1] wafull;
reg [16:1] writeval;
reg [16:1] rafull;
wire [16:1] readval;
wire WriteHit, ReadHit;
reg mode;
reg clk;

Instruction_L1 inscache (wafull, writeval, 
    rafull, readval, 
    WriteHit, ReadHit, 
    clk, mode);

initial begin
    $monitor($time, ": mode: %b, WriteAdd = %b (%d), WriteVal = %b (%d) : WHit -  %b \n\t\t\t\t\tReadAdd = %b (%d), ReadVal = %b (%d) : RHit -  %b", 
    mode,
    wafull, wafull,
    writeval, writeval,
    WriteHit,  
    rafull, rafull, 
    readval, readval, 
    ReadHit);
end

initial begin
    clk = 1'b0;
    mode = 1'b1; // Write
    wafull = 16'd0;
    writeval = 16'd23;
    rafull = 16'd0;

    #100 mode = 1'b0; rafull = 16'd0;
    #100 mode = 1'b1; wafull = 16'd1; writeval = 16'd42;
    #100 mode = 1'b0; rafull = 16'd1;
    #100 mode = 1'b1; wafull = 16'd8; writeval = 16'd62;
    #100 mode = 1'b0; rafull = 16'd8;

    #1000 $finish;
end

always #50 clk = !clk; 

endmodule