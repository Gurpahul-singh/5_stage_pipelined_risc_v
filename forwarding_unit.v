module forwarding_unit (
    input [4:0] rs1_E, rs2_E, rd_M, rd_W,
    input RegWrite_M, RegWrite_W,
    output [1:0] forwardA, forwardB
);

    assign forwardA = (RegWrite_M && (rd_M != 0) && (rd_M == rs1_E)) ? 2'b01 :
                      (RegWrite_W && (rd_W != 0) && (rd_W == rs1_E)) ? 2'b10 : 2'b00;


    assign forwardB = (RegWrite_M && (rd_M != 0) && (rd_M == rs2_E)) ? 2'b01 :
                      (RegWrite_W && (rd_W != 0) && (rd_W == rs2_E)) ? 2'b10 : 2'b00;

endmodule

// 00 means normal reg value passed i.e. the decoded stage registers are used
// 01 means the value from the MEM stage is forwarded to the EX stage
// 10 means the value from the WB stage is forwarded to the EX stage