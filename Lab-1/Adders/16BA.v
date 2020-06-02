`include "EightBA.v"
module SixteenBitAdder ( a , b , cin , sum , carry ) ;
input [15:0] a , b ;
input cin ;
output [15:0] sum ;
output carry ;
wire w0;
EightBitAdder eba_0(a[7:0] ,b[7:0],cin,sum[7:0],w0);
EightBitAdder eba_1(a[15:8],b[15:8],w0,sum[15:8],carry);
endmodule