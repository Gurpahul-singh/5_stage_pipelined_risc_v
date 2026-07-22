module alusrc_mux (
    input ALUSrc_E,
    input [31:0] data2_E,
    input [31:0] immediate_E,
    input [31:0] alu_result_M,
    input [31:0] write_data_W,
    input [1:0] forwardB,
    output [31:0] rs2_forwarded,
    output [31:0] operandB
);

wire [31:0] operandB1;
assign rs2_forwarded = operandB1;
assign operandB = (ALUSrc_E) ? immediate_E : operandB1;
assign operandB1 = (forwardB == 2'b01) ? alu_result_M :
                  (forwardB == 2'b10) ? write_data_W : data2_E;
endmodule