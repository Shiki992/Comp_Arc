module mux11x1(Bshifted, Bshiftedcomp, checker, bout);

input  [10 : 0] Bshifted, Bshiftedcomp;
input checker;
output [10 : 0] bout;

// assign Bshifted = 11'b1100110011;
// assign Bshiftedcomp = 11'b0011001100;
// assign checker = 1'b1;

// always@(*)
// begin
//     $display("bshifted = %d, bshiftedcomp = %d, checker = %d, bout = %d", Bshifted, Bshiftedcomp, checker, bout);
// end

mux2x1 b0 (Bshifted[0], Bshiftedcomp[0], bout[0], checker);
mux2x1 b1 (Bshifted[1], Bshiftedcomp[1], bout[1], checker);
mux2x1 b2 (Bshifted[2], Bshiftedcomp[2], bout[2], checker);
mux2x1 b3 (Bshifted[3], Bshiftedcomp[3], bout[3], checker);
mux2x1 b4 (Bshifted[4], Bshiftedcomp[4], bout[4], checker);
mux2x1 b5 (Bshifted[5], Bshiftedcomp[5], bout[5], checker);
mux2x1 b6 (Bshifted[6], Bshiftedcomp[6], bout[6], checker);
mux2x1 b7 (Bshifted[7], Bshiftedcomp[7], bout[7], checker);
mux2x1 b8 (Bshifted[8], Bshiftedcomp[8], bout[8], checker);
mux2x1 b9 (Bshifted[9], Bshiftedcomp[9], bout[9], checker);
mux2x1 b10 (Bshifted[10], Bshiftedcomp[10], bout[10], checker);

endmodule