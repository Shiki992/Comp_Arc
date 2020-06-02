`include "32BA.v"
module top();
reg [31:0] a,b;
reg cin;
wire [31:0] sum;
wire carry;
ThirtyTwoBitAdder eba_0(a,b,cin,sum,carry);
initial
begin
  a=$random%4294967295;
  b=$random%4294967295;
  cin=$random%2;
end
initial
$monitor($time," A=%d B=%d Cin=%d Sum=%d Carry=%d",a,b,cin,sum,carry);
endmodule