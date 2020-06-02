`include "priority_encoder_2.v"
`include "priority_encoder_4.v"

module priority_encoder(number, leading_one, validity);

input [9 : 0]number;		// THis Value is after the decimal 
output [3 : 0]leading_one;
output validity;

// assign number = 10'b0110000001;
// always@(*)
// begin
//     $display("num = %b, validity = %b, leading_one = %b", number, validity, leading_one);
// end

assign validity = | number;
wire v1, v2, v3;
wire [4 : 0] partial_leading_one;
priority_encoder_2 p1(number[9 : 8], partial_leading_one[4], v1, 1'b1);
priority_encoder_4 p2(number[7 : 4], partial_leading_one[3 : 2], v2, ~v1);
priority_encoder_4 p3(number[3 : 0], partial_leading_one[1 : 0], v3, ~v2 & ~v1);

assign leading_one[3] = validity & v1;
assign leading_one[2] = validity & v2;
assign leading_one[1] = validity & (partial_leading_one[1] | partial_leading_one[3]);
assign leading_one[0] = validity & (partial_leading_one[0] | partial_leading_one[2] | partial_leading_one[4]);













endmodule