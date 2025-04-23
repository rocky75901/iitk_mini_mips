// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497


`timescale 1ns / 1ps
module instruction_decode (
    input [31:0] instr,
    output [5:0] op,
    output [4:0] src1,
    output [4:0] src2,
    output [4:0] dest,
    output [4:0] shift_val,
    output [5:0] func,
    output [15:0] imm_val,
    output [25:0] jmp_addr
);
    assign op = instr[31:26];
    assign src1 = instr[25:21];
    assign src2 = instr[20:16];
    assign dest = instr[15:11];
    assign shift_val = instr[10:6];
    assign func = instr[5:0];
    assign imm_val = instr[15:0];
    assign jmp_addr = instr[25:0];
    
endmodule
