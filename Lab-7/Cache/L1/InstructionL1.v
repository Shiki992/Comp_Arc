//`include "TagCompare.v"

module Instruction_L1 (
    wafull, writeval, 
    rafull, readval, 
    WriteHit, ReadHit, 
    clk, mode
);

input clk, mode; // If mode == 1 - write, else read

reg [15:0] mmem [65535:0];

reg [127:0] icache [511:0];
reg [2:1] bt [511:0];

input [16:1] wafull;
input [16:1] writeval;

input [16:1] rafull;
output reg [16:1] readval;

wire [14:1] wa;
wire [14:1] ra;

wire [11:1] wbi;
wire [11:1] rbi;

wire [3:1] wwi;
wire [3:1] rwi;

wire [2:1] WriteTag;
wire [2:1] ReadTag;

reg [511:0] ValidityBit;
reg [511:0] DirtyBit;

output reg ReadHit;
output reg WriteHit;

// Assign Tag and Indices
assign WriteTag = wafull[16:15];
assign ReadTag = rafull[16:15];

assign wbi = wafull[14:4];
assign rbi = rafull[14:4];

assign wwi = wafull[3:1];
assign rwi = rafull[3:1];

assign wa = wafull[14:1];
assign ra = rafull[14:1];

// Initially Validity and Dirty is 0 for all
integer i;
initial begin
    i = 0;
    while (i < 2048) begin
        ValidityBit[i] = 1'b0;
        DirtyBit[i] = 1'b0;
        bt[i] = 2'b01;
        i = i + 1;
    end
end

reg [16:1] Tempwa;
integer Tempra;

// Write
// Compare Tag
reg WriteTagCheck;


// Read
// Compare Tag
reg ReadTagCheck;

// Write Hit or Miss
always @(clk) begin
    WriteTagCheck = !(WriteTag[1] ^ bt[wbi][1]) & !(WriteTag[2] ^ bt[wbi][2]);
    ReadTagCheck = !(ReadTag[1] ^ bt[rbi][1]) & !(ReadTag[2] ^ bt[rbi][2]);
    WriteHit = (WriteTagCheck & ValidityBit[wbi]);
    ReadHit = (ReadTagCheck & ValidityBit[rbi]);


    if (WriteHit == 1'b1 && mode == 1'b1) begin // Hit
        $display("Write Hit");
        
        if (wwi == 3'b000)
            icache[wbi][0*16 + 15: 0*16] = writeval;
        else if (wwi == 3'b001)
            icache[wbi][1*16 + 15: 1*16] = writeval;
        else if (wwi == 3'b010)
            icache[wbi][2*16 + 15: 2*16] = writeval;
        else if (wwi == 3'b011)
            icache[wbi][3*16 + 15: 3*16] = writeval;
        else if (wwi == 3'b100)
            icache[wbi][4*16 + 15: 4*16] = writeval;
        else if (wwi == 3'b101)
            icache[wbi][5*16 + 15: 5*16] = writeval;
        else if (wwi == 3'b110)
            icache[wbi][6*16 + 15: 6*16] = writeval;
        else if (wwi == 3'b111)
            icache[wbi][7*16 + 15: 7*16] = writeval;
        // Set Dirty Bit and Validity Bit
        DirtyBit[wbi] = 1'b1;
        ValidityBit[wbi] = 1'b1;
    end
    else if (WriteHit == 1'b0 && mode == 1'b1) begin // Miss
        $display("Write Miss");

        Tempwa[14:4] = wbi;
        Tempwa[3:1] = 3'b000;

        // Write Back
        if (DirtyBit[wbi] == 1'b1) begin
            $display("Write Miss Write Back");
            Tempwa[16:15] = bt[wbi];


            mmem[Tempwa + 0][15:0] = icache[wbi][16*0 + 15 : 16*0];
            mmem[Tempwa + 1][15:0] = icache[wbi][16*1 + 15 : 16*1];
            mmem[Tempwa + 2][15:0] = icache[wbi][16*2 + 15 : 16*2];
            mmem[Tempwa + 3][15:0] = icache[wbi][16*3 + 15 : 16*3];
            mmem[Tempwa + 4][15:0] = icache[wbi][16*4 + 15 : 16*4];
            mmem[Tempwa + 5][15:0] = icache[wbi][16*5 + 15 : 16*5];
            mmem[Tempwa + 6][15:0] = icache[wbi][16*6 + 15 : 16*6];
            mmem[Tempwa + 7][15:0] = icache[wbi][16*7 + 15 : 16*7];

            // Clear Dirty Bit
            DirtyBit[wbi] = 1'b0;
        end
        
        Tempwa[16:15] = WriteTag;


        icache[wbi][16*0 + 15 : 16*0] = mmem[Tempwa + 0][15:0];
        icache[wbi][16*1 + 15 : 16*1] = mmem[Tempwa + 1][15:0];
        icache[wbi][16*2 + 15 : 16*2] = mmem[Tempwa + 2][15:0];
        icache[wbi][16*3 + 15 : 16*3] = mmem[Tempwa + 3][15:0];
        icache[wbi][16*4 + 15 : 16*4] = mmem[Tempwa + 4][15:0];
        icache[wbi][16*5 + 15 : 16*5] = mmem[Tempwa + 5][15:0];
        icache[wbi][16*6 + 15 : 16*6] = mmem[Tempwa + 6][15:0];
        icache[wbi][16*7 + 15 : 16*7] = mmem[Tempwa + 7][15:0];

        if (wwi == 3'b000)
            icache[wbi][0*16 + 15: 0*16] = writeval;
        else if (wwi == 3'b001)
            icache[wbi][1*16 + 15: 1*16] = writeval;
        else if (wwi == 3'b010)
            icache[wbi][2*16 + 15: 2*16] = writeval;
        else if (wwi == 3'b011)
            icache[wbi][3*16 + 15: 3*16] = writeval;
        else if (wwi == 3'b10)
            icache[wbi][4*16 + 15: 4*16] = writeval;
        else if (wwi == 3'b101)
            icache[wbi][5*16 + 15: 5*16] = writeval;
        else if (wwi == 3'b110)
            icache[wbi][6*16 + 15: 6*16] = writeval;
        else if (wwi == 3'b111)
            icache[wbi][7*16 + 15: 7*16] = writeval;


        // Set Dirty Bit and Validity Bit
        DirtyBit[wbi] = 1'b1;
        ValidityBit[wbi] = 1'b1;
        bt[wbi] = WriteTag;
    end

    ReadTagCheck = !(ReadTag[1] ^ bt[rbi][1]) & !(ReadTag[2] ^ bt[rbi][2]);
    ReadHit = (ReadTagCheck & ValidityBit[rbi]);

    // Read
    if (ReadHit == 1'b1 && mode == 1'b0) begin // Hit
        $display("Read Hit");
        // Read
        if (rwi == 3'b000)
            readval = icache[rbi][0*16 + 15: 0*16];
        else if (rwi == 3'b001)
            readval = icache[rbi][1*16 + 15: 1*16];
        else if (rwi == 3'b010)
            readval = icache[rbi][2*16 + 15: 2*16];
        else if (rwi == 3'b011)
            readval = icache[rbi][3*16 + 15: 3*16];
        else if (rwi == 3'b100)
            readval = icache[rbi][4*16 + 15: 4*16];
        else if (rwi == 3'b101)
            readval = icache[rbi][5*16 + 15: 5*16];
        else if (rwi == 3'b110)
            readval = icache[rbi][6*16 + 15: 6*16];
        else if (rwi == 3'b111)
            readval = icache[rbi][7*16 + 15: 7*16];
    end
    else if (ReadHit == 1'b0 && mode == 1'b0) begin // Miss
        $display("Read Miss");
        Tempra = 0;
        Tempra[13:3] = rbi;
        Tempra[2:0] = 3'b000;

        //$display("ReadMissDisp: DC block %d: %b", rbi, icache[rbi]);

        // Write Back
        if (DirtyBit[rbi] == 1'b1) begin
            $display("Read Miss Write Back");
            Tempra[15:14] = bt[rbi];

            mmem[Tempra + 0][15:0] = icache[rbi][16*0 + 15 : 16*0];
            mmem[Tempra + 1][15:0] = icache[rbi][16*1 + 15 : 16*1];
            mmem[Tempra + 2][15:0] = icache[rbi][16*2 + 15 : 16*2];
            mmem[Tempra + 3][15:0] = icache[rbi][16*3 + 15 : 16*3];
            mmem[Tempra + 4][15:0] = icache[rbi][16*4 + 15 : 16*4];
            mmem[Tempra + 5][15:0] = icache[rbi][16*5 + 15 : 16*5];
            mmem[Tempra + 6][15:0] = icache[rbi][16*6 + 15 : 16*6];
            mmem[Tempra + 7][15:0] = icache[rbi][16*7 + 15 : 16*7];
        end
        //$display("ReadMissFinal1: DC block Temp: %b: %b", Tempra, mmem[Tempra]);
        // Replace Block 
        Tempra[15:14] = ReadTag;
        icache[rbi][16*0 + 15 : 16*0] = mmem[Tempra + 0][15:0];
        icache[rbi][16*1 + 15 : 16*1] = mmem[Tempra + 1][15:0];
        icache[rbi][16*2 + 15 : 16*2] = mmem[Tempra + 2][15:0];
        icache[rbi][16*3 + 15 : 16*3] = mmem[Tempra + 3][15:0];
        icache[rbi][16*4 + 15 : 16*4] = mmem[Tempra + 4][15:0];
        icache[rbi][16*5 + 15 : 16*5] = mmem[Tempra + 5][15:0];
        icache[rbi][16*6 + 15 : 16*6] = mmem[Tempra + 6][15:0];
        icache[rbi][16*7 + 15 : 16*7] = mmem[Tempra + 7][15:0];

        bt[rbi] = ReadTag;
        ValidityBit[rbi] = 1'b1;
        DirtyBit[rbi] = 1'b0;

        //$display("ReadMissFinal2: DC block %d + %b: %b", rbi, rwi, icache[rbi]);

        // Then Read
        if (rwi == 3'b000)
            readval = icache[rbi][0*16 + 15: 0*16];
        else if (rwi == 3'b001)
            readval = icache[rbi][1*16 + 15: 1*16];
        else if (rwi == 3'b010)
            readval = icache[rbi][2*16 + 15: 2*16];
        else if (rwi == 3'b011)
            readval = icache[rbi][3*16 + 15: 3*16];
        else if (rwi == 3'b100)
            readval = icache[rbi][4*16 + 15: 4*16];
        else if (rwi == 3'b101)
            readval = icache[rbi][5*16 + 15: 5*16];
        else if (rwi == 3'b110)
            readval = icache[rbi][6*16 + 15: 6*16];
        else if (rwi == 3'b111)
            readval = icache[rbi][7*16 + 15: 7*16];
    end
end
endmodule