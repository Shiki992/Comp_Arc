`include "UBShifter.v"

module test();

reg sc;
reg [4:1] sh;
reg [16:1] A;

wire [16:1] out;

UBShifter ubs (A, sh, sc, out);

initial begin
    $monitor($time, ": Shift Choice: %b, A: %b (%d), Shift: %b (%d), out: %b (%d)", 
    sc, 
    A, A, sh, sh, out, out
    );
end

initial begin
    sc = 1'b0;
    sh = 4'b0011;
    A = 16'b1011001001010010; 
end

endmodule