`include "cla.v"
module top(
    
);
wire [7:0] sum; //wire declaration 
wire cout; 
reg [7:0] a; //reg declaration 
reg [7:0] b; 
reg cin;
cla8 c1(sum,cout, a,b, cin);
initial
begin
  assign a=8'd10;
  assign b=8'd12;
  assign cin=1'b0;
end 
initial
begin
  $monitor("Sum= %d",sum);
end
endmodule // top