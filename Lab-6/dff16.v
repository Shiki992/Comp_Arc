module df (input wire clk, input [15:0] in, output reg [15:0] out,input reset);
  reg [15:0] df_out;
  always@(posedge clk or posedge reset) begin 
  if(reset) 
    begin 
      out<=16'd0; 
    end
  else 
    begin
      out<=df_out;
    end
  end 
endmodule