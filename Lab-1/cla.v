module cla4(output [3:0] s, //Output declaration 
output co, input [3:0] a, //Input declaration 
input [3:0] b, input cin); 
wire [3:0] g,p,c; //Declaring intermediate data lines 

assign p[0]=a[0] ^ b[0]; //First adder parameters 
assign g[0]=a[0] & b[0]; 
assign c[0]=cin; 
assign s[0]=p[0] ^ c[0]; 
assign p[1]=a[1] ^ b[1]; //Second adder parameters 
assign g[1]=a[1] & b[1]; 
assign c[1]=g[0] | (p[0]&c[0]); 
assign s[1]=p[1] ^ c[1]; 
assign p[2]=a[2] ^ b[2]; //Third adder parameters 
assign g[2]=a[2] & b[2]; 
assign c[2]=g[1] | (p[1]&g[0]) | (p[1]&p[0]&c[0]); 
assign s[2]=p[2] ^ c[2]; 
assign p[3]=a[3] ^ b[3]; //Fourth adder parameters 
assign g[3]=a[3] & b[3]; 
assign c[3]=g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&c[0]); 
assign s[3]=p[3] ^ c[3]; 
assign co=g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&c[0]); 
endmodule 

module cla8(output [7:0] sum, //Output declaration 
output cout, input [7:0] a, //Input declaration 
input [7:0] b, input cin); 
wire c4; //Declaring intermediate data line 
cla4 i1(sum[3:0], c4, a[3:0], b[3:0], cin); //instantiating cla4 first time
cla4 i2(sum[7:4], cout, a[7:4], b[7:4], c4); //instantiating cla4 second time endmodule 
endmodule