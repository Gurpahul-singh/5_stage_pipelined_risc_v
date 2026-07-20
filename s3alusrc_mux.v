module alusrc_mux (
    input ALUSrc_E,
    input [31:0] data2_E,
    input [31:0] immediate_E,
    output [31:0] operandB
);
    
assign operandB = (ALUSrc_E) ? immediate_E : data2_E;

endmodule