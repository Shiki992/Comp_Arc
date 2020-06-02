`include "regfile.v"
`include "Prgctr.v"
module instructreg(clk,Outins,reset,PC);
input clk,reset;
output [15:0] Outins,PC;
wire [15:0] OPC;
reg [15:0] regmem[0:1023];

prgctr p1( PC,clk,reset);
initial
begin
  regmem[0]<=16'd9;
  regmem[1]<=16'd1;
  regmem[2]<=16'd2;
  regmem[3]<=16'd3;
  regmem[4]<=16'd4;
  regmem[5]<=16'd5;
  regmem[6]<=16'd6;
  regmem[7]<=16'd7;
  regmem[8]<=16'd8;
end
assign Outins = regmem[PC[9:0]];

    
endmodule
/*regfile1,regfile2,regfile3,regfile4,regfile5,regfile5,regfile6,regfile7,regfile8,
regfile9,regfile10,regfile11,regfile12,regfile13,regfile14,regfile15,regfile16,
regfile17,regfile18,regfile19,regfile20,regfile21,regfile22,regfile23,regfile24,
regfile25,regfile26,regfile27,regfile28,regfile29,regfile30,regfile31,regfile32*/