module operandA_mux (
    input operandA_sel_E,
    input [31:0] pc_E, rs1_data_E,alu_result_M,write_data_W,
    input [1:0] forwardA,
    output [31:0] rs1_forwarded,
    output [31:0] operandA
);

wire [31:0] operandA1;
assign operandA = (operandA_sel_E) ? pc_E : operandA1;
assign operandA1 = (forwardA == 2'b01) ? alu_result_M :
                  (forwardA == 2'b10) ? write_data_W : rs1_data_E;
assign rs1_forwarded = operandA1;

endmodule