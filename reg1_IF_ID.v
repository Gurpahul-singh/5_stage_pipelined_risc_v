module IF_ID (
    input clk,
    input reset,
    input [31:0] instruction_F,
    input [31:0] pc_F,
    output reg [31:0] instruction_D,
    output reg [31:0] pc_D
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instruction_D <= 32'b0;
            pc_D <= 32'b0;
        end else begin
            instruction_D <= instruction_F;
            pc_D <= pc_F;
        end
    end

endmodule