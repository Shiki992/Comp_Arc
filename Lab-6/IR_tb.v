`include "IR.v"
module top;
reg clk,reset;
wire [15:0] Outins,PC;

instructreg I1(clk,Outins,reset,PC);

initial
begin
    clk=1'b0;
    reset=1'b1;
#5  reset=1'b0;
end


always
begin
  #10 clk = ~clk;
end    

always @(posedge clk)
begin
  $monitor("Instruction=%b  Program counter=%b",Outins,PC);
end

initial
  #100 $finish;


endmodule