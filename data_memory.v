// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497



`timescale 1ns / 1ps
module data_memory (
    input clk,
    input rd_en,
    input wr_en,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    // 256 words of 32-bit memory
    reg [31:0] data_ram [0:255];
    
    // Memory initialization
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            data_ram[i] = 32'h00000000;
    end

    // Calculate memory address relative to base
    wire [31:0] effective_addr = addr - 32'h10010000;
    wire [7:0] ram_ptr = effective_addr[9:2];  // Divide by 4 to get word address

    // Write operation
    always @(posedge clk) begin
        if (wr_en && ram_ptr < 256) begin
            data_ram[ram_ptr] <= data_in;
            $display("Memory Write: addr=%h (ram_ptr=%h) data=%h", addr, ram_ptr, data_in);
        end
    end

    // Read operation
    always @(*) begin
        if (rd_en && ram_ptr < 256) begin
            data_out = data_ram[ram_ptr];
            $display("Memory Read: addr=%h (ram_ptr=%h) data=%h", addr, ram_ptr, data_ram[ram_ptr]);
        end
        else
            data_out = 32'h00000000;
    end
endmodule