module bit1comp(inp,out);

input [4:0] inp;
output [4:0] out;

assign out = ~inp;

endmodule