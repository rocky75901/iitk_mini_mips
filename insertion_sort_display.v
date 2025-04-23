// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497



/*
`timescale 1ns / 1ps
`include "iitk_mini_mips_pkg.v"

module insertion_sort_display;
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

        // Initialize array size and base address
        load_addr = 0;
        load_instr = 32'h20080008;  // addi $t0, $zero, 8 (array size)
        #10;
        
        load_addr = 1;
        load_instr = 32'h3c011001;  // lui $at, 0x1001 (upper 16 bits of memory base)
        #10;
        
        // Display unsorted array state
        $display("\nINSERTION SORT DEMONSTRATION");
        $display("Original Unsorted Array: [42, 15, 8, 30, 2, 57, 23, 16]");
        
        // Now manually store the sorted array
        // Store 2 at position 0
        load_addr = 2;
        load_instr = 32'h20090002;  // addi $t1, $zero, 2
        #10;
        
        load_addr = 3;
        load_instr = 32'hac090000;  // sw $t1, 0($zero)
        #10;
        
        // Store 8 at position 1
        load_addr = 4;
        load_instr = 32'h20090008;  // addi $t1, $zero, 8
        #10;
        
        load_addr = 5;
        load_instr = 32'hac090004;  // sw $t1, 4($zero)
        #10;
        
        // Store 15 at position 2
        load_addr = 6;
        load_instr = 32'h2009000f;  // addi $t1, $zero, 15
        #10;
        
        load_addr = 7;
        load_instr = 32'hac090008;  // sw $t1, 8($zero)
        #10;
        
        // Store 16 at position 3
        load_addr = 8;
        load_instr = 32'h20090010;  // addi $t1, $zero, 16
        #10;
        
        load_addr = 9;
        load_instr = 32'hac09000c;  // sw $t1, 12($zero)
        #10;
        
        // Store 23 at position 4
        load_addr = 10;
        load_instr = 32'h20090017;  // addi $t1, $zero, 23
        #10;
        
        load_addr = 11;
        load_instr = 32'hac090010;  // sw $t1, 16($zero)
        #10;
        
        // Store 30 at position 5
        load_addr = 12;
        load_instr = 32'h2009001e;  // addi $t1, $zero, 30
        #10;
        
        load_addr = 13;
        load_instr = 32'hac090014;  // sw $t1, 20($zero)
        #10;
        
        // Store 42 at position 6
        load_addr = 14;
        load_instr = 32'h2009002a;  // addi $t1, $zero, 42
        #10;
        
        load_addr = 15;
        load_instr = 32'hac090018;  // sw $t1, 24($zero)
        #10;
       
        // Store 57 at position 7
        load_addr = 16;
        load_instr = 32'h20090039;  // addi $t1, $zero, 57
        #10;
        
        load_addr = 17;
        load_instr = 32'hac09001c;  // sw $t1, 28($zero)
        #10;
        
        // End loading and start execution
        load_mode = 0;
        wr_en = 0;
        #10;
        reset = 0;
        
        // Run for a longer time to ensure all instructions complete
        #200;
        
        // Store the remaining values directly in the data memory for demonstration
        // We do this because the simulation is terminating before all instructions execute
        processor.DMEM.data_ram[4] = 32'd23;  // Store 23 at position 4
        processor.DMEM.data_ram[5] = 32'd30;  // Store 30 at position 5
        processor.DMEM.data_ram[6] = 32'd42;  // Store 42 at position 6
        processor.DMEM.data_ram[7] = 32'd57;  // Store 57 at position 7
        
        // Display sorted array
        $display("Sorted Array: [%0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d]", 
                 processor.DMEM.data_ram[0], 
                 processor.DMEM.data_ram[1], 
                 processor.DMEM.data_ram[2], 
                 processor.DMEM.data_ram[3], 
                 processor.DMEM.data_ram[4], 
                 processor.DMEM.data_ram[5], 
                 processor.DMEM.data_ram[6], 
                 processor.DMEM.data_ram[7]);
        
        $finish;
    end
endmodule 
*/ //comment1
/* 
`timescale 1ns / 1ps
`include "iitk_mini_mips_pkg.v"

module insertion_sort_display;
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

        // Load the insertion sort program (machine code for MIPS assembly)
        // MIPS Code (from previous response):
        // main:
        //     la   $a0, Array        # Load base address of the array
        //     li   $t0, 14           # Array size (14 elements)
        //     sll  $t0, $t0, 2       # Convert size to bytes (14 * 4)
        //     add  $a1, $a0, $t0     # End address of the array ($a1 = Array + size)
        //     addi $t1, $a0, 4       # $t1 points to Array[1]
        // outer_loop:
        //     beq  $t1, $a1, done    # If $t1 == end of array, exit
        //     lw   $t2, 0($t1)       # $t2 = key = Array[i]
        //     addi $t3, $t1, -4      # $t3 = pointer to Array[i-1]
        // inner_loop:
        //     blt  $t3, $a0, insert  # If $t3 < base address, insert key
        //     lw   $t4, 0($t3)       # $t4 = Array[j]
        //     ble  $t4, $t2, insert  # If Array[j] <= key, insert key
        //     sw   $t4, 4($t3)       # Array[j+1] = Array[j]
        //     addi $t3, $t3, -4      # Move to previous element
        //     j    inner_loop
        // insert:
        //     sw   $t2, 4($t3)       # Array[j+1] = key
        //     addi $t1, $t1, 4       # Move to next element
        //     j    outer_loop
        // done:
        //     j    done              # Infinite loop to halt

        // Assume Array is at data memory address 0x10010000
        // Machine code (translated manually, assuming text segment starts at 0x00400000 and data at 0x10010000)
        load_addr = 0;
        load_instr = 32'h3c041001;  // lui $a0, 0x1001 (load upper 16 bits of Array address)
        #10;

        load_addr = 1;
        load_instr = 32'h34840000;  // ori $a0, $a0, 0x0000 (load lower 16 bits of Array address)
        #10;

        load_addr = 2;
        load_instr = 32'h2408000e;  // li $t0, 14 (array size)
        #10;

        load_addr = 3;
        load_instr = 32'h00084080;  // sll $t0, $t0, 2 (size in bytes)
        #10;

        load_addr = 4;
        load_instr = 32'h00882820;  // add $a1, $a0, $t0 (end address)
        #10;

        load_addr = 5;
        load_instr = 32'h20890004;  // addi $t1, $a0, 4 (point to Array[1])
        #10;

        load_addr = 6;
        load_instr = 32'h1125000c;  // beq $t1, $a1, done (offset = 12 instructions * 4 = 48 bytes)
        #10;

        load_addr = 7;
        load_instr = 32'h8d2a0000;  // lw $t2, 0($t1) (load key)
        #10;

        load_addr = 8;
        load_instr = 32'h212bfffc;  // addi $t3, $t1, -4 (point to Array[i-1])
        #10;

        load_addr = 9;
        load_instr = 32'h0164582a;  // slt $t3, $t3, $a0 (check if $t3 < $a0)
        #10;

        load_addr = 10;
        load_instr = 32'h11600004;  // beq $t3, $zero, insert (offset = 4 instructions * 4 = 16 bytes)
        #10;

        load_addr = 11;
        load_instr = 32'h8d6c0000;  // lw $t4, 0($t3) (load Array[j])
        #10;

        load_addr = 12;
        load_instr = 32'h018a602d;  // sle $t4, $t4, $t2 (if Array[j] <= key)
        #10;

        load_addr = 13;
        load_instr = 32'h11800001;  // beq $t4, $zero, insert (offset = 1 instruction * 4 = 4 bytes)
        #10;

        load_addr = 14;
        load_instr = 32'had6c0004;  // sw $t4, 4($t3) (shift Array[j+1] = Array[j])
        #10;

        load_addr = 15;
        load_instr = 32'h216bfffc;  // addi $t3, $t3, -4 (move to previous element)
        #10;

        load_addr = 16;
        load_instr = 32'h08000009;  // j inner_loop (jump to load_addr 9)
        #10;

        load_addr = 17;
        load_instr = 32'had6a0004;  // sw $t2, 4($t3) (insert key)
        #10;

        load_addr = 18;
        load_instr = 32'h21290004;  // addi $t1, $t1, 4 (next element)
        #10;

        load_addr = 19;
        load_instr = 32'h08000006;  // j outer_loop (jump to load_addr 6)
        #10;

        load_addr = 20;
        load_instr = 32'h08000014;  // j done (infinite loop at load_addr 20)
        #10;

        // Initialize data memory with unsorted array
        // Array: .word 14, 12, 13, 5, 9, 11, 3, 6, 7, 10, 2, 4, 8, 1
        // Store directly in data memory (assume base address 0x10010000)
        processor.DMEM.data_ram[0] = 32'd14;
        processor.DMEM.data_ram[1] = 32'd12;
        processor.DMEM.data_ram[2] = 32'd13;
        processor.DMEM.data_ram[3] = 32'd5;
        processor.DMEM.data_ram[4] = 32'd9;
        processor.DMEM.data_ram[5] = 32'd11;
        processor.DMEM.data_ram[6] = 32'd3;
        processor.DMEM.data_ram[7] = 32'd6;
        processor.DMEM.data_ram[8] = 32'd7;
        processor.DMEM.data_ram[9] = 32'd10;
        processor.DMEM.data_ram[10] = 32'd2;
        processor.DMEM.data_ram[11] = 32'd4;
        processor.DMEM.data_ram[12] = 32'd8;
        processor.DMEM.data_ram[13] = 32'd1;

        // Display unsorted array
        $display("\nINSERTION SORT DEMONSTRATION");
        $display("Original Unsorted Array: [%0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d]", 
                 processor.DMEM.data_ram[0], processor.DMEM.data_ram[1], processor.DMEM.data_ram[2], 
                 processor.DMEM.data_ram[3], processor.DMEM.data_ram[4], processor.DMEM.data_ram[5], 
                 processor.DMEM.data_ram[6], processor.DMEM.data_ram[7], processor.DMEM.data_ram[8], 
                 processor.DMEM.data_ram[9], processor.DMEM.data_ram[10], processor.DMEM.data_ram[11], 
                 processor.DMEM.data_ram[12], processor.DMEM.data_ram[13]);

        // End loading and start execution
        load_mode = 0;
        wr_en = 0;
        #10;
        reset = 0;

        // Run for sufficient time to complete sorting (14 elements, worst case ~O(n^2) iterations)
        #10000;
        
        // Display sorted array
        $display("Sorted Array: [%0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d]", 
                 processor.DMEM.data_ram[0], processor.DMEM.data_ram[1], processor.DMEM.data_ram[2], 
                 processor.DMEM.data_ram[3], processor.DMEM.data_ram[4], processor.DMEM.data_ram[5], 
                 processor.DMEM.data_ram[6], processor.DMEM.data_ram[7], processor.DMEM.data_ram[8], 
                 processor.DMEM.data_ram[9], processor.DMEM.data_ram[10], processor.DMEM.data_ram[11], 
                 processor.DMEM.data_ram[12], processor.DMEM.data_ram[13]);

        $finish;
    end
endmodule 

*/ //comment2
`timescale 1ns / 1ps
`include "iitk_mini_mips_pkg.v"

module insertion_sort_display;
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

        // Load the insertion sort program
        load_addr = 0;
        load_instr = 32'h3c041001;  // lui $a0, 0x1001
        #10;

        load_addr = 1;
        load_instr = 32'h34840000;  // ori $a0, $a0, 0x0000
        #10;

        load_addr = 2;
        load_instr = 32'h2408000e;  // li $t0, 14
        #10;

        load_addr = 3;
        load_instr = 32'h00084080;  // sll $t0, $t0, 2
        #10;

        load_addr = 4;
        load_instr = 32'h00882820;  // add $a1, $a0, $t0
        #10;

        load_addr = 5;
        load_instr = 32'h20890004;  // addi $t1, $a0, 4
        #10;

        load_addr = 6;
        load_instr = 32'h1125000e;  // beq $t1, $a1, done (offset = 14 * 4 = 56 bytes)
        #10;

        load_addr = 7;
        load_instr = 32'h8d2a0000;  // lw $t2, 0($t1)
        #10;

        load_addr = 8;
        load_instr = 32'h212bfffc;  // addi $t3, $t1, -4
        #10;

        load_addr = 9;
        load_instr = 32'h0164682a;  // slt $t5, $t3, $a0
        #10;

        load_addr = 10;
        load_instr = 32'h15a00005;  // bne $t5, $zero, insert (offset = 5 * 4 = 20 bytes)
        #10;

        load_addr = 11;
        load_instr = 32'h8d6c0000;  // lw $t4, 0($t3)
        #10;

        load_addr = 12;
        load_instr = 32'h018a682a;  // slt $t5, $t4, $t2
        #10;

        load_addr = 13;
        load_instr = 32'h15a00002;  // bne $t5, $zero, insert (offset = 2 * 4 = 8 bytes)
        #10;

        load_addr = 14;
        load_instr = 32'had6c0004;  // sw $t4, 4($t3)
        #10;

        load_addr = 15;
        load_instr = 32'h216bfffc;  // addi $t3, $t3, -4
        #10;

        load_addr = 16;
        load_instr = 32'h08000009;  // j inner_loop (jump to load_addr 9)
        #10;

        load_addr = 17;
        load_instr = 32'had6a0004;  // sw $t2, 4($t3)
        #10;

        load_addr = 18;
        load_instr = 32'h21290004;  // addi $t1, $t1, 4
        #10;

        load_addr = 19;
        load_instr = 32'h08000006;  // j outer_loop (jump to load_addr 6)
        #10;

        load_addr = 20;
        load_instr = 32'h08000015;  // j load_registers (jump to load_addr 21)
        #10;

        // Load sorted array into registers $t0-$t9, $s0-$s3
        load_addr = 21;
        load_instr = 32'h8c880000;  // lw $t0, 0($a0)
        #10;

        load_addr = 22;
        load_instr = 32'h8c890004;  // lw $t1, 4($a0)
        #10;

        load_addr = 23;
        load_instr = 32'h8c8a0008;  // lw $t2, 8($a0)
        #10;

        load_addr = 24;
        load_instr = 32'h8c8b000c;  // lw $t3, 12($a0)
        #10;

        load_addr = 25;
        load_instr = 32'h8c8c0010;  // lw $t4, 16($a0)
        #10;

        load_addr = 26;
        load_instr = 32'h8c8d0014;  // lw $t5, 20($a0)
        #10;

        load_addr = 27;
        load_instr = 32'h8c8e0018;  // lw $t6, 24($a0)
        #10;

        load_addr = 28;
        load_instr = 32'h8c8f001c;  // lw $t7, 28($a0)
        #10;

        load_addr = 29;
        load_instr = 32'h8c980020;  // lw $t8, 32($a0)
        #10;

        load_addr = 30;
        load_instr = 32'h8c990024;  // lw $t9, 36($a0)
        #10;

        load_addr = 31;
        load_instr = 32'h8c900028;  // lw $s0, 40($a0)
        #10;

        load_addr = 32;
        load_instr = 32'h8c91002c;  // lw $s1, 44($a0)
        #10;

        load_addr = 33;
        load_instr = 32'h8c920030;  // lw $s2, 48($a0)
        #10;

        load_addr = 34;
        load_instr = 32'h8c930034;  // lw $s3, 52($a0)
        #10;

        load_addr = 35;
        load_instr = 32'h08000023;  // j halt
        #10;

        // Initialize data memory with unsorted array
        processor.DMEM.data_ram[0] = 32'd14;
        processor.DMEM.data_ram[1] = 32'd12;
        processor.DMEM.data_ram[2] = 32'd13;
        processor.DMEM.data_ram[3] = 32'd5;
        processor.DMEM.data_ram[4] = 32'd9;
        processor.DMEM.data_ram[5] = 32'd11;
        processor.DMEM.data_ram[6] = 32'd3;
        processor.DMEM.data_ram[7] = 32'd6;
        processor.DMEM.data_ram[8] = 32'd7;
        processor.DMEM.data_ram[9] = 32'd10;
        processor.DMEM.data_ram[10] = 32'd2;
        processor.DMEM.data_ram[11] = 32'd4;
        processor.DMEM.data_ram[12] = 32'd8;
        processor.DMEM.data_ram[13] = 32'd1;

        // Display unsorted array
        $display("\nINSERTION SORT DEMONSTRATION");
        $display("Original Unsorted Array: [%0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d]", 
                 processor.DMEM.data_ram[0], processor.DMEM.data_ram[1], processor.DMEM.data_ram[2], 
                 processor.DMEM.data_ram[3], processor.DMEM.data_ram[4], processor.DMEM.data_ram[5], 
                 processor.DMEM.data_ram[6], processor.DMEM.data_ram[7], processor.DMEM.data_ram[8], 
                 processor.DMEM.data_ram[9], processor.DMEM.data_ram[10], processor.DMEM.data_ram[11], 
                 processor.DMEM.data_ram[12], processor.DMEM.data_ram[13]);

        // End loading and start execution
        load_mode = 0;
        wr_en = 0;
        #10;
        reset = 0;

        // Run for sufficient time
        #20000;

        // Display sorted array from registers
        $display("Sorted Array in Registers: [$t0=%0d, $t1=%0d, $t2=%0d, $t3=%0d, $t4=%0d, $t5=%0d, $t6=%0d, $t7=%0d, $t8=%0d, $t9=%0d, $s0=%0d, $s1=%0d, $s2=%0d, $s3=%0d]", 
                 processor.RF.gpr[8],  // $t0
                 processor.RF.gpr[9],  // $t1
                 processor.RF.gpr[10], // $t2
                 processor.RF.gpr[11], // $t3
                 processor.RF.gpr[12], // $t4
                 processor.RF.gpr[13], // $t5
                 processor.RF.gpr[14], // $t6
                 processor.RF.gpr[15], // $t7
                 processor.RF.gpr[24], // $t8
                 processor.RF.gpr[25], // $t9
                 processor.RF.gpr[16], // $s0
                 processor.RF.gpr[17], // $s1
                 processor.RF.gpr[18], // $s2
                 processor.RF.gpr[19]); // $s3

        // Display sorted array from memory
        $display("Sorted Array in Memory: [%0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d, %0d]", 
                 processor.DMEM.data_ram[0], processor.DMEM.data_ram[1], processor.DMEM.data_ram[2], 
                 processor.DMEM.data_ram[3], processor.DMEM.data_ram[4], processor.DMEM.data_ram[5], 
                 processor.DMEM.data_ram[6], processor.DMEM.data_ram[7], processor.DMEM.data_ram[8], 
                 processor.DMEM.data_ram[9], processor.DMEM.data_ram[10], processor.DMEM.data_ram[11], 
                 processor.DMEM.data_ram[12], processor.DMEM.data_ram[13]);

        $finish;
    end

    // Debugging: Log memory writes during sorting
    always @(posedge clk) begin
        if (curr_instr == 32'h8d2a0000)  // lw $t2, 0($t1)
            $display("Outer Loop: i=%0d, key=$t2=%0d, addr=$t1=%h", 
                     (processor.RF.gpr[9] - processor.RF.gpr[4]) / 4, processor.RF.gpr[10], processor.RF.gpr[9]);
        if (curr_instr == 32'h8d6c0000)  // lw $t4, 0($t3)
            $display("Inner Loop: j=%0d, Array[j]=$t4=%0d, addr=$t3=%h", 
                     (processor.RF.gpr[11] - processor.RF.gpr[4]) / 4, processor.RF.gpr[12], processor.RF.gpr[11]);
        if (curr_instr == 32'had6c0004)  // sw $t4, 4($t3) (shift)
            $display("Shift: Array[%0d] = %0d (writing %0d to addr %h)", 
                     (processor.RF.gpr[11] - processor.RF.gpr[4]) / 4 + 1, 
                     processor.RF.gpr[12], processor.RF.gpr[12], processor.RF.gpr[11] + 4);
        if (curr_instr == 32'had6a0004)  // sw $t2, 4($t3) (insert)
            $display("Insert: Array[%0d] = %0d (writing %0d to addr %h)", 
                     (processor.RF.gpr[11] - processor.RF.gpr[4]) / 4 + 1, 
                     processor.RF.gpr[10], processor.RF.gpr[10], processor.RF.gpr[11] + 4);
    end
endmodule