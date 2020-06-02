`include "FullAdder.v"

module RCA5bit(inpA,inpB,out);
input [4:0] inpA,inpB;
output [5:0] out;

wire w0,w1,w2,w3,w4;

FullAdder fa0 (inpA[0],inpB[0],1'b0,out[0],w0);
FullAdder fa1 (inpA[1],inpB[1],w0,out[1],w1);
FullAdder fa2 (inpA[2],inpB[2],w1,out[2],w2);
FullAdder fa3 (inpA[3],inpB[3],w2,out[3],w3);
FullAdder fa4 (inpA[4],inpB[4],w3,out[4],out[5]);

endmodule 