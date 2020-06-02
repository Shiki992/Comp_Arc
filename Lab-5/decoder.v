module decoder5232( in,out, en);
input [4:0]  in;
input en;
output [31:0] out;
  reg [31:0] out;
 
 always @( in or en)
	begin
 
      if (en) 
        begin
          out=32'd0;
          case (in)
              5'd00000: out[0]=1'b1;
              5'd00001: out[1]=1'b1;
              5'd00010: out[2]=1'b1;
              5'd00011: out[3]=1'b1;
              5'd00100: out[4]=1'b1;
              5'd00101: out[5]=1'b1;
              5'd00110: out[6]=1'b1;
              5'd00111: out[7]=1'b1;
              5'd01000: out[8]=1'b1;
              5'd01001: out[9]=1'b1;
              5'd01010: out[10]=1'b1;
              5'd01011: out[11]=1'b1;
              5'd01100: out[12]=1'b1;
              5'd01101: out[13]=1'b1;
              5'd01110: out[14]=1'b1;
              5'd01111: out[15]=1'b1;
              5'd10000: out[16]=1'b1;
              5'd10001: out[17]=1'b1;
              5'd10010: out[18]=1'b1;
              5'd10011: out[19]=1'b1;
              5'd10100: out[20]=1'b1;
              5'd10101: out[21]=1'b1;
              5'd10110: out[22]=1'b1;
              5'd10111: out[23]=1'b1;
              5'd11000: out[24]=1'b1;
              5'd11001: out[25]=1'b1;
              5'd11010: out[26]=1'b1;
              5'd11011: out[27]=1'b1;
              5'd11100: out[28]=1'b1;
              5'd11101: out[29]=1'b1;
              5'd11110: out[30]=1'b1;
              5'd11111: out[31]=1'b1;
              default: out=32'd0;
          endcase
      end
else 
out=32'd0;
end
endmodule