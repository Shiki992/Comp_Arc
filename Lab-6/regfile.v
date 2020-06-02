module regfile( I1,si1,O1,so1,RD,rst,EN,clk);
input  [31:0]  I1;
input  [3:0]  si1,so1; 
input  RD; 
input  EN,clk,rst; 
output [31:0]  O1; 
reg  [31:0]  O1; 
reg [31:0]  regfile [0:15]; 
integer i; 
wire  sen; 
assign sen = clk || rst;
always @ (posedge sen) 
begin 
if (EN == 1) 
begin 
      if (rst == 1) //If at reset 
       begin 
        regfile [0] = 32'h0;
        regfile [1] = 32'h1;
        regfile [2] = 32'h2;
        regfile [3] = 32'h3;
        regfile [4] = 32'h4;
        regfile [5] = 32'h5;
        regfile [6] = 32'h6;
        regfile [7] = 32'h7;
        regfile [8] = 32'h8;
        regfile [9] = 32'h9;
        regfile [10] = 32'h10;
        regfile [11] = 32'h11;
        regfile [12] = 32'h12;
        regfile [13] = 32'h13;
        regfile [14] = 32'h14;
        regfile [15] = 32'h15; 
       O1 = 32'hx; 
       end 
      else if (rst == 0) //If not at reset
       begin 
         O1 = regfile [so1];  
         end 
      else; 
     end 
     else;
    end 
    endmodule



