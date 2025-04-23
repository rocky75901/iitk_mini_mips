// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497



`timescale 1ns / 1ps
module control_unit (
    input [5:0] op,
    input [5:0] func,
    output reg reg_dest, alu_src, mem_to_reg, reg_wr,
    output reg mem_rd, mem_wr, branch, jump,
    output reg jal, jr,
    output reg [2:0] branch_sel,
    output reg [4:0] alu_op
);

    // Internal signals
    reg [1:0] alu_op_type;

    always @(*) begin
        // Default values
        reg_dest = 1'b0;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_wr = 1'b0;
        mem_rd = 1'b0;
        mem_wr = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        jal = 1'b0;
        jr = 1'b0;
        branch_sel = 3'b000;
        alu_op_type = 2'b00;

        case (op)
            `OPCODE_RTYPE: begin
                reg_dest = 1'b1;
                reg_wr = 1'b1;
                alu_op_type = 2'b10;
                
                case (func)
                    `FUNCT_ADD: alu_op = `ALU_ADD;
                    `FUNCT_SUB: alu_op = `ALU_SUB;
                    `FUNCT_ADDU: alu_op = `ALU_ADDU;
                    `FUNCT_SUBU: alu_op = `ALU_SUBU;
                    `FUNCT_AND: alu_op = `ALU_AND;
                    `FUNCT_OR: alu_op = `ALU_OR;
                    `FUNCT_XOR: alu_op = `ALU_XOR;
                    `FUNCT_NOT: alu_op = `ALU_NOT;
                    `FUNCT_SLL: alu_op = `ALU_SLL;
                    `FUNCT_SRL: alu_op = `ALU_SRL;
                    `FUNCT_SRA: alu_op = `ALU_SRA;
                    `FUNCT_SLA: alu_op = `ALU_SLA;
                    `FUNCT_SLT: alu_op = `ALU_SLT;
                    `FUNCT_MUL: alu_op = `ALU_MUL;
                    `FUNCT_MADD: alu_op = `ALU_MADD;
                    `FUNCT_MADDU: alu_op = `ALU_MADDU;
                    `FUNCT_JR: begin
                        jr = 1'b1;
                        reg_wr = 1'b0;
                    end
                    default: alu_op = `ALU_NOP;
                endcase
            end

            `OPCODE_ADDI: begin
                alu_src = 1'b1;
                reg_wr = 1'b1;
                alu_op = `ALU_ADD;
            end

            `OPCODE_ADDIU: begin
                alu_src = 1'b1;
                reg_wr = 1'b1;
                alu_op = `ALU_ADDU;
            end

            `OPCODE_ANDI: begin
                alu_src = 1'b1;
                reg_wr = 1'b1;
                alu_op = `ALU_AND;
            end

            `OPCODE_ORI: begin
                alu_src = 1'b1;
                reg_wr = 1'b1;
                alu_op = `ALU_OR;
            end

            `OPCODE_XORI: begin
                alu_src = 1'b1;
                reg_wr = 1'b1;
                alu_op = `ALU_XOR;
            end

            `OPCODE_SLTI: begin
                alu_src = 1'b1;
                reg_wr = 1'b1;
                alu_op = `ALU_SLT;
            end

            `OPCODE_LW: begin
                alu_src = 1'b1;
                mem_to_reg = 1'b1;
                reg_wr = 1'b1;
                mem_rd = 1'b1;
                alu_op = `ALU_ADD;
            end

            `OPCODE_SW: begin
                alu_src = 1'b1;
                mem_wr = 1'b1;
                alu_op = `ALU_ADD;
            end

            `OPCODE_BEQ: begin
                branch = 1'b1;
                branch_sel = 3'b000;
                alu_op = `ALU_SUB;
            end

            `OPCODE_BNE: begin
                branch = 1'b1;
                branch_sel = 3'b001;
                alu_op = `ALU_SUB;
            end

            `OPCODE_BRANCHX: begin
                branch = 1'b1;
                case (func)
                    `FUNCT_BGT: branch_sel = 3'b010;
                    `FUNCT_BGTE: branch_sel = 3'b011;
                    `FUNCT_BLE: branch_sel = 3'b100;
                    `FUNCT_BLEQ: branch_sel = 3'b101;
                    `FUNCT_BLEU: branch_sel = 3'b110;
                    `FUNCT_BGTU: branch_sel = 3'b111;
                    `FUNCT_SEQ: alu_op = `ALU_SEQ;
                    default: branch_sel = 3'b000;
                endcase
            end

            `OPCODE_J: begin
                jump = 1'b1;
            end

            `OPCODE_JAL: begin
                jump = 1'b1;
                jal = 1'b1;
                reg_wr = 1'b1;
            end

            `OPCODE_MULX: begin
                reg_dest = 1'b1;
                reg_wr = 1'b1;
                case (func)
                    `FUNCT_MUL: alu_op = `ALU_MUL;
                    `FUNCT_MADD: alu_op = `ALU_MADD;
                    `FUNCT_MADDU: alu_op = `ALU_MADDU;
                    default: alu_op = `ALU_NOP;
                endcase
            end

            default: begin
                alu_op = `ALU_NOP;
            end
        endcase
    end
endmodule