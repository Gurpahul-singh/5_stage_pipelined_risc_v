module ID_EX (
    input clk, reset,

    input [31:0] data1_D, data2_D, immediate_D, pc_D,
    input [3:0] ALUControl_D,
    input [1:0] WriteBackSel_D,
    input operandA_sel_D, ALUSrc_D, MemoryRead_D, MemoryWrite_D, Branch_D, Jump_D,reg_write_D,
    input [2:0] funct3_D,
    input [6:0] opcode_D,
    input [4:0] rs1_D,rs2_D,rd_D,
    // input [31:0] rs2_data_D,

    output reg [31:0] data1_E, data2_E, immediate_E, pc_E,
    output reg [3:0] ALUControl_E,
    output reg [1:0] WriteBackSel_E,
    output reg operandA_sel_E, ALUSrc_E, MemoryRead_E, MemoryWrite_E, Branch_E, Jump_E,reg_write_E,
    output reg [2:0] funct3_E,
    output reg [6:0] opcode_E,
    output reg [4:0] rd_E,rs1_E,rs2_E,
    // output reg [31:0] rs2_data_E
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin

            data1_E <= 32'b0;
            data2_E <= 32'b0;
            immediate_E <= 32'b0;

            pc_E <= 32'b0;
            ALUControl_E <= 4'b0;
            WriteBackSel_E <= 2'b0;
            operandA_sel_E <= 1'b0;
            ALUSrc_E <= 1'b0;
            MemoryRead_E <= 1'b0;
            MemoryWrite_E <= 1'b0;
            Branch_E <= 1'b0;
            Jump_E <= 1'b0;
            reg_write_E <= 1'b0;
            funct3_E <= 3'b0;
            opcode_E <= 7'b0;
            rd_E <= 5'b0;
            rs1_E <= 5'b0;
            rs2_E <= 5'b0;
            // rs2_data_E <= 32'b0;

            

        end else begin
            data1_E <= data1_D;
            data2_E <= data2_D;
            immediate_E <= immediate_D;

            pc_E <= pc_D;
            ALUControl_E <= ALUControl_D;
            WriteBackSel_E <= WriteBackSel_D;
            operandA_sel_E <= operandA_sel_D;
            ALUSrc_E <= ALUSrc_D;
            MemoryRead_E <= MemoryRead_D;
            MemoryWrite_E <= MemoryWrite_D;
            Branch_E <= Branch_D;
            Jump_E <= Jump_D;
            reg_write_E <= reg_write_D;

            funct3_E <= funct3_D;
            opcode_E <= opcode_D;
            rd_E <= rd_D;
            rs1_E <= rs1_D;
            rs2_E <= rs2_D;
            // rs2_data_E <= rs2_data_D;
        end
    end
endmodule