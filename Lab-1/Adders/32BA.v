`include "16BA.v"
module ThirtyTwoBitAdder(a,b,cin,sum,carry);
input [31:0] a,b;
input cin;
output [31:0] sum;
output carry;
wire w0;
SixteenBitAdder sba_0(a[15:0] ,b[15:0],cin,sum[15:0],w0);
SixteenBitAdder sba_1(a[31:16],b[31:16],w0,sum[31:16],carry);
endmodule