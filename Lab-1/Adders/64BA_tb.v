`include "64BA.v"
module top();
reg [63:0] a,b;
reg cin;
wire [63:0] sum;
wire carry;
SixfBitAdder sba_0(a,b,cin,sum,carry);
initial
begin
  a=$random%1844674407000000000;
  b=$random%1844674407000000000;
  cin=$random%2;
end
initial
$monitor($time," A=%d B=%d Cin=%d Sum=%d Carry=%d",a,b,cin,sum,carry);
endmodule