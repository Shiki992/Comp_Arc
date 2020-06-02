`include "fpmul.v"
module top();
reg [15:0] a,b;
wire [15:0] out;
fpmul f1(a[15],b[15],a[9:0],b[9:0],a[14:10],b[14:10],out);
initial
begin 
    a=16'b0110100101010000;
    b=16'b0100011001001000;
end 

initial 
     begin
	$monitor("%b",out);



end
endmodule 