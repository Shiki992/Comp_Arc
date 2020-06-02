`include "FullAdder.v"
module top();
reg a,b,cin;
wire sum,carry;
FullAdder fa_0(a,b,cin,sum,carry);
    initial
        begin
          a=0;b=0;cin=0;
          #5 cin=1;
          #5 b=1;cin=0;
          #5 cin=1;
          #5 a=1;b=0;cin=0;
          #5 cin=1;
          #5 b=1;cin=0;
          #5 cin=1;

        end
    initial
    $monitor($time," A=%b B=%b Cin=%b Sum=%b Carry=%b",a,b,cin,sum,carry);
endmodule