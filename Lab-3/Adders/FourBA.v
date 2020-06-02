`include "FullAdder.v"
module FourBitAdder (a,b,cin,sum,carry);
input [3:0] a , b ;
input cin ;
output [3:0] sum ;
output carry ;
wire w0,w1,w2;
FullAdder fa_0(a[0],b[0],cin,sum[0],w0);
FullAdder fa_1(a[1],b[1],w0,sum[1],w1);
FullAdder fa_2(a[2],b[2],w1,sum[2],w2);
FullAdder fa_3(a[3],b[3],w2,sum[3],carry);

endmodule