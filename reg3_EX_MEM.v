module EX_MEM(

    input clk,
    input reset,

    input [31:0] alu_result_E,
    
    input [31:0] rs2_data_E,  // this is the data to be written to memory in case of a store instruction
    // input [31:0] branch_target_E,
    input [31:0] pc_E,
    
    // input zero_E,

    input [4:0] rd_E,rs1_E,rs2_E, // this is the address of the register to be written in case of 
                      // every instruction that writes to the register file

    input RegWrite_E,
    input MemRead_E,
    input MemWrite_E,
    input [1:0] WriteBackSel_E,
    input [2:0] funct3_E,

    output reg [31:0] alu_result_M,pc_M,
    output reg [31:0] rs2_data_M,
    // output reg [31:0] branch_target_M,

    // output reg zero_M,

    output reg [4:0] rd_M,rs1_M,rs2_M,

    output reg RegWrite_M,
    output reg MemRead_M,
    output reg MemWrite_M,
    output reg [1:0] WriteBackSel_M,
    output reg [2:0] funct3_M
);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        alu_result_M <= 0;
        rs2_data_M <= 0;
        // branch_target_M <= 0;

        // zero_M <= 0;

        rd_M <= 0;
        rs1_M <= 0;
        rs2_M <= 0;

        RegWrite_M <= 0;
        MemRead_M <= 0;
        MemWrite_M <= 0;
        WriteBackSel_M <= 0;
        pc_M <= 0;
    end
    else
    begin
        alu_result_M <= alu_result_E;
        rs2_data_M <= rs2_data_E;
        pc_M <= pc_E;
        // branch_target_M <= branch_target_E;

        // zero_M <= zero_E;

        rd_M <= rd_E;
        rs1_M <= rs1_E;
        rs2_M <= rs2_E;

        RegWrite_M <= RegWrite_E;
        MemRead_M <= MemRead_E;
        MemWrite_M <= MemWrite_E;
        WriteBackSel_M <= WriteBackSel_E;
    end
end

endmodule