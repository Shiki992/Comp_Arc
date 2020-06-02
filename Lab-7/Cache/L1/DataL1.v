module DataL1 (
    wafull, writeval, 
    rafull, readval, 
    WriteHit, ReadHit, 
    clk, write, read
);

input clk, write, read;

reg [15:0] MMem [65535:0];

reg [127:0] DCa [2047:0];
reg [2:1] bt [2047:0];

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

reg [2047:0] ValidityBit;
reg [2047:0] DirtyBit;

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

integer Tempwa;
integer Tempra;

// Write
// Compare Tag
reg WriteTagCheck;



// Read
// Compare Tag
reg ReadTagCheck;

always @(clk) begin
    WriteTagCheck = !(WriteTag[1] ^ bt[wbi][1]) & !(WriteTag[2] ^ bt[wbi][2]);
    ReadTagCheck = !(ReadTag[1] ^ bt[rbi][1]) & !(ReadTag[2] ^ bt[rbi][2]);
    WriteHit = (WriteTagCheck & ValidityBit[wbi]);
    ReadHit = (ReadTagCheck & ValidityBit[rbi]);


    if (WriteHit == 1'b1 && write == 1'b1) begin // Hit
        
        if (wwi == 3'b000)
            DCa[wbi][0*16 + 15: 0*16] = writeval;
        else if (wwi == 3'b001)
            DCa[wbi][1*16 + 15: 1*16] = writeval;
        else if (wwi == 3'b010)
            DCa[wbi][2*16 + 15: 2*16] = writeval;
        else if (wwi == 3'b011)
            DCa[wbi][3*16 + 15: 3*16] = writeval;
        else if (wwi == 3'b10)
            DCa[wbi][4*16 + 15: 4*16] = writeval;
        else if (wwi == 3'b101)
            DCa[wbi][5*16 + 15: 5*16] = writeval;
        else if (wwi == 3'b110)
            DCa[wbi][6*16 + 15: 6*16] = writeval;
        else if (wwi == 3'b111)
            DCa[wbi][7*16 + 15: 7*16] = writeval;
        // Set Dirty Bit and Validity Bit
        DirtyBit[wbi] = 1'b1;
        ValidityBit[wbi] = 1'b1;
    end
    else if (WriteHit == 1'b0 && write == 1'b1) begin // Miss

        Tempwa[14:4] = wbi;
        Tempwa[3:1] = 3'b000;

        // Write Back
        if (DirtyBit[wbi] == 1'b1) begin
            $display("Write Miss Write Back");
            Tempwa[16:15] = bt[wbi];

            MMem[Tempwa + 0][15:0] = DCa[wbi][16*0 + 15 : 16*0];
            MMem[Tempwa + 1][15:0] = DCa[wbi][16*1 + 15 : 16*1];
            MMem[Tempwa + 2][15:0] = DCa[wbi][16*2 + 15 : 16*2];
            MMem[Tempwa + 3][15:0] = DCa[wbi][16*3 + 15 : 16*3];
            MMem[Tempwa + 4][15:0] = DCa[wbi][16*4 + 15 : 16*4];
            MMem[Tempwa + 5][15:0] = DCa[wbi][16*5 + 15 : 16*5];
            MMem[Tempwa + 6][15:0] = DCa[wbi][16*6 + 15 : 16*6];
            MMem[Tempwa + 7][15:0] = DCa[wbi][16*7 + 15 : 16*7];

            // Clear Dirty Bit
            DirtyBit[wbi] = 1'b0;
        end
        
        Tempwa[16:15] = WriteTag;

        DCa[wbi][16*0 + 15 : 16*0] = MMem[Tempwa + 0][15:0];
        DCa[wbi][16*1 + 15 : 16*1] = MMem[Tempwa + 1][15:0];
        DCa[wbi][16*2 + 15 : 16*2] = MMem[Tempwa + 2][15:0];
        DCa[wbi][16*3 + 15 : 16*3] = MMem[Tempwa + 3][15:0];
        DCa[wbi][16*4 + 15 : 16*4] = MMem[Tempwa + 4][15:0];
        DCa[wbi][16*5 + 15 : 16*5] = MMem[Tempwa + 5][15:0];
        DCa[wbi][16*6 + 15 : 16*6] = MMem[Tempwa + 6][15:0];
        DCa[wbi][16*7 + 15 : 16*7] = MMem[Tempwa + 7][15:0];

        if (wwi == 3'b000)
            DCa[wbi][0*16 + 15: 0*16] = writeval;
        else if (wwi == 3'b001)
            DCa[wbi][1*16 + 15: 1*16] = writeval;
        else if (wwi == 3'b010)
            DCa[wbi][2*16 + 15: 2*16] = writeval;
        else if (wwi == 3'b011)
            DCa[wbi][3*16 + 15: 3*16] = writeval;
        else if (wwi == 3'b10)
            DCa[wbi][4*16 + 15: 4*16] = writeval;
        else if (wwi == 3'b101)
            DCa[wbi][5*16 + 15: 5*16] = writeval;
        else if (wwi == 3'b110)
            DCa[wbi][6*16 + 15: 6*16] = writeval;
        else if (wwi == 3'b111)
            DCa[wbi][7*16 + 15: 7*16] = writeval;



        // Set Dirty Bit and Validity Bit
        DirtyBit[wbi] = 1'b1;
        ValidityBit[wbi] = 1'b1;
        bt[wbi] = WriteTag;
    end

    ReadTagCheck = !(ReadTag[1] ^ bt[rbi][1]) & !(ReadTag[2] ^ bt[rbi][2]);
    ReadHit = (ReadTagCheck & ValidityBit[rbi]);

    // Read
    if (ReadHit == 1'b1 && read == 1'b1) begin // Hit
        //$display("Read Hit");
        // Read
        if (rwi == 3'b000)
            readval = DCa[rbi][0*16 + 15: 0*16];
        else if (rwi == 3'b001)
            readval = DCa[rbi][1*16 + 15: 1*16];
        else if (rwi == 3'b010)
            readval = DCa[rbi][2*16 + 15: 2*16];
        else if (rwi == 3'b011)
            readval = DCa[rbi][3*16 + 15: 3*16];
        else if (rwi == 3'b100)
            readval = DCa[rbi][4*16 + 15: 4*16];
        else if (rwi == 3'b101)
            readval = DCa[rbi][5*16 + 15: 5*16];
        else if (rwi == 3'b110)
            readval = DCa[rbi][6*16 + 15: 6*16];
        else if (rwi == 3'b111)
            readval = DCa[rbi][7*16 + 15: 7*16];
    end
    else if (ReadHit == 1'b0 && read == 1'b1) begin // Miss
        Tempra = 0;
        Tempra[13:3] = rbi;
        Tempra[2:0] = 3'b000;

        //$display("ReadMissDisp: DC block %d: %b", rbi, DCa[rbi]);

        // Write Back
        if (DirtyBit[rbi] == 1'b1) begin
            //$display("Read Miss Write Back");
            Tempra[15:14] = bt[rbi];

            MMem[Tempra + 0][15:0] = DCa[rbi][16*0 + 15 : 16*0];
            MMem[Tempra + 1][15:0] = DCa[rbi][16*1 + 15 : 16*1];
            MMem[Tempra + 2][15:0] = DCa[rbi][16*2 + 15 : 16*2];
            MMem[Tempra + 3][15:0] = DCa[rbi][16*3 + 15 : 16*3];
            MMem[Tempra + 4][15:0] = DCa[rbi][16*4 + 15 : 16*4];
            MMem[Tempra + 5][15:0] = DCa[rbi][16*5 + 15 : 16*5];
            MMem[Tempra + 6][15:0] = DCa[rbi][16*6 + 15 : 16*6];
            MMem[Tempra + 7][15:0] = DCa[rbi][16*7 + 15 : 16*7];
        end
        // Replace Block 
        Tempra[15:14] = ReadTag;
        DCa[rbi][16*0 + 15 : 16*0] = MMem[Tempra + 0][15:0];
        DCa[rbi][16*1 + 15 : 16*1] = MMem[Tempra + 1][15:0];
        DCa[rbi][16*2 + 15 : 16*2] = MMem[Tempra + 2][15:0];
        DCa[rbi][16*3 + 15 : 16*3] = MMem[Tempra + 3][15:0];
        DCa[rbi][16*4 + 15 : 16*4] = MMem[Tempra + 4][15:0];
        DCa[rbi][16*5 + 15 : 16*5] = MMem[Tempra + 5][15:0];
        DCa[rbi][16*6 + 15 : 16*6] = MMem[Tempra + 6][15:0];
        DCa[rbi][16*7 + 15 : 16*7] = MMem[Tempra + 7][15:0];

        bt[rbi] = ReadTag;
        ValidityBit[rbi] = 1'b1;
        DirtyBit[rbi] = 1'b0;


        // Then Read
        if (rwi == 3'b000)
            readval = DCa[rbi][0*16 + 15: 0*16];
        else if (rwi == 3'b001)
            readval = DCa[rbi][1*16 + 15: 1*16];
        else if (rwi == 3'b010)
            readval = DCa[rbi][2*16 + 15: 2*16];
        else if (rwi == 3'b011)
            readval = DCa[rbi][3*16 + 15: 3*16];
        else if (rwi == 3'b100)
            readval = DCa[rbi][4*16 + 15: 4*16];
        else if (rwi == 3'b101)
            readval = DCa[rbi][5*16 + 15: 5*16];
        else if (rwi == 3'b110)
            readval = DCa[rbi][6*16 + 15: 6*16];
        else if (rwi == 3'b111)
            readval = DCa[rbi][7*16 + 15: 7*16];
    end
end
endmodule