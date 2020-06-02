`include "RCA11bit.v"

module MantissaSub (mantA,mantB,signBit);

	input [9:0] mantA,mantB;
	output signBit;		// if A-B is positive signBit=1 else 0

	wire [10:0] temp1,temp2,temp3;
	wire [11:0] temp4;
	assign temp1 = {{1'b0},mantA};
	assign temp2 = {{1'b0},mantB};
	bit2comp11 bb1(temp2,temp3);
	RCA11bit ra1(temp1,temp3,temp4);

	assign signBit = temp4[11]; 	// diffVal = signBit&temp1[4:0] || (~signBit&)

	// assign expA = 5'b11001;
	// assign expB = 5'b11100;

	// always @(*) begin
	// $display("%b %b",signBit,diffVal);
	// end

endmodule