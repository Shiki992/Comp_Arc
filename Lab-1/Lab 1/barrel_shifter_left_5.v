module barrel_shifter_l (diff, inp, shifted_num);

input [4 : 0]diff;
input [10 : 0]inp;
output [10 : 0] shifted_num;

wire [10 : 0]layer1, layer2, layer3, layer4;

// assign diff = 5'b00011;
// assign inp = 11'b00010010011;


// always@(shifted_num)
// begin
//     $display("\ninp = %b, diff = %b, shiftednum = %b", inp, diff, shifted_num);
// end


// initial
// begin
//     assign inp = 11'b10010010011;
//     // assign inp = number;
//     assign diff = 5'b00111;
// end
// Layer 1

mux2x1 l1_2(inp[0], 1'b0, layer1[0], diff[0]);
mux2x1 l1_3(inp[1], inp[0], layer1[1], diff[0]);
mux2x1 l1_4(inp[2], inp[1], layer1[2], diff[0]);
mux2x1 l1_5(inp[3], inp[2], layer1[3], diff[0]);
mux2x1 l1_6(inp[4], inp[3], layer1[4], diff[0]);
mux2x1 l1_7(inp[5], inp[4], layer1[5], diff[0]);
mux2x1 l1_8(inp[6], inp[5], layer1[6], diff[0]);
mux2x1 l1_9(inp[7], inp[6], layer1[7], diff[0]);
mux2x1 l1_10(inp[8], inp[7], layer1[8], diff[0]);
mux2x1 l1_11(inp[9], inp[8], layer1[9], diff[0]);
mux2x1 l1_12(inp[10], inp[9], layer1[10], diff[0]);


// Layer 2

mux2x1 l2_3(layer1[0], 1'b0, layer2[0], diff[1]);
mux2x1 l2_4(layer1[1], 1'b0, layer2[1], diff[1]);
mux2x1 l2_5(layer1[2], layer1[0], layer2[2], diff[1]);
mux2x1 l2_6(layer1[3], layer1[1], layer2[3], diff[1]);
mux2x1 l2_7(layer1[4], layer1[2], layer2[4], diff[1]);
mux2x1 l2_8(layer1[5], layer1[3], layer2[5], diff[1]);
mux2x1 l2_9(layer1[6], layer1[4], layer2[6], diff[1]);
mux2x1 l2_10(layer1[7], layer1[5], layer2[7], diff[1]);
mux2x1 l2_11(layer1[8], layer1[6], layer2[8], diff[1]);
mux2x1 l2_12(layer1[9], layer1[7], layer2[9], diff[1]);
mux2x1 l2_13(layer1[10], layer1[8], layer2[10], diff[1]);


// Layer 3

mux2x1 l3_5(layer2[0], 1'b0, layer3[0], diff[2]);
mux2x1 l3_6(layer2[1], 1'b0, layer3[1], diff[2]);
mux2x1 l3_7(layer2[2], 1'b0, layer3[2], diff[2]);
mux2x1 l3_8(layer2[3], 1'b0, layer3[3], diff[2]);
mux2x1 l3_9(layer2[4], layer2[0], layer3[4], diff[2]);
mux2x1 l3_10(layer2[5], layer2[1], layer3[5], diff[2]);
mux2x1 l3_11(layer2[6], layer2[2], layer3[6], diff[2]);
mux2x1 l3_12(layer2[7], layer2[3], layer3[7], diff[2]);
mux2x1 l3_13(layer2[8], layer2[4], layer3[8], diff[2]);
mux2x1 l3_14(layer2[9], layer2[5], layer3[9], diff[2]);
mux2x1 l3_15(layer2[10], layer2[6], layer3[10], diff[2]);

// Layer 4

mux2x1 l4_1(layer3[0], 1'b0, layer4[0], diff[3]);
mux2x1 l4_2(layer3[1], 1'b0, layer4[1], diff[3]);
mux2x1 l4_3(layer3[2], 1'b0, layer4[2], diff[3]);
mux2x1 l4_4(layer3[3], 1'b0, layer4[3], diff[3]);
mux2x1 l4_5(layer3[4], 1'b0, layer4[4], diff[3]);
mux2x1 l4_6(layer3[5], 1'b0, layer4[5], diff[3]);
mux2x1 l4_7(layer3[6], 1'b0, layer4[6], diff[3]);
mux2x1 l4_8(layer3[7], 1'b0, layer4[7], diff[3]);
mux2x1 l4_9(layer3[8], 1'b0, layer4[8], diff[3]);
mux2x1 l4_10(layer3[9], layer3[0], layer4[9], diff[3]);
mux2x1 l4_11(layer3[10], layer3[1], layer4[10], diff[3]);



// Layer 5

mux2x1 l5_1(layer4[0], 1'b0, shifted_num[0], diff[4]);
mux2x1 l5_2(layer4[1], 1'b0, shifted_num[1], diff[4]);
mux2x1 l5_3(layer4[2], 1'b0, shifted_num[2], diff[4]);
mux2x1 l5_4(layer4[3], 1'b0, shifted_num[3], diff[4]);
mux2x1 l5_5(layer4[4], 1'b0, shifted_num[4], diff[4]);
mux2x1 l5_6(layer4[5], 1'b0, shifted_num[5], diff[4]);
mux2x1 l5_7(layer4[6], 1'b0, shifted_num[6], diff[4]);
mux2x1 l5_8(layer4[7], 1'b0, shifted_num[7], diff[4]);
mux2x1 l5_9(layer4[8], 1'b0, shifted_num[8], diff[4]);
mux2x1 l5_10(layer4[9], 1'b0, shifted_num[9], diff[4]);
mux2x1 l5_11(layer4[10], 1'b0, shifted_num[10], diff[4]);


endmodule