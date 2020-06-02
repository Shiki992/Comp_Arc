module mux2x1(i1, i2, s, s0);

input i1, i2, s0;
output s;
assign s = (((~s0) & i1 ) | ((s0) & i2));
endmodule