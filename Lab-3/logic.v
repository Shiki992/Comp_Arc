`include "16BA.v"
module logicalunit(A,B,sel,fout);
    input [2:0] sel;
	input [15:0] A,B;
	output [15:0] fout;
    wire [15:0] out1,out2,out3,out4,out5,out6,out7;
    reg [15:0] out;
    wire [15:0] out8;
    reg i;
	wire carry;

             assign out1[0]= A[0] & B[0];
             assign out2[0]= A[0] | B[0];
             assign out3[0]= A[0] ^ B[0];
             assign out4[0]= ~(out1[0]);
             assign out5[0]= ~(out2[0]);
             assign out6[0]= ~(out3[0]);
             assign out7[0]= ~(A[0]);
             assign out1[1]= A[1] & B[1];
             assign out2[1]= A[1] | B[1];
             assign out3[1]= A[1] ^ B[1];
             assign out4[1]= ~(out1[1]);
             assign out5[1]= ~(out2[1]);
             assign out6[1]= ~(out3[1]);
             assign out7[1]= ~(A[1]);
             assign out1[2]= A[2] & B[2];
             assign out2[2]= A[2] | B[2];
             assign out3[2]= A[2] ^ B[2];
             assign out4[2]= ~(out1[2]);
             assign out5[2]= ~(out2[2]);
             assign out6[2]= ~(out3[2]);
             assign out7[2]= ~(A[2]);
             assign out1[3]= A[3] & B[3];
             assign out2[3]= A[3] | B[3];
             assign out3[3]= A[3] ^ B[3];
             assign out4[3]= ~(out1[3]);
             assign out5[3]= ~(out2[3]);
             assign out6[3]= ~(out3[3]);
             assign out7[3]= ~(A[3]);
             assign out1[4]= A[4] & B[4];
             assign out2[4]= A[4] | B[4];
             assign out3[4]= A[4] ^ B[4];
             assign out4[4]= ~(out1[4]);
             assign out5[4]= ~(out2[4]);
             assign out6[4]= ~(out3[4]);
             assign out7[4]= ~(A[4]);
             assign out1[5]= A[5] & B[5];
             assign out2[5]= A[5] | B[5];
             assign out3[5]= A[5] ^ B[5];
             assign out4[5]= ~(out1[5]);
             assign out5[5]= ~(out2[5]);
             assign out6[5]= ~(out3[5]);
             assign out7[5]= ~(A[5]);
             assign out1[6]= A[6] & B[6];
             assign out2[6]= A[6] | B[6];
             assign out3[6]= A[6] ^ B[6];
             assign out4[6]= ~(out1[6]);
             assign out5[6]= ~(out2[6]);
             assign out6[6]= ~(out3[6]);
             assign out7[6]= ~(A[6]);
             assign out1[7]= A[7] & B[7];
             assign out2[7]= A[7] | B[7];
             assign out3[7]= A[7] ^ B[7];
             assign out4[7]= ~(out1[7]);
             assign out5[7]= ~(out2[7]);
             assign out6[7]= ~(out3[7]);
             assign out7[7]= ~(A[7]);
             assign out1[8]= A[8] & B[8];
             assign out2[8]= A[8] | B[8];
             assign out3[8]= A[8] ^ B[8];
             assign out4[8]= ~(out1[8]);
             assign out5[8]= ~(out2[8]);
             assign out6[8]= ~(out3[8]);
             assign out7[8]= ~(A[8]);
             assign out1[9]= A[9] & B[9];
             assign out2[9]= A[9] | B[9];
             assign out3[9]= A[9] ^ B[9];
             assign out4[9]= ~(out1[9]);
             assign out5[9]= ~(out2[9]);
             assign out6[9]= ~(out3[9]);
             assign out7[9]= ~(A[9]);
             assign out1[10]= A[10] & B[10];
             assign out2[10]= A[10] | B[10];
             assign out3[10]= A[10] ^ B[10];
             assign out4[10]= ~(out1[10]);
             assign out5[10]= ~(out2[10]);
             assign out6[10]= ~(out3[10]);
             assign out7[10]= ~(A[10]);
             assign out1[11]= A[11] & B[11];
             assign out2[11]= A[11] | B[11];
             assign out3[11]= A[11] ^ B[11];
             assign out4[11]= ~(out1[11]);
             assign out5[11]= ~(out2[11]);
             assign out6[11]= ~(out3[11]);
             assign out7[11]= ~(A[11]);
             assign out1[12]= A[12] & B[12];
             assign out2[12]= A[12] | B[12];
             assign out3[12]= A[12] ^ B[12];
             assign out4[12]= ~(out1[12]);
             assign out5[12]= ~(out2[12]);
             assign out6[12]= ~(out3[12]);
             assign out7[12]= ~(A[12]);
             assign out1[13]= A[13] & B[13];
             assign out2[13]= A[13] | B[13];
             assign out3[13]= A[13] ^ B[13];
             assign out4[13]= ~(out1[13]);
             assign out5[13]= ~(out2[13]);
             assign out6[13]= ~(out3[13]);
             assign out7[13]= ~(A[13]);
             assign out1[14]= A[14] & B[14];
             assign out2[14]= A[14] | B[14];
             assign out3[14]= A[14] ^ B[14];
             assign out4[14]= ~(out1[14]);
             assign out5[14]= ~(out2[14]);
             assign out6[14]= ~(out3[14]);
             assign out7[14]= ~(A[14]);
             assign out1[15]= A[15] & B[15];
             assign out2[15]= A[15] | B[15];
             assign out3[15]= A[15] ^ B[15];
             assign out4[15]= ~(out1[15]);
             assign out5[15]= ~(out2[15]);
             assign out6[15]= ~(out3[15]);
             assign out7[15]= ~(A[15]);
    SixteenBitAdder a1( out7 , 16'b0000000000000001 , 1'b0 , out8 , carry ) ;
    always @(*) begin
      if (sel== 3'b000) begin
      out <= out1;
    end
        if (sel== 3'b001) begin
           out = out2;
        end
              if (sel== 3'b010) begin
                out <= out3;
        end 
              if (sel== 3'b011) begin
                 out <= out4;
        end
              if (sel== 3'b100) begin
                 out <= out5;
        end
              if (sel== 3'b101) begin
                 out <= out6;
        end
              if (sel== 3'b110) begin
                 out <= out7;
        end
              if (sel== 3'b111) begin
                     out <= out8;
        end
    end



endmodule // logicaAsign,Bsign,Amant,Bmant,Aexp,Bexp,add,outit