module bit2comp11(inp,out);

input [10:0] inp;
output [10:0] out;

wire [15:0] temp;
wire [11:0] temp1;
// assign inp = 5'b11100;
// assign out = ~inp;

// always @(*) begin
// $display("%b",out);
// end

//assign temp = ~inp;
assign temp = {{5'b00000} ,~inp};
wire [16:0] RDout;

RecursiveDoubling rd1 (temp, 16'b0000000000000001, 1'b0, RDout[15:0], RDout[16]);
//RCA11bit ra1 (temp,5'b00001,temp1);	//out[5] is Carry Bit if 1 means positive

assign out = RDout[10:0];

endmodule 