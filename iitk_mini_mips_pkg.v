// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497



// ==================== OPCODES ====================
`define OPCODE_RTYPE   6'b000000
`define OPCODE_ADDI    6'b001000
`define OPCODE_ADDIU   6'b001001
`define OPCODE_ANDI    6'b001100
`define OPCODE_ORI     6'b001101
`define OPCODE_XORI    6'b001110
`define OPCODE_LUI     6'b001111
`define OPCODE_SLTI    6'b001010
`define OPCODE_LW      6'b100011
`define OPCODE_SW      6'b101011
`define OPCODE_BEQ     6'b000100
`define OPCODE_BNE     6'b000101
`define OPCODE_J       6'b000010
`define OPCODE_JAL     6'b000011
`define OPCODE_BRANCHX 6'b011111  // custom branches and seq
`define OPCODE_MULX    6'b011100  // mul, madd, maddu
`define OPCODE_FP      6'b010001  // floating point + mfc1/mtc1

// ==================== FUNCTION CODES (R-TYPE) ====================
`define FUNCT_ADD      6'b100000
`define FUNCT_SUB      6'b100010
`define FUNCT_ADDU     6'b100001
`define FUNCT_SUBU     6'b100011
`define FUNCT_AND      6'b100100
`define FUNCT_OR       6'b100101
`define FUNCT_XOR      6'b100110
`define FUNCT_SLL      6'b000000
`define FUNCT_SRL      6'b000010
`define FUNCT_SRA      6'b000011
`define FUNCT_SLT      6'b101010
`define FUNCT_JR       6'b001000
`define FUNCT_MUL      6'b000010
`define FUNCT_MADD     6'b000000
`define FUNCT_MADDU    6'b000001
`define FUNCT_NOT      6'b100111
`define FUNCT_SLA      6'b000001

// ==================== CUSTOM BRANCH FUNCTS (011111) ====================
`define FUNCT_BGT      6'b010001
`define FUNCT_BGTE     6'b010010
`define FUNCT_BLE      6'b010011
`define FUNCT_BLEQ     6'b010100
`define FUNCT_BLEU     6'b010101
`define FUNCT_BGTU     6'b010110
`define FUNCT_SEQ      6'b011000

// ==================== FLOATING POINT FUNCTS (010001) ====================
`define FUNCT_MFC1     6'b000000
`define FUNCT_MTC1     6'b000001
`define FUNCT_ADD_S    6'b000010
`define FUNCT_SUB_S    6'b000011
`define FUNCT_MOV_S    6'b000110
`define FUNCT_C_EQ_S   6'b110010
`define FUNCT_C_LE_S   6'b110111
`define FUNCT_C_LT_S   6'b110101
`define FUNCT_C_GE_S   6'b111000
`define FUNCT_C_GT_S   6'b111001

// ==================== ALU CONTROL SIGNALS ====================
// These are used inside the ALU (5-bit)
`define ALU_ADD        5'b00000
`define ALU_SUB        5'b00001
`define ALU_ADDU       5'b00010
`define ALU_SUBU       5'b00011
`define ALU_MUL        5'b00100
`define ALU_MADD       5'b00101
`define ALU_MADDU      5'b00110
`define ALU_AND        5'b01000
`define ALU_OR         5'b01001
`define ALU_XOR        5'b01010
`define ALU_NOT        5'b01011
`define ALU_SLL        5'b01100
`define ALU_SRL        5'b01101
`define ALU_SRA        5'b01110
`define ALU_SLA        5'b01111
`define ALU_SLT        5'b10000
`define ALU_SEQ        5'b10001
`define ALU_NOP        5'b11111
