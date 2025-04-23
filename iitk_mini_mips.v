// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497



`timescale 1ns / 1ps

`include "iitk_mini_mips_pkg.v"

module iitk_mini_mips (
    input clk,
    input reset,

   
    input load_mode,              
    input wr_en,                  
    input [7:0] load_addr,       
    input [31:0] load_instr,   

    output [31:0] pc_val,        
    output [31:0] curr_instr,     
    output [31:0] alu_out         
);
    // Internal signals
    wire [31:0] pc, fetched_instr;  
    wire [5:0] op, func;           
    wire [4:0] src1, src2, dest;    
    wire [4:0] shift_amt;          
    wire [15:0] imm_val;            
    wire [25:0] jmp_addr;           
    wire [4:0] alu_op;              
    wire [31:0] reg_src1, reg_src2, alu_res;  
    wire [63:0] mul_res;            
    wire [31:0] next_pc_val;       
    wire branch_cond;               
    wire branch_take;             

    // Control signals
    wire reg_dest, alu_src, mem_to_reg, reg_wr;  
    wire mem_rd, mem_wr;                         
    wire branch, jump, jal, jr;                  
    wire [2:0] branch_sel;                      
    wire [31:0] mem_data;                        

    // Branch signal
    assign branch_take = branch && branch_cond;

   
    instruction_fetch IF (
        .clk(clk),
        .reset(reset),
        .load_mode(load_mode),
        .wr_en(wr_en),
        .load_addr(load_addr),
        .load_instr(load_instr),
        .next_pc(next_pc_val),
        .branch_taken(branch_take),
        .pc(pc),
        .fetched_instr(fetched_instr)
    );

    // Instruction Decode
    instruction_decode ID (
        .instr(fetched_instr),
        .op(op), .src1(src1), .src2(src2), .dest(dest),
        .shift_val(shift_amt), .func(func),
        .imm_val(imm_val), .jmp_addr(jmp_addr)
    );

    // Control Unit
    control_unit CU (
        .op(op), .func(func),
        .reg_dest(reg_dest), .alu_src(alu_src), .mem_to_reg(mem_to_reg),
        .reg_wr(reg_wr), .mem_rd(mem_rd), .mem_wr(mem_wr),
        .branch(branch), .jump(jump), .jal(jal), .jr(jr),
        .branch_sel(branch_sel), .alu_op(alu_op)
    );

    regfile RF (
        .clk(clk), .src1(src1), .src2(src2), .dest(dest), .reg_wr(reg_wr),
        .wr_data(mem_to_reg ? mem_data : alu_res),
        .reg_dest(reg_dest),
        .src1_val(reg_src1), .src2_val(reg_src2)
    );

    alu ALU (
        .op1(reg_src1),
        .op2(alu_src ? {{16{imm_val[15]}}, imm_val} : reg_src2),
        .shift_val(shift_amt),
        .alu_func(alu_op),
        .mul_in(64'd0),
        .mul_out(mul_res),
        .result(alu_res)
    );

    data_memory DMEM (
        .clk(clk),
        .rd_en(mem_rd),
        .wr_en(mem_wr),
        .addr(alu_res),
        .data_in(reg_src2),
        .data_out(mem_data)
    );

    branch_unit BR (
        .curr_pc(pc),
        .src1_val(reg_src1),
        .src2_val(reg_src2),
        .offset(imm_val),
        .target_addr(jmp_addr),
        .branch_type(branch_sel),
        .jump_en(jump),
        .jal_en(jal),
        .jr_en(jr),
        .next_pc(next_pc_val),
        .branch_take(branch_cond)
    );

    assign pc_val = pc;
    assign curr_instr = fetched_instr;
    assign alu_out = alu_res;
endmodule

