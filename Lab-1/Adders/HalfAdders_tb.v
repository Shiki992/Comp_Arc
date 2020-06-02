`include "HalfAdder.v"
module halftest();
reg a,b;
wire sum,ca;
HalfAdder HA01(a,b,sum,ca);
	initial
		begin
a=0;
b=0;
#5 a=0;	b=1;	
#5 a=0;	b=1;	
#5 a=1;	b=0;	
end
initial
		$monitor($time,"A=%b B=%b Sum=%b Ca=%b ",a,b,sum,ca,);
endmodule