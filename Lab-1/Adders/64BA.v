`include "32BA.v"
module SixfBitAdder(a,b,cin,sum,carry);
input [63:0] a,b;
input cin;
output [63:0] sum;
output carry;
wire w0;
ThirtyTwoBitAdder sba_0(a[31:0] ,b[31:0],cin,sum[31:0],w0);
ThirtyTwoBitAdder sba_1(a[63:32],b[63:32],w0,sum[63:32],carry);
endmodule