`include "dff16.v"
`include "16BA.v"
module prgctr( 
    output [15:0] PC, input clk,input reset
);
wire a;
reg [15:0] OPC;
SixteenBitAdder s1( OPC , 16'd1 , 1'b0 , PC , a );
df d1(clk,OPC,PC,reset);
    
endmodule