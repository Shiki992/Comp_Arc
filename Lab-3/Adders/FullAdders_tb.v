`include "FullAdder.v"
module fulltest();
reg a,b,cin;
wire sum,carry;
FullAdder HA01(a,b,cin,sum,carry);
	initial
		begin
a=0;
b=0;
cin=0;
#5 a=0;	b=1;	cin=0;	
#5 a=1;	b=1;	cin=0;	
#5 a=0;	b=0;	cin=1;	
#5 a=1;	b=0;	cin=0;	
#5 a=1;	b=1;	cin=0;	
#5 a=0;	b=0;	cin=1;	
#5 a=0;	b=0;	cin=0;	
end
initial
		$monitor($time,"A=%b B=%b Cin=%b Sum=%b Carry=%b ",a,b,cin,sum,carry,);
endmodule