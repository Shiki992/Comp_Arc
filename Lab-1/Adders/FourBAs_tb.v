`include "FourBA.v"
module fourtest();
reg cin;
wire carry;
FourBitAdder HA01(a,b,cin,sum,carry);
	initial
		begin
cin=0;
#5 cin=0;	
end
initial
		$monitor($time,"Cin=%b Carry=%b ",cin,carry,);
endmodule