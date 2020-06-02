module RCA11bit(inpA,inpB,out);
input [10:0] inpA,inpB;
output [11:0] out;

wire w0,w1,w2,w3,w4,w5,w6,w7,w8,w9;

FullAdder fa0 (inpA[0],inpB[0],1'b0,out[0],w0);
FullAdder fa1 (inpA[1],inpB[1],w0,out[1],w1);
FullAdder fa2 (inpA[2],inpB[2],w1,out[2],w2);
FullAdder fa3 (inpA[3],inpB[3],w2,out[3],w3);
FullAdder fa4 (inpA[4],inpB[4],w3,out[4],w4);
FullAdder fa5 (inpA[5],inpB[5],w4,out[5],w5);
FullAdder fa6 (inpA[6],inpB[6],w5,out[6],w6);
FullAdder fa7 (inpA[7],inpB[7],w6,out[7],w7);
FullAdder fa8 (inpA[8],inpB[8],w7,out[8],w8);
FullAdder fa9 (inpA[9],inpB[9],w8,out[9],w9);
FullAdder fa10 (inpA[10],inpB[10],w9,out[10],out[11]);

endmodule 