module immediate_generator (
    input [31:0] instruction_D,
    input [2:0] ImmSel_D,
    output reg [31:0] immediate_D
);

    always @(*) begin
        case (ImmSel_D)
            3'b000: immediate_D = {{20{instruction_D[31]}}, instruction_D[31:20]}; // I-type immediate
            3'b001: immediate_D = {{20{instruction_D[31]}}, instruction_D[31:25], instruction_D[11:7]}; // S-type immediate
            3'b010: immediate_D = {{19{instruction_D[31]}}, instruction_D[31], instruction_D[7], instruction_D[30:25], instruction_D[11:8],1'b0}; // B-type immediate
            3'b011: immediate_D = {instruction_D[31:12], 12'b0}; // U-type immediate
            3'b100: immediate_D = {{11{instruction_D[31]}}, instruction_D[31], instruction_D[19:12], instruction_D[20], instruction_D[30:21],1'b0}; // J-type immediate
            default: immediate_D = 32'b0; // Default case for unsupported opcodes
        endcase
    end

endmodule
