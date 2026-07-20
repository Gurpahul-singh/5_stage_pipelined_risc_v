module register_file ( 
    input clk , reset,
    input [4:0] rd_W,rs1_D,rs2_D,
    input RegWrite_W,
    input [31:0] write_data_W,
    output [31:0] rs1_data_D,rs2_data_D
);

    reg [31:0] registers [31:0];

    assign rs1_data_D = (rs1_D == 0) ? 32'b0 : registers[rs1_D];
    assign rs2_data_D = (rs2_D == 0) ? 32'b0 : registers[rs2_D];
    integer i;

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            for(i=0;i<32;i=i+1) begin
                registers[i] <= 32'b0;
            end
        end
        else if(RegWrite_W && rd_W!=5'b0) begin
            registers[rd_W]<=write_data_W;
        end
    end

endmodule