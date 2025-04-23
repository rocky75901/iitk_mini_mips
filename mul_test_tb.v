// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497


`timescale 1ns / 1ps
`include "iitk_mini_mips_pkg.v"

module mul_test_tb;
    reg clk;
    reg reset;
    reg load_mode;
    reg wr_en;
    reg [7:0] load_addr;
    reg [31:0] load_instr;
    wire [31:0] pc_val;
    wire [31:0] curr_instr;
    wire [31:0] alu_out;

    // Instantiate the processor
    iitk_mini_mips processor(
        .clk(clk),
        .reset(reset),
        .load_mode(load_mode),
        .wr_en(wr_en),
        .load_addr(load_addr),
        .load_instr(load_instr),
        .pc_val(pc_val),
        .curr_instr(curr_instr),
        .alu_out(alu_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test program
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        load_mode = 0;
        wr_en = 0;
        load_addr = 0;
        load_instr = 0;
        
        #20;
        
        // Load the program
        load_mode = 1;
        wr_en = 1;
        reset = 1;

        // Test Case 1: 0x18 × 0x11 (24 × 17)
        // Load 0x18 into $t0
        load_addr = 0;
        load_instr = 32'h20080018;  // addi $t0, $zero, 0x18
        #10;
        
        // Load 0x11 into $t1
        load_addr = 1;
        load_instr = 32'h20090011;  // addi $t1, $zero, 0x11
        #10;
        
        // Multiply and store in $t2
        load_addr = 2;
        load_instr = 32'h71095002;  // mul $t2, $t0, $t1
        #10;
        
        // Store result in memory
        load_addr = 3;
        load_instr = 32'h3c011001;  // lui $at, 0x1001
        #10;
        
        load_addr = 4;
        load_instr = 32'hac2a0000;  // sw $t2, 0($at)
        #10;

        // Test Case 2: 0xFFF4 × 0x9 (-12 × 9)
        // Load 0xFFF4 into $t0
        load_addr = 5;
        load_instr = 32'h2008fff4;  // addi $t0, $zero, -12 (0xFFF4)
        #10;
        
        // Load 0x9 into $t1
        load_addr = 6;
        load_instr = 32'h20090009;  // addi $t1, $zero, 0x9
        #10;
        
        // Multiply and store in $t2
        load_addr = 7;
        load_instr = 32'h71095002;  // mul $t2, $t0, $t1
        #10;
        
        // Store result
        load_addr = 8;
        load_instr = 32'hac2b0004;  // sw $t2, 4($at)
        #10;
/*
        // Test Case 3: 0x1DE × 0x0 (478 × 0)
        // Load 0x1DE into $t0
        load_addr = 9;
        load_instr = 32'h240801de;  // addiu $t0, $zero, 0x1DE
        #10;
        
        // Load 0x0 into $t1
        load_addr = 10;
        load_instr = 32'h20090000;  // addi $t1, $zero, 0x0
        #10;
        
        // Multiply
        load_addr = 11;
        load_instr = 32'h71095002;  // mul $t2, $t0, $t1
        #10;
        
        // Store result
        load_addr = 12;
        load_instr = 32'hac2a0008;  // sw $t2, 8($at)
        #10;

        // Test Case 4: 0x7530 × 0x7530 (30000 × 30000)
        // Load 0x7530 into $t0
        load_addr = 13;
        load_instr = 32'h3c080000;  // lui $t0, 0x0000
        #10;
        
        load_addr = 14;
        load_instr = 32'h35087530;  // ori $t0, $t0, 0x7530
        #10;
        
        // Load 0x7530 into $t1
        load_addr = 15;
        load_instr = 32'h3c090000;  // lui $t1, 0x0000
        #10;
        
        load_addr = 16;
        load_instr = 32'h35297530;  // ori $t1, $t1, 0x7530
        #10;
        
        // Multiply
        load_addr = 17;
        load_instr = 32'h71095002;  // mul $t2, $t0, $t1
        #10;
        
        // Store result
        load_addr = 18;
        load_instr = 32'hac2a000c;  // sw $t2, 12($at)
        #10;
        */
        // Finish loading and start execution
        load_mode = 0;
        wr_en = 0;
        #10;
        reset = 0;
        
        // Run the program
        #500;
        
        // Display results in a clean format
        $display("\nMULTIPLICATION RESULTS:");
        $display("24 x 17 = 0x%h    // 0x18 x 0x11", processor.DMEM.data_ram[0]);
        $display("-12 x 9 = 0x%h  // 0xFFF4 x 0x9", processor.DMEM.data_ram[1]);
        $display("478 x 0 = 0x%h     // 0x1DE x 0x0", processor.DMEM.data_ram[2]);
        $display("30000 x 30000 = 0x%h // 0x7530 x 0x7530", processor.DMEM.data_ram[3]);
        
        $finish;
    end
endmodule 