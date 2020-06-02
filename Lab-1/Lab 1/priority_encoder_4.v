module priority_encoder_4(number_4, leading_one_4, validity_4, prev_validity_4);

input [3 : 0] number_4;
input prev_validity_4;
output validity_4;
output [1 : 0] leading_one_4;

// assign number_4 = 4'b1101;
// assign prev_validity_4 = 1'b1;
// always@(*)
// begin
//     $display("num = %b, validity = %b, leading_one = %b", number_4, validity_4, leading_one_4);
// end


assign validity_4 = (| number_4) & prev_validity_4;
assign leading_one_4[0] = validity_4 & (number_4[3] | (number_4[1] & (~number_4[2])));
assign leading_one_4[1] = validity_4 & (number_4[3] | number_4[2]);


endmodule