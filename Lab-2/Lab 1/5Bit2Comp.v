module bit2comp(inp,out);

input [4:0] inp;
output [4:0] out;

wire [4:0] temp;
wire [5:0] temp1;
// assign inp = 5'b11100;
// assign out = ~inp;

// always @(*) begin
// $display("%b",out);
// end

assign temp = ~inp;
RCA5bit ra1 (temp,5'b00001,temp1);	//out[5] is Carry Bit if 1 means positive

assign out = temp1[4:0];

endmodule 