module Mux10x1 (AgrtrB,PaddAgrtrB);

	input AgrtrB;
	output [9:0] PaddAgrtrB;

assign PaddAgrtrB[0] = AgrtrB;
assign PaddAgrtrB[1] = AgrtrB;
assign PaddAgrtrB[2] = AgrtrB;
assign PaddAgrtrB[3] = AgrtrB;
assign PaddAgrtrB[4] = AgrtrB;
assign PaddAgrtrB[5] = AgrtrB;
assign PaddAgrtrB[6] = AgrtrB;
assign PaddAgrtrB[7] = AgrtrB;
assign PaddAgrtrB[8] = AgrtrB;
assign PaddAgrtrB[9] = AgrtrB;

endmodule