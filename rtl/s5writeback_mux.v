module writeback_mux (
    input [1:0] write_back_sel_W,
    input [31:0] alu_result_W,
    input [31:0] read_data_W,
    input [31:0] pc_W,
    output [31:0] write_back_data
);
    assign write_back_data = (write_back_sel_W == 2'b00) ? alu_result_W :
                             (write_back_sel_W == 2'b01) ? read_data_W :
                             (write_back_sel_W == 2'b10) ? (pc_W + 32'h00000004) : 32'b0;
                             
endmodule

// 00 -> ALU result
// 01 -> Memory read data
// 10 -> PC + 4
