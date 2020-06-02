`include "Adders/RecursiveDoubling.v"
`include "barrel_shifter_right_5.v"
`include "barrel_shifter_left_5.v"
`include "Adders/FullAdder.v"
`include "Adders/5ba.v"
//`include "lib.v"

module fpad( s1,s2,op,e1,e2,m1,m2,mop,sop,eop,clk);
input s1,s2,op,clk;
input [4:0] e1,e2;
input [10:0] m1, m2;
output sop;
output [4:0] eop;
output [10:0] mop;
wire opn,carry;
wire [4:0] oce2,tce2,sum;
reg [4:0] oce,tce,de;
wire [10:0] msft1,msft2;
reg [9:0]msftocp;
reg [9:0] msft,msftcpl;



//xor3 x1(s1, s2, op, opn);
assign opn =!(s1^s2^op);
assign oce2 =~e2;
assign tce2=oce2+5'b00001;
assign carry = 1'b0;



FiveBitAdder fba_1(e1,tce2,1'b0,sum,carry);




 always@(posedge clk) begin
     if (e1<e2) 
     
    begin
    oce <=!e1 ;
    tce<=oce+5'b00001;
    de<=tce+e2;
 end 
 else if (e1>e2) begin
     de<=tce2+e1;
end else begin
     de<=5'b00000;
end


end

barrel_shifter_r r1(de, m1, msft1);
barrel_shifter_r r2(de, m2, msft2);

always@(posedge clk) begin
if (carry==1'b1) 
begin
   msft <= msft1[9:0];
   msftocp <= !msft;
   msftcpl<= msftocp+1'b1;
end 

else if (carry==1'b0) 
begin
    msft <= msft2[9:0];
    msftocp <= !msft;
    msftcpl<= msftocp+1'b1;
end

end

//RecursiveDoubling ad1( a, b, cin, sum, cout);

endmodule