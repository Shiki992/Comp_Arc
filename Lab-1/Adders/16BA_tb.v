`include "16BA.v"
module top();
reg [15:0] a,b;
reg cin;
wire [15:0] sum;
wire carry;
SixteenBitAdder eba_0(a,b,cin,sum,carry);
initial
begin
  a=$random%65535;
  b=$random%65535;
  cin=0;
end
initial
$monitor($time," A=%d B=%d Cin=%d Sum=%d Carry=%d",a,b,cin,sum,carry);
endmodule