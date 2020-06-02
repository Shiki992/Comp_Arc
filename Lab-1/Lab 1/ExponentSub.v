`include "RCA5bit.v"
`include "5Bit2Comp.v"
`include "5Bit1Comp.v"

module ExponentSub (expA,expB,signBit,diffVal);

	input [4:0] expA,expB;
	output [4:0] diffVal;
	output signBit;		// if A-B is positive signBit=1 else 0

	wire [4:0] temp,temp3;
	wire [5:0] temp1,temp2;
	bit2comp b1(expB,temp);
	RCA5bit ra1(expA,temp,temp1);

	assign signBit = temp1[5]; 	// diffVal = signBit&temp1[4:0] || (~signBit&)

	RCA5bit ra2(temp1[4:0],5'b11111,temp2);
	bit1comp b2(temp2[4:0],temp3);

	assign diffVal[0] = (signBit&temp1[0]) | ((~signBit)&temp3[0]);
	assign diffVal[1] = (signBit&temp1[1]) | ((~signBit)&temp3[1]);
	assign diffVal[2] = (signBit&temp1[2]) | ((~signBit)&temp3[2]);
	assign diffVal[3] = (signBit&temp1[3]) | ((~signBit)&temp3[3]);
	assign diffVal[4] = (signBit&temp1[4]) | ((~signBit)&temp3[4]);


	// assign expA = 5'b11001;
	// assign expB = 5'b11100;

	// always @(*) begin
	// $display("%b %b",signBit,diffVal);
	// end

endmodule