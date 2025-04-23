// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497


# IITK Mini MIPS Processor

This project implements a single-cycle MIPS processor with a comprehensive instruction set. The processor follows the MIPS-32 ISA with additional custom instructions and features.

## Project Overview

The IITK Mini MIPS processor features:

- 32-bit word size and instruction size
- 32 general-purpose registers
- Separate instruction and data memories (256 words each)
- Single-cycle instruction execution
- Support for R-type, I-type, and J-type instructions
- Enhanced branch and multiplication capabilities
- Memory-mapped I/O with base addresses at 0x00400000 (text) and 0x10010000 (data)

## Project Structure

The implementation consists of the following key modules:

1. `iitk_mini_mips.v` - Top-level module integrating all components
2. `regfile.v` - Register file implementation with 32 general-purpose registers
3. `alu.v` - Arithmetic Logic Unit implementation with multiplication support
4. `control_unit.v` - Control unit for instruction decoding and control signal generation
5. `instruction_memory.v` - Instruction memory module (256 words)
6. `data_memory.v` - Data memory module (256 words)
7. `instruction_fetch.v` - Instruction fetch unit with program counter
8. `instruction_decode.v` - Instruction decode unit for field extraction
9. `branch_unit.v` - Branch control unit with enhanced branch conditions
10. `iitk_mini_mips_pkg.v` - Package containing constants and definitions

## Implementation Details

### Register File

- Supports 32 general-purpose registers
- Register $0 (zero) is hardwired to 0
- Supports simultaneous read of two registers
- Write operations are clocked and controlled by RegWrite signal
- Register destination selection based on instruction type

### Memory Organization

- Separate instruction and data memories (256 words each)
- Instruction memory base address: 0x00400000
- Data memory base address: 0x10010000
- 32-bit word size
- Synchronous write operations
- Asynchronous read operations
- Memory-mapped addressing

### Control Unit

- Decodes instruction opcodes and function codes
- Generates control signals for:
  - ALU operations
  - Register file operations
  - Memory operations
  - Branch and jump operations
  - Multiplication operations
- Supports custom opcodes for extended functionality

### ALU Implementation

- Supports arithmetic operations (add, sub, addiu, subu)
- Supports logical operations (and, or, xor, not)
- Supports shift operations (sll, srl, sra, sla)
- Supports comparison operations (slt, seq)
- Supports multiplication operations (mul, madd, maddu)
- Handles both signed and unsigned operations

### Branch Unit

- Supports standard branch instructions (beq, bne)
- Enhanced branch conditions:
  - Greater than (bgt)
  - Greater than or equal (bgte)
  - Less than (ble)
  - Less than or equal (bleq)
  - Less than unsigned (bleu)
  - Greater than unsigned (bgtu)
- Jump and jump-and-link support
- Jump register (jr) support

## Instruction Set Architecture

### R-Type Instructions (opcode = 000000)

| Instruction     | Format | Opcode | rs    | rt    | rd    | shamt    | func   |
| --------------- | ------ | ------ | ----- | ----- | ----- | -------- | ------ |
| add rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100000 |
| sub rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100010 |
| addu rd,rs,rt   | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100001 |
| subu rd,rs,rt   | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100011 |
| and rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100100 |
| or rd,rs,rt     | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100101 |
| xor rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 100110 |
| not rd,rs       | R      | 000000 | rs(5) | 00000 | rd(5) | 00000    | 100111 |
| sll rd,rt,shamt | R      | 000000 | 00000 | rt(5) | rd(5) | shamt(5) | 000000 |
| srl rd,rt,shamt | R      | 000000 | 00000 | rt(5) | rd(5) | shamt(5) | 000010 |
| sra rd,rt,shamt | R      | 000000 | 00000 | rt(5) | rd(5) | shamt(5) | 000011 |
| sla rd,rt,shamt | R      | 000000 | 00000 | rt(5) | rd(5) | shamt(5) | 000100 |
| slt rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 101010 |
| seq rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 101011 |
| mul rd,rs,rt    | R      | 000000 | rs(5) | rt(5) | rd(5) | 00000    | 011110 |
| madd rs,rt      | R      | 000000 | rs(5) | rt(5) | 00000 | 00000    | 011100 |
| maddu rs,rt     | R      | 000000 | rs(5) | rt(5) | 00000 | 00000    | 011101 |
| jr rs           | R      | 000000 | rs(5) | 00000 | 00000 | 00000    | 001000 |

### I-Type Instructions

