// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497


`timescale 1ns / 1ps
module instruction_memory (
    input clk,
    input load_mode,
    input [7:0] load_addr,
    input [31:0] load_instr,
    input wr_en,
    input [31:0] fetch_addr,
    output [31:0] fetched_instr
);
    // 256 words of 32-bit memory
    reg [31:0] instr_ram [0:255];
    
    // Memory initialization
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            instr_ram[i] = 32'h00000000;
    end

    // Write operation during load mode
    always @(posedge clk) begin
        if (load_mode && wr_en) begin
            instr_ram[load_addr] <= load_instr;
            $display("Loading instruction at addr %h: %h", load_addr, load_instr);
        end
    end

    // Read operation with proper address translation
    wire [7:0] read_ptr;
    assign read_ptr = (fetch_addr - 32'h00400000) >> 2;
    
    // Debug output for instruction fetch
    reg [31:0] debug_instr;
    always @(*) begin
        debug_instr = instr_ram[read_ptr];
        if (!load_mode)
            $display("Fetching instruction at PC=%h (ram_addr=%h): %h", fetch_addr, read_ptr, debug_instr);
    end
    
    assign fetched_instr = instr_ram[read_ptr];
endmodule