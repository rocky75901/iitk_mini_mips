// Name: Voora Rakesh                    Roll No: 231174
// Name: Jarabala Govind Nayak           Roll No: 230497


`timescale 1ns / 1ps
module regfile (
    input clk,
    input [4:0] src1,
    input [4:0] src2,
    input [4:0] dest,
    input reg_wr,
    input [31:0] wr_data,
    input reg_dest,
    output [31:0] src1_val,
    output [31:0] src2_val
);
    reg [31:0] gpr [0:31];
  
  	integer i;
    initial begin
      for (i = 0; i < 32; i = i + 1)
        gpr[i] = 32'h00000000;
    end

    assign src1_val = (src1 == 0) ? 32'h00000000 : gpr[src1];
    assign src2_val = (src2 == 0) ? 32'h00000000 : gpr[src2];

    wire [4:0] write_reg = reg_dest ? dest : src2;

    always @(posedge clk) begin
      if (reg_wr && write_reg != 0) begin
          gpr[write_reg] <= wr_data;
//           $display("Register Write: R[%0d] <= %h", write_reg, wr_data);
      end
	end
endmodule


