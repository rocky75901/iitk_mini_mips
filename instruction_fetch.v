// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497


`timescale 1ns / 1ps
module instruction_fetch (
    input clk,
    input reset,
    input load_mode,
    input wr_en,
    input [7:0] load_addr,
    input [31:0] load_instr,
    input [31:0] next_pc,
    input branch_taken,
    output reg [31:0] pc,
    output [31:0] fetched_instr
);
    instruction_memory IMEM (
        .clk(clk),
        .load_mode(load_mode),
        .load_addr(load_addr),
        .load_instr(load_instr),
        .wr_en(wr_en),
        .fetch_addr(pc),
        .fetched_instr(fetched_instr)
    );

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'h00400000;
        else if (branch_taken)
            pc <= next_pc;
        else
            pc <= pc + 4;
    end
endmodule