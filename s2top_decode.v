module top_decode (
    input clk,reset,
    input [31:0] instruction_D,
    input [31:0] write_data_W,
    input RegWrite_W,
    input [4:0] rd_W,
    output [31:0] data1_D,data2_D,immediate_D,
    output [3:0] ALUControl_D,
    output ALUSrc_D,MemoryRead_D,MemoryWrite_D,Branch_D,Jump_D,operandA_sel_D,Reg_write_D,
    output [2:0] funct3_D,
    output [1:0] WriteBackSel_D,
    output [6:0] opcode_D,
    output [4:0] rs1_D,rs2_D,rd_D
);

wire funct7;
wire [2:0] ImmSel,ALUOp;

instruction_decoder u_instruction_decoder (
    .instruction_D(instruction_D),//ip
    .opcode_D(opcode_D),//op
    .rs1_D(rs1_D),
    .rs2_D(rs2_D),
    .rd_D(rd_D),
    .funct3_D(funct3_D),
    .funct7(funct7)
);

register_file u_register_file (
    .clk(clk),
    .reset(reset),
    .rd_W(rd_W),
    .rs1_D(rs1_D),
    .rs2_D(rs2_D),
    .RegWrite_W(RegWrite_W),
    .write_data_W(write_data_W),
    .rs1_data_D(rs1_data_D),
    .rs2_data_D(rs2_data_D)
);



control_unit u_control_unit (
    .instruction_D(instruction_D),
    .RegWrite_D(RegWrite_D),
    .ALUSrc_D(ALUSrc_D),
    .MemoryRead_D(MemoryRead_D),
    .MemoryWrite_D(MemoryWrite_D),
    .Branch_D(Branch_D),
    .Jump_D(Jump_D),
    .operandA_sel_D(operandA_sel_D),
    .ImmSel_D(ImmSel_D),
    .ALUOp_D(ALUOp_D),
    .WriteBackSel_D(WriteBackSel_D)
);

immediate_generator u_immediate_generator (
    .instruction_D(instruction_D),
    .ImmSel_D(ImmSel_D),
    .immediate_D(immediate_D)
);

alu_control u_alu_control (
    .instruction_D(instruction_D),
    .ALUOp_D(ALUOp_D),
    .ALUControl_D(ALUControl_D)
);

endmodule