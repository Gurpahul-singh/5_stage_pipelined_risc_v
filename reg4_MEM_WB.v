module MEM_WB(

    input clk,
    input reset,

    input [31:0] alu_result_M,
    input [31:0] mem_data_M,

    input [4:0] rd_M,

    input RegWrite_M,
    input [1:0] WriteBackSel_M,
    input [31:0] pc_M,

    output reg [31:0] mem_data_W,
    output reg [31:0] alu_result_W,

    output reg [4:0] rd_W,

    output reg RegWrite_W,
    output reg [1:0] WriteBackSel_W
    output reg [31:0] pc_W

);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        mem_data_W <= 0;
        alu_result_W <= 0;

        rd_W <= 0;

        RegWrite_W <= 0;
        WriteBackSel_W <= 0;
    end
    else
    begin
        mem_data_W <= mem_data_M;
        alu_result_W <= alu_result_M;

        rd_W <= rd_M;

        RegWrite_W <= RegWrite_M;
        WriteBackSel_W <= WriteBackSel_M;
    end
end

endmodule
