`include "ExponentSub.v"
`include "Mux10x1.v"
`include "barrel_shifter_right_5.v"
`include "barrel_shifter_left_5.v"
`include "priority_encoder_10.v"
`include "11Bit2Comp.v"
`include "mux11x1.v"
`include "RecursiveDoubling.v"
`include "MantissaSub.v"

module Floating_Point(Asign,Bsign,Amant,Bmant,Aexp,Bexp,add,out);
	input Asign,Bsign,add;
	input [9:0] Amant,Bmant;
	input [4:0] Aexp,Bexp;
	output out;
	wire infchk;

assign add = 1'b1;		// if 1 do addition
assign Aexp = 5'b11111;
assign Bexp = 5'b11111;
assign Asign = 1'b1;     // if 1 positive number else negative number
assign Bsign = 1'b1;	// if 1 positive number else negative number
assign Amant = 10'b1111111111; 
assign Bmant = 10'b1010101010;    
assign infchk = (&Aexp & &Amant) | (&Bexp & &Bmant);

always @(*) begin
$display("%b %b %b overflow = %b",FinalSign,FinalMant[9:0],FinalExp[4:0],overflow);
//$display("%b %b %b %b",Aopnd,Bopnd,diffValAfterRD,diffValAfterRD);
end



wire MantSign;
MantissaSub ms1 (Amant,Bmant,MantSign);


wire AgrtrB; 	//AgrtrB is 1 if Aexp>Bexp else 0
wire [4:0] ExpDiffVal;
ExponentSub exs1 (Aexp,Bexp,AgrtrB,ExpDiffVal);

wire AequalsB,AgrtrB1;

assign AequalsB = ~(| ExpDiffVal);

assign AgrtrB1 = (AequalsB & MantSign) | (~AequalsB & AgrtrB);

wire [9:0] LargeMant,SmallMant;
wire [4:0] LargeExp,SmallExp;
wire [10:0] temp;

wire [9:0] PaddAgrtrB;

wire [15:0] Aopnd,Bopnd;

Mux10x1 ma1 (AgrtrB1,PaddAgrtrB);

assign LargeMant = (PaddAgrtrB&Amant) | ((~PaddAgrtrB)&Bmant);		
assign SmallMant = ((~PaddAgrtrB)&Amant) | (PaddAgrtrB&Bmant);
assign LargeExp = (PaddAgrtrB&Aexp) | ((~PaddAgrtrB)&Bexp);
assign SmallExp = ((~PaddAgrtrB)&Aexp) | (PaddAgrtrB&Bexp);

wire zero_or_not_Large,zero_or_not_Small,infinite_or_not_Large,infinite_or_not_Small;

assign zero_or_not_Large = (| LargeMant) | (| LargeExp); // 0 if both mant and exp are zero.
assign zero_or_not_Small = (| SmallMant) | (| SmallExp);
assign infinite_or_not_Large = (~(| LargeMant)) & (&LargeExp);
assign infinite_or_not_Small = (~(| SmallMant)) & (&SmallExp);

assign temp = {zero_or_not_Small , SmallMant};
assign Aopnd = {{{5'b00000},zero_or_not_Large} ,LargeMant};

wire [10:0] Bshifted,Bshiftedcomplement;
wire checker;
wire [10:0] BshiftChkr;

assign checker = ~(Asign^add^Bsign);

barrel_shifter_r bs1 (ExpDiffVal,temp,Bshifted);

bit2comp11 b2 (Bshifted,Bshiftedcomplement);

mux11x1 mx1(Bshifted,Bshiftedcomplement,checker,BshiftChkr);
assign Bopnd = {{5'b00000} ,BshiftChkr};

wire [16:0] RdOut1;
wire cout;
RecursiveDoubling rd1 (Aopnd,Bopnd,1'b0,RdOut1[15:0],RdOut1[16]);

wire [4:0] diffValAfterRD;
wire [10:0] FinalMant1,FinalMant;

wire FinalSign;
assign FinalSign = ((AgrtrB1&Asign) | ((~AgrtrB1)&(~(Bsign^add)))&(Val));

wire tempo,tempo1;
assign tempo = (~checker)&RdOut1[11];
assign tempo1 = (checker&(~RdOut1[10]));	// Check This

wire [4:0] leftShiftedVal,left2complement;
wire Val;
wire [5:0] diffValAfterPE;

priority_encoder pe1(RdOut1[9:0], leftShiftedVal[3:0], Val);	// Some checking Required Here

assign leftShiftedVal[4] = 1'b0;

bit2comp b2c (leftShiftedVal,left2complement);
RCA5bit rca1 (5'b01010,left2complement,diffValAfterPE);	// Some checking Required Here

wire [10:0] leftShiftMantissa;

barrel_shifter_l bsl1 (diffValAfterPE[4:0], RdOut1[10:0], leftShiftMantissa);

assign diffValAfterRD = {{4'b0000} ,tempo};

barrel_shifter_r bs2 (diffValAfterRD,RdOut1[10:0],FinalMant1);

wire [5:0] FinalExp0,FinalExp1,FinalExp;
wire [4:0] expOffset2complement;

RCA5bit raa2 (LargeExp,diffValAfterRD,FinalExp0);

bit2comp b2c1 (diffValAfterPE[4:0],expOffset2complement);
RCA5bit raa3 (FinalExp0[4:0],expOffset2complement,FinalExp1);

assign FinalExp[0] = ((FinalExp1[0]&tempo1)&(Val) | (FinalExp0[0]&(~tempo1))) | (infinite_or_not_Large|infinite_or_not_Small)  | (infchk);
assign FinalExp[1] = ((FinalExp1[1]&tempo1)&(Val) | (FinalExp0[1]&(~tempo1))) | (infinite_or_not_Large|infinite_or_not_Small)  | (infchk);
assign FinalExp[2] = ((FinalExp1[2]&tempo1)&(Val) | (FinalExp0[2]&(~tempo1))) | (infinite_or_not_Large|infinite_or_not_Small)  | (infchk);
assign FinalExp[3] = ((FinalExp1[3]&tempo1)&(Val) | (FinalExp0[3]&(~tempo1))) | (infinite_or_not_Large|infinite_or_not_Small)  | (infchk);
assign FinalExp[4] = ((FinalExp1[4]&tempo1)&(Val) | (FinalExp0[4]&(~tempo1))) | (infinite_or_not_Large|infinite_or_not_Small)  | (infchk);

wire [10:0] FinalMant2;
mux11x1 mx2(FinalMant1,leftShiftMantissa,tempo1,FinalMant2);
assign FinalMant[0] = FinalMant2[0]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[1] = FinalMant2[1]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[2] = FinalMant2[2]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[3] = FinalMant2[3]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[4] = FinalMant2[4]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[5] = FinalMant2[5]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[6] = FinalMant2[6]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[7] = FinalMant2[7]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[8] = FinalMant2[8]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);
assign FinalMant[9] = FinalMant2[9]&(~(infinite_or_not_Large|infinite_or_not_Small))  | (infchk);

wire overflow;
assign overflow = (& FinalExp[4:0]);
endmodule