module execute_top (
    input [31:0] pc_E,data1_E,data2_E,immediate_E,
    input [3:0] ALUControl_E,
    input ALUSrc_E,operandA_sel_E,
    output [31:0] result_E,
    output zero_flag_E
);
    
wire [31:0] operandA,operandB;

operandA_mux u_operandA_mux (
    .operandA_sel_E(operandA_sel_E),
    .pc_E(pc_E),
    .rs1_data_E(data1_E),
    .operandA(operandA)
);

alusrc_mux u_alusrc_mux (
    .ALUSrc(ALUSrc_E),
    .reg_data(data2_E),
    .immediate(immediate_E),
    .operandB(operandB)
);

alu u_alu (
    .operandA(operandA),
    .operandB(operandB),
    .ALUControl(ALUControl_E),
    .result(result_E),
    .zero_flag(zero_flag_E)
);

endmodule