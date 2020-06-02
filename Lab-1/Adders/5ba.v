//`include "FullAdder.v"
module FiveBitAdder (a,b,cin,sum,carry);
input [4:0] a , b ;
input cin ;
output [4:0] sum ;
output carry ;
wire w0,w1,w2,w3;
FullAdder fa_0(a[0],b[0],cin,sum[0],w0);
FullAdder fa_1(a[1],b[1],w0,sum[1],w1);
FullAdder fa_2(a[2],b[2],w1,sum[2],w2);
FullAdder fa_3(a[3],b[3],w2,sum[3],w3);
FullAdder fa_4(a[4],b[4],w3,sum[4],carry);

endmodule