| Instruction      | Format | Opcode | rs    | rt    | immediate  |
| ---------------- | ------ | ------ | ----- | ----- | ---------- |
| addi rt,rs,imm   | I      | 001000 | rs(5) | rt(5) | imm(16)    |
| addiu rt,rs,imm  | I      | 001001 | rs(5) | rt(5) | imm(16)    |
| andi rt,rs,imm   | I      | 001100 | rs(5) | rt(5) | imm(16)    |
| ori rt,rs,imm    | I      | 001101 | rs(5) | rt(5) | imm(16)    |
| xori rt,rs,imm   | I      | 001110 | rs(5) | rt(5) | imm(16)    |
| lui rt,imm       | I      | 001111 | 00000 | rt(5) | imm(16)    |
| lw rt,offset(rs) | I      | 100011 | rs(5) | rt(5) | offset(16) |
| sw rt,offset(rs) | I      | 101011 | rs(5) | rt(5) | offset(16) |
| slti rt,rs,imm   | I      | 001010 | rs(5) | rt(5) | imm(16)    |
| beq rs,rt,offset | I      | 000100 | rs(5) | rt(5) | offset(16) |
| bne rs,rt,offset | I      | 000101 | rs(5) | rt(5) | offset(16) |

### J-Type Instructions

| Instruction | Format | Opcode | address     |
| ----------- | ------ | ------ | ----------- |
| j target    | J      | 000010 | address(26) |
| jal target  | J      | 000011 | address(26) |

### Custom Branch Instructions (opcode = 011111)

| Instruction       | Format | Opcode | rs    | rt    | rd    | shamt | func   |
| ----------------- | ------ | ------ | ----- | ----- | ----- | ----- | ------ |
| bgt rs,rt,offset  | I      | 011111 | rs(5) | rt(5) | 00000 | 00000 | 010001 |
| bgte rs,rt,offset | I      | 011111 | rs(5) | rt(5) | 00000 | 00000 | 010010 |
| ble rs,rt,offset  | I      | 011111 | rs(5) | rt(5) | 00000 | 00000 | 010011 |
| bleq rs,rt,offset | I      | 011111 | rs(5) | rt(5) | 00000 | 00000 | 010100 |
| bleu rs,rt,offset | I      | 011111 | rs(5) | rt(5) | 00000 | 00000 | 010101 |
| bgtu rs,rt,offset | I      | 011111 | rs(5) | rt(5) | 00000 | 00000 | 010110 |

## Control Signals

The control unit generates the following signals for instruction execution:

- `reg_dest`: Register destination selection (0: rt, 1: rd)
- `alu_src`: ALU source selection (0: register, 1: immediate)
- `mem_to_reg`: Memory to register transfer
- `reg_wr`: Register write enable
- `mem_rd`: Memory read enable
- `mem_wr`: Memory write enable
- `branch`: Branch operation
- `jump`: Jump operation
- `jal`: Jump and link operation
- `jr`: Jump register operation
- `branch_sel`: Branch condition selection
- `alu_op`: ALU operation selection

## Testing

The project includes test benches for verification:

- `mul_test_tb.v`: Testbench for multiplication operations
  - Tests multiplication of positive numbers (24 × 17)
  - Tests multiplication with negative numbers (-12 × 9)
  - Tests multiplication with zero (478 × 0)
  - Tests multiplication of large numbers (30000 × 30000)
- `insertion_sort_display.v`: Testbench for sorting algorithm implementation
  - Demonstrates sorting an 8-element array using insertion sort
  - Shows the original unsorted array and the final sorted array

## Usage

To use the processor:

1. Load instructions into instruction memory using the load mode
   - Set `load_mode` to 1
   - Set `wr_en` to 1
   - Set `load_addr` to the desired instruction address
   - Set `load_instr` to the instruction to load
2. Provide clock and reset signals
   - Clock period: 10ns (5ns high, 5ns low)
   - Reset initializes PC to 0x00400000
3. Monitor the outputs:
   - `pc_val`: Current program counter value
   - `curr_instr`: Current instruction being executed
   - `alu_out`: ALU operation result

## Memory Map

- Text Segment: 0x00400000 - 0x00400FFF (4KB)
- Data Segment: 0x10010000 - 0x10010FFF (4KB)

Note:

- rs: Source register 1
- rt: Source register 2
- rd: Destination register
- imm: Immediate value
- offset: Branch offset
- address: Jump target address
- shamt: Shift amount
