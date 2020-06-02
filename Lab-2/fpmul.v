`include "multi16.v"
`include "barrel_shifter_right_5.v"
`include "RCA5bit.v"
module fpmul(Asign,Bsign,Amant,Bmant,Aexp,Bexp,out);
	input Asign,Bsign;
	input [9:0] Amant,Bmant;
	input [4:0] Aexp,Bexp;
	output [15:0] out;
    wire os;
    wire [15:0] Apmant,Bpmant;
    wire [31:0]outpmant;
    wire [10:0] outp,outps; 
    reg [10:0] outmant;
    wire [5:0] outexp1,outexp2;
    reg [5:0] outexp;
    assign Apmant = {{6'b000000},Amant};
    assign Bpmant = {{6'b000000},Bmant};
    multi16 m1(Apmant,Bpmant,outpmant);
    RCA5bit r1(Aexp,Bexp,outexp1);
    RCA5bit r2(outexp1[4:0],5'b00001,outexp2);


    always @(*) begin
      if (outpmant[19]==1'b1) begin
          outmant<=outpmant[18:9];
          outexp <= outexp2;
          // outmantissa = multout[18:9]
          // exp++
      end
      else begin
          outmant<=outpmant[17:8];
          outexp <= outexp1;
          // outmantissa = multout[17:8]
      end
    end

    assign os = Asign^Bsign;
    // always @(*) begin
    //   if ((Asign==1'b1 && Bsign==1'b1)|| (Asign==1'b0 && Bsign==1'b0)) begin
    //       os<=1'b0;
    //   end
    //   else if ((Asign==1'b0 && Bsign==1'b1)|| (Asign==1'b1 && Bsign==1'b0)) begin
    //       os<=1'b1;
    //   end
    // end

    
    assign out = {{os},{outexp[4:0]},outmant};


endmodule // Asign,Bsign,Amant,Bmant,Aexp,Bexp,add,out