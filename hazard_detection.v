module hazard_detection (
    input [4:0] rd_E,rs1_D,rs2_D,
    input MemoryRead_E,
    output reg PCWrite, IF_ID_Write,ID_EX_Flush
);
    always@(*) begin
        if(MemoryRead_E && (rd_E != 0) && ((rd_E == rs1_D) || (rd_E == rs2_D))) begin
            PCWrite = 0;
            IF_ID_Write = 0;
            ID_EX_Flush = 1;
        end
        else begin
            PCWrite = 1;
            IF_ID_Write = 1;
            ID_EX_Flush = 0;
        end
    end
endmodule