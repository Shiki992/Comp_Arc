module priority_encoder_2(number_2, leading_one_2, validity_2, prev_validity_2);

input [1 : 0] number_2;
input prev_validity_2;
output validity_2;
output leading_one_2;

assign validity_2 = (| number_2) & prev_validity_2;
assign leading_one_2 = validity_2 & (number_2[1]);


endmodule