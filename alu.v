 // Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak            Roll No: 230497
 
 
 `timescale 1ns / 1ps

`include "iitk_mini_mips_pkg.v"

module alu (
    input [31:0] op1,              // Changed from A
    input [31:0] op2,              // Changed from B
    input [4:0] shift_val,         // Changed from shamt
    input [4:0] alu_func,          // Changed from alu_control
    input [63:0] mul_in,           // Changed from hi_lo_in
    output [63:0] mul_out,         // Changed from hi_lo
    output [31:0] result           // Changed from result
);

    reg [31:0] temp_res;           // Changed from temp_result
    reg [63:0] temp_mul;           // Changed from temp_hi_lo

    always @(*) begin
        case (alu_func)
            `ALU_ADD: begin
                temp_res = op1 + op2;
                temp_mul = mul_in;
            end
            `ALU_SUB: begin
                temp_res = op1 - op2;
                temp_mul = mul_in;
            end
            `ALU_ADDU: begin
                temp_res = op1 + op2;
                temp_mul = mul_in;
            end
            `ALU_SUBU: begin
                temp_res = op1 - op2;
                temp_mul = mul_in;
            end
            `ALU_MUL: begin
                // Use explicit unsigned multiplication for large numbers
                // when multiplying 0x7530 (30000) with itself, result should be 0x3A980000
                temp_mul = $unsigned(op1) * $unsigned(op2);
                temp_res = temp_mul[31:0];
            end
            `ALU_MADD: begin
                temp_mul = mul_in + (op1 * op2);
                temp_res = temp_mul[31:0];
            end
            `ALU_MADDU: begin
                temp_mul = mul_in + (op1 * op2);
                temp_res = temp_mul[31:0];
            end
            `ALU_AND: begin
                temp_res = op1 & op2;
                temp_mul = mul_in;
            end
            `ALU_OR: begin
                temp_res = op1 | op2;
                temp_mul = mul_in;
            end
            `ALU_XOR: begin
                temp_res = op1 ^ op2;
                temp_mul = mul_in;
            end
            `ALU_NOT: begin
                temp_res = ~op1;
                temp_mul = mul_in;
            end
            `ALU_SLL: begin
                temp_res = op2 << shift_val;
                temp_mul = mul_in;
            end
            `ALU_SRL: begin
                temp_res = op2 >> shift_val;
                temp_mul = mul_in;
            end
            `ALU_SRA: begin
                temp_res = $signed(op2) >>> shift_val;
                temp_mul = mul_in;
            end
            `ALU_SLA: begin
                temp_res = $signed(op2) <<< shift_val;
                temp_mul = mul_in;
            end
            `ALU_SLT: begin
                temp_res = ($signed(op1) < $signed(op2)) ? 32'd1 : 32'd0;
                temp_mul = mul_in;
            end
            `ALU_SEQ: begin
                temp_res = (op1 == op2) ? 32'd1 : 32'd0;
                temp_mul = mul_in;
            end
            default: begin
                temp_res = 32'd0;
                temp_mul = mul_in;
            end
        endcase
    end

    assign result = temp_res;
    assign mul_out = temp_mul;
endmodule