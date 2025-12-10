module branch_predictor (
    input         clk,
    input         reset,

    input         Eval_branch,
    input         PCSrcE,           // actual outcome: 1 = taken, 0 = not taken
    input  [31:0] Act_Target,
    input  [31:0] instr,
    input  [31:0] PC,

    output        predict_branch,
    output [31:0] Target_final,

    input         StateUpdateEnable,
    input         jalr,

    // >>> Accuracy monitoring outputs <<<
    output reg [31:0] total_branches,
    output reg [31:0] mispredicts
);

    // 2-bit state encoding
    localparam STRONG_NOT_TAKEN = 2'b00;
    localparam WEAK_NOT_TAKEN   = 2'b01;
    localparam WEAK_TAKEN       = 2'b10;
    localparam STRONG_TAKEN     = 2'b11;

    // ---- BHT: 64 entries ----
    localparam BHT_ENTRIES    = 64;
    localparam BHT_INDEX_BITS = 6;

    reg [1:0] bht [0:BHT_ENTRIES-1];
    wire [BHT_INDEX_BITS-1:0] bht_index = PC[7:2];

    wire [1:0] state = bht[bht_index];
    reg        predicted;

    // Decode instr
    wire [6:0] opcode   = instr[6:0];
    wire       is_branch= (opcode == 7'b1100011);
    wire       is_jal   = (opcode == 7'b1101111);

    // Immediate + target calc
    wire [31:0] imm;
    assign imm =
        is_branch ? {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0} :
        is_jal    ? {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0} :
                    32'b0;

    wire [31:0] Target = PC + imm;
    wire        sel_jalr = Eval_branch | jalr;

    // Your mux2
    mux2 #(.WIDTH(32)) targetmux (
        .d0(Target),
        .d1(Act_Target),
        .sel(sel_jalr),
        .y(Target_final)
    );

    // Prediction from BHT state (only for conditional branches)
    always @(*) begin
        case (state)
            STRONG_NOT_TAKEN,
            WEAK_NOT_TAKEN: predicted = 1'b0;
            WEAK_TAKEN,
            STRONG_TAKEN:   predicted = 1'b1;
        endcase
    end

    // Final prediction signal (includes jal/jalr/Eval_branch)
    assign predict_branch =
           jalr |
           is_jal |
           (is_branch & predicted) |
           Eval_branch;

    // BHT update + accuracy counters
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < BHT_ENTRIES; i = i + 1)
                bht[i] <= WEAK_TAKEN;   // good default

            // reset stats
            total_branches <= 32'd0;
            mispredicts    <= 32'd0;

        end else if (StateUpdateEnable && is_branch) begin
            // ---- Accuracy counting for conditional branches only ----
            total_branches <= total_branches + 1;

            // predicted = BHT prediction, PCSrcE = actual outcome
            if (predicted != PCSrcE)
                mispredicts <= mispredicts + 1;

            // ---- BHT state update ----
            case (bht[bht_index])
                STRONG_NOT_TAKEN: bht[bht_index] <= PCSrcE ? WEAK_NOT_TAKEN : STRONG_NOT_TAKEN;
                WEAK_NOT_TAKEN:   bht[bht_index] <= PCSrcE ? WEAK_TAKEN     : STRONG_NOT_TAKEN;
                WEAK_TAKEN:       bht[bht_index] <= PCSrcE ? STRONG_TAKEN   : WEAK_NOT_TAKEN;
                STRONG_TAKEN:     bht[bht_index] <= PCSrcE ? STRONG_TAKEN   : WEAK_TAKEN;
            endcase
        end
    end

endmodule
