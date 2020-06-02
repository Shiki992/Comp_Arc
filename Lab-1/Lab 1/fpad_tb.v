`include "fpad.v"
module top();
reg add,Asign,Bsign;
reg [4:0] Aexp,Bexp;
reg [9:0] Amant,Bmant; 
wire FinalSign,overflow;
wire [9:0] FinalMant;
wire [4:0] FinalExp;

Floating_Point fp1(Asign,Bsign,Amant,Bmant,Aexp,Bexp,add,FinalSign,overflow,FinalExp,FinalMant);

initial
begin
  
assign add = 1'b1;		// if 1 do addition
assign Aexp = 5'b11111;
assign Bexp = 5'b11111;
assign Asign = 1'b1;     // if 1 positive number else negative number
assign Bsign = 1'b1;	// if 1 positive number else negative number
assign Amant = 10'b1111111111; 
assign Bmant = 10'b1010101010;    

end



always @(*) begin
$display("%b %b %b overflow = %b",FinalSign,FinalMant[9:0],FinalExp[4:0],overflow);
//$display("%b %b %b %b",Aopnd,Bopnd,diffValAfterRD,diffValAfterRD);
end


endmodule 
