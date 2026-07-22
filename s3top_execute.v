module execute_top (
    input [31:0] pc_E,data1_E,data2_E,immediate_E,
    input [3:0] ALUControl_E,
    input ALUSrc_E,operandA_sel_E,
    input [1:0] forwardA,forwardB,
    input [31:0] alu_result_M,write_data_W,
    output [31:0] rs1_forwarded,
    output [31:0] rs2_forwarded,
    output [31:0] result_E,
    output zero_flag_E
);
    
wire [31:0] operandA,operandB;

operandA_mux u_operandA_mux (
    .operandA_sel_E(operandA_sel_E),
    .pc_E(pc_E),
    .rs1_data_E(data1_E),
    .alu_result_M(alu_result_M),
    .write_data_W(write_data_W),
    .forwardA(forwardA),
    .rs1_forwarded(rs1_forwarded),
    .operandA(operandA)
);

alusrc_mux u_alusrc_mux (
    .ALUSrc_E(ALUSrc_E),
    .data2_E(data2_E),
    .immediate_E(immediate_E),
    .alu_result_M(alu_result_M),
    .write_data_W(write_data_W),
    .forwardB(forwardB),
    .rs2_forwarded(rs2_forwarded),
    .operandB(operandB)
);

alu u_alu (
    .operandA(operandA),
    .operandB(operandB),
    .ALUControl_E(ALUControl_E),
    .result_E(result_E),
    .zero_flag_E(zero_flag_E)
);

    
endmodule