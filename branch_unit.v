// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497



`timescale 1ns / 1ps
module branch_unit (
    input [31:0] curr_pc,          // Changed from pc_current
    input [31:0] src1_val,         // Changed from rs_val
    input [31:0] src2_val,         // Changed from rt_val
    input [15:0] offset,           // Changed from immediate
    input [25:0] target_addr,      // Changed from jump_address
    input [2:0] branch_type,       // Changed from branch_control
    input jump_en,                 // Changed from is_jump
    input jal_en,                  // Changed from is_jal
    input jr_en,                   // Changed from is_jr
    output reg [31:0] next_pc,     // Changed from next_pc
    output reg branch_take         // Changed from take_branch
);
    // Internal signals
    wire [31:0] branch_target;     // Changed from branch_addr
    wire [31:0] jump_target;       // Changed from jump_addr
    wire [31:0] jr_target;         // Changed from jr_addr

    // Calculate branch target
    assign branch_target = curr_pc + {{14{offset[15]}}, offset, 2'b00};

    // Calculate jump target
    assign jump_target = {curr_pc[31:28], target_addr, 2'b00};

    // JR target is source register value
    assign jr_target = src1_val;

    // Branch condition evaluation
    always @(*) begin
        case (branch_type)
            3'b000: branch_take = (src1_val == src2_val);    // BEQ
            3'b001: branch_take = (src1_val != src2_val);    // BNE
            3'b010: branch_take = ($signed(src1_val) > $signed(src2_val));  // BGT
            3'b011: branch_take = ($signed(src1_val) >= $signed(src2_val)); // BGTE
            3'b100: branch_take = ($signed(src1_val) < $signed(src2_val));  // BLE
            3'b101: branch_take = ($signed(src1_val) <= $signed(src2_val)); // BLEQ
            3'b110: branch_take = (src1_val < src2_val);     // BLEU
            3'b111: branch_take = (src1_val > src2_val);     // BGTU
            default: branch_take = 1'b0;
        endcase
    end

    // Next PC calculation
    always @(*) begin
        if (jr_en)
            next_pc = jr_target;
        else if (jump_en || jal_en)
            next_pc = jump_target;
        else if (branch_take)
            next_pc = branch_target;
        else
            next_pc = curr_pc + 4;
    end
endmodule
