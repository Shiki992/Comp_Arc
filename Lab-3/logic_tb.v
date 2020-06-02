`include "logic.v"
    
    module top();

    reg [15:0] A,B;
    reg [2:0] sel;
    wire [15:0] out;
    
    logicalunit l1(A,B,sel,out);
    initial
    begin
          assign sel = 3'b001;		// if 1 do and
    assign A = 16'b1111111111; 
    assign B = 16'b1010101010; 
    
    end


    always @(*) begin
        $display("%b ",out[15:0]);
        //$display("%b %b %b %b",Aopnd,Bopnd,diffValAfterRD,diffValAfterRD);
    end 
    
    endmodule // top
    