`include "FourBA.v"
module top();
reg [3:0] a,b;
reg cin;
wire [3:0] sum;
wire carry;
FourBitAdder fba_0(a,b,cin,sum,carry);
initial
begin
  a=$random%16;
  b=$random%16;
  cin=0;
end
initial
$monitor($time," A=%b B=%b Cin=%b Sum=%b Carry=%b",a,b,cin,sum,carry);
endmodule