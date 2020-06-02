`include "LBShifter.v"
`include "RBShifter.v"

module UBShifter (A, Shift, ShiftChoice, out);

input [16:1] A;
input [4:1] Shift;
input ShiftChoice;  // Left Shift if 1, else if 0 Right Shift

output [16:1] out;

wire [16:1] ls, rs;

LBShifter ls1 (A, Shift, ls);
RBShifter rs1 (A, Shift, rs);

assign out = (ShiftChoice) ? ls : rs;

endmodule