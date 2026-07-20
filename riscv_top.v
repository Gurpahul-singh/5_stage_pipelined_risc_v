module risc_v_top (
    input clk, reset,
    output [31:0] pc, instruction,
);

    wire pc_sel;
    wire [31:0] branched_address;
    fetch_top u1_fetch_top (
        .clk(clk),
        .reset(reset),
        .pc_sel(pc_sel),
        .branched_address(branched_address),
        .pc(pc),
        .instruction(instruction)
    );

    wire [31:0] instruction_D, pc_D;

    IF_ID u1_IF_ID (
        .clk(clk),
        .reset(reset),
        .instruction_F(instruction),
        .pc_F(pc),
        .instruction_D(instruction_D),
        .pc_D(pc_D)
    );

    wire [31:0] write_data_W;
    
    wire [31:0] data1_D, data2_D, immediate_D;
    wire [3:0] ALUControl_D;
    wire ALUSrc_D, MemoryRead_D, MemoryWrite_D, Branch_D, Jump_D, operandA_sel_D, Reg_write_D;
    wire [2:0] funct3_D;
    wire [1:0] WriteBackSel_D;
    wire [6:0] opcode_D;
    wire [4:0] rs1_D, rs2_D, rd_D;

    top_decode u1_top_decode (
        .clk(clk),
        .reset(reset),
        .instruction_D(instruction_D),
        .write_data_W(write_data_W),******************
        .RegWrite_W(RegWrite_W),
        .rd_W(rd_W),
        .data1_D(data1_D),
        .data2_D(data2_D),
        .immediate_D(immediate_D),
        .ALUControl_D(ALUControl_D),
        .ALUSrc_D(ALUSrc_D),
        .MemoryRead_D(MemoryRead_D),
        .MemoryWrite_D(MemoryWrite_D),
        .Branch_D(Branch_D),
        .Jump_D(Jump_D),
        .operandA_sel_D(operandA_sel_D),
        .Reg_write_D(Reg_write_D),
        .funct3_D(funct3_D),
        .WriteBackSel_D(WriteBackSel_D),
        .opcode_D(opcode_D),
        .rs1_D(rs1_D),
        .rs2_D(rs2_D),
        .rd_D(rd_D)
    );

    wire [31:0] data1_E, data2_E, immediate_E, pc_E;
    wire [3:0] ALUControl_E;
    wire [1:0] WriteBackSel_E;
    wire operandA_sel_E, ALUSrc_E, MemoryRead_E, MemoryWrite_E, Branch_E, Jump_E, reg_write_E;
    wire [2:0] funct3_E;
    wire [6:0] opcode_E;
    wire [4:0] rd_E, rs1_E, rs2_E;

    ID_EX u1_ID_EX (
        .clk(clk),
        .reset(reset),
        .data1_D(data1_D),
        .data2_D(data2_D),
        .immediate_D(immediate_D),
        .pc_D(pc_D),
        .ALUControl_D(ALUControl_D),
        .WriteBackSel_D(WriteBackSel_D),
        .operandA_sel_D(operandA_sel_D),
        .ALUSrc_D(ALUSrc_D),
        .MemoryRead_D(MemoryRead_D),
        .MemoryWrite_D(MemoryWrite_D),
        .Branch_D(Branch_D),
        .Jump_D(Jump_D),
        .reg_write_D(Reg_write_D),
        .funct3_D(funct3_D),
        .opcode_D(opcode_D),
        .rd_D(rd_D),
        .rs1_D(rs1_D),
        .rs2_D(rs2_D)

        // output ports for ID_EX stage
        .data1_E(data1_E),
        .data2_E(data2_E),
        .immediate_E(immediate_E),
        .pc_E(pc_E),
        .ALUControl_E(ALUControl_E),    
        .WriteBackSel_E(WriteBackSel_E),
        .operandA_sel_E(operandA_sel_E),
        .ALUSrc_E(ALUSrc_E),
        .MemoryRead_E(MemoryRead_E),
        .MemoryWrite_E(MemoryWrite_E),
        .Branch_E(Branch_E),
        .Jump_E(Jump_E),
        .reg_write_E(reg_write_E),
        .funct3_E(funct3_E),
        .opcode_E(opcode_E),
        .rd_E(rd_E),
        .rs1_E(rs1_E),
        .rs2_E(rs2_E)
    );


    branch_jump_unit u1_branch_jump_unit (
        .pc_E(pc_E),
        .immediate_E(immediate_E),
        .rs1_data_E(data1_E),
        .rs2_data_E(data2_E),
        .opcode_E(opcode_E),
        .funct3_E(funct3_E),
        .zero_flag_E(zero_flag_E),
        .Branch_E(Branch_E),
        .Jump_E(Jump_E),
        .pc_sel(pc_sel),
        .next_pc(branched_address)
    );

    wire result_E, zero_flag_E;

    execute_top u1_execute_top (
        .pc_E(pc_E),
        .data1_E(data1_E),
        .data2_E(data2_E),
        .immediate_E(immediate_E),
        .ALUControl_E(ALUControl_E),
        .ALUSrc_E(ALUSrc_E),
        .operandA_sel_E(operandA_sel_E),
        .result_E(result_E), 
        .zero_flag_E(zero_flag_E) 
    );

    wire reg_write_M, MemRead_M, MemWrite_M;
    wire [1:0] WriteBackSel_M;
    wire [31:0] alu_result_M, pc_M, rs2_data_M;
    wire [4:0] rd_M, rs1_M, rs2_M;
    wire [2:0] funct3_M;

    EX_MEM u1_EX_MEM (
        .clk(clk),
        .reset(reset),
        .alu_result_E(result_E),
        .rs2_data_E(data2_E),
        .pc_E(pc_E),
        .rd_E(rd_E),
        .rs1_E(rs1_E),
        .rs2_E(rs2_E),
        .RegWrite_E(reg_write_E),
        .MemRead_E(MemoryRead_E),
        .MemWrite_E(MemoryWrite_E),
        .WriteBackSel_E(WriteBackSel_E),
        .funct3_E(funct3_E),

        // output ports for EX_MEM stage
        .alu_result_M(alu_result_M),
        .rs2_data_M(rs2_data_M),
        .pc_M(pc_M),
        .rd_M(rd_M),
        .rs1_M(rs1_M),
        .rs2_M(rs2_M),
        .RegWrite_M(RegWrite_M),
        .MemRead_M(MemRead_M),
        .MemWrite_M(MemWrite_M),
        .WriteBackSel_M(WriteBackSel_M),
        .funct3_M(funct3_M)
    );

    wire [31:0] read_data_M;

    data_memory u1_data_memory (
        .clk(clk),
        .MemoryRead_M(MemRead_M),
        .MemoryWrite_M(MemWrite_M),
        .address_M(alu_result_M),
        .write_data_M(rs2_data_M),
        .funct3_M(funct3_M),
        .read_data(read_data_M)
    );

    wire [31:0] alu_result_W, mem_data_W, pc_W;
    wire [4:0] rd_W;
    wire RegWrite_W;
    wire [1:0] WriteBackSel_W;

    MEM_WB u1_MEM_WB (
        .clk(clk),
        .reset(reset),
        .alu_result_M(alu_result_M),
        .mem_data_M(read_data_M),
        .rd_M(rd_M),
        .RegWrite_M(RegWrite_M),
        .WriteBackSel_M(WriteBackSel_M),
        .pc_M(pc_M),

        // output ports for MEM_WB stage
        .pc_W(pc_W),
        .alu_result_W(alu_result_W),
        .mem_data_W(mem_data_W),
        .rd_W(rd_W),
        .RegWrite_W(RegWrite_W),
        .WriteBackSel_W(WriteBackSel_W)
    );

    writeback_mux u1_writeback_mux (
        .write_back_sel_W(WriteBackSel_W),
        .alu_result_W(alu_result_W),
        .read_data_W(mem_data_W),
        .pc_W(pc_W),
        .write_back_data(write_data_W)
    );

endmodule