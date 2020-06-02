`timescale 1ns/1ps
`include "regfile.v"
module top;
 // Inputs
 reg [31:0] I1;
 reg [3:0] si1;
 reg [3:0] so1;
 reg [3:0] so2;
 reg RD;
 reg WR;
 reg rst;
 reg EN;
 reg clk;
// Outputs
 wire [31:0] O1;
 wire [31:0] O2;
 // Instantiate the Unit Under Test (UUT)
 regfile uut (.I1(I1), .si1(si1), .O1(O1), .so1(so1), .O2(O2), .so2(so2), .RD(RD), .WR(WR), .rst(rst), .EN(EN), .clk(clk));

 initial begin
  // Initialize Inputs
  I1  = 32'b0;
  si1  = 4'b1;
  so1  = 4'b0;
  so2  = 4'b1;
  RD  = 1'b0;
  WR  = 1'b1;
  rst  = 1'b1;
  EN  = 1'b0;
  clk  = 1'b0;
  // Wait 100 ns for global reset to finish
  #100;        
  // Add stimulus here
   rst  = 1'b0;
   EN  = 1'b1;
   #20;
   WR  = 1'b1;
   RD = 1'b0;
   I1  = 32'habcd_efab;
   si1  = 4'h0;
  #20;
   I1  = 32'h0123_4567;
   si1  = 4'h1;
   #20;
   WR  = 1'b0;
   RD     = 1'b1;
   so1  = 4'h0;
   so2  = 4'h1;
 end 
   always begin
  #10;
  clk = ~clk;
#50 $finish;
 end 

initial begin
$monitor("I1 = %h, so1= %b, O1 = %h, so1 = %b, O2 = %h, so2 = %b, RD = %b,WR = %b, rst = %b, EN = %b, clk = %b",I1,si1,O1,so1,O2,so2,RD,WR,rst,EN,clk);
end
endmodule
