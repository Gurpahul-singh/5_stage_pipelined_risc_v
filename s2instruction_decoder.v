module instruction_decoder (
    input [31:0] instruction_D,
    output [6:0] opcode_D,
    output [4:0] rs1_D,
    output [4:0] rs2_D,
    output [4:0] rd_D,
    output [2:0] funct3_D,
    output [6:0] funct7_D
);
    assign opcode_D = instruction_D[6:0];
    assign rd_D = instruction_D[11:7];
    assign funct3_D = instruction_D[14:12];
    assign rs1_D = instruction_D[19:15];
    assign rs2_D = instruction_D[24:20];
    assign funct7_D = instruction_D[31:25];

endmodule