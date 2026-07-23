module IF_ID (
    input clk,
    input reset,
    input [31:0] instruction_F,
    input [31:0] pc_F,
    input IF_ID_Write,
    input IF_ID_Flush,
    output reg [31:0] instruction_D,
    output reg [31:0] pc_D
);

    always @(posedge clk or posedge reset) begin
        if (reset || IF_ID_Flush) begin
            instruction_D <= 32'b0;
            pc_D <= 32'b0;
        end else if (IF_ID_Write) begin
            instruction_D <= instruction_F;
            pc_D <= pc_F;
        end
    end

endmodule