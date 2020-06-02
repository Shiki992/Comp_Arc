`include "EightBA.v"
module top();
reg [7:0] a,b;
reg cin;
wire [7:0] sum;
wire carry;
EightBitAdder eba_0(a,b,cin,sum,carry);
initial
begin
  a[0]=0;a[1]=1;a[2]=0;a[3]=1;a[4]=0;a[5]=1;a[6]=0;a[7]=1;
  b[0]=1;b[1]=0;b[2]=1;b[3]=0;b[4]=1;b[5]=0;b[6]=1;b[7]=0;
  cin=0;
end
initial
$monitor($time," A=%b%b%b%b%b%b%b%b B=%b%b%b%b%b%b%b%b Cin=%b Sum=%b%b%b%b%b%b%b%b Carry=%b",a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],b[0],b[1],b[2],b[3],b[4],b[5],b[6],b[7],cin,sum[0],sum[1],sum[2],sum[3],sum[4],sum[5],sum[6],sum[7],carry);
endmodule