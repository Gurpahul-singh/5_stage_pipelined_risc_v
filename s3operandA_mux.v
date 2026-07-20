module operandA_mux (
    input operandA_sel_E,
    input [31:0] pc_E, rs1_data_E,
    output [31:0] operandA
);
    
assign operandA = (operandA_sel_E) ? pc_E : rs1_data_E;

endmodule