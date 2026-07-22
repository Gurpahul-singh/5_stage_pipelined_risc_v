`timescale 1ns/1ps

module riscv_top_tb;

    reg clk;
    reg reset;

    wire [31:0] pc,instruction;

    // DUT
    riscv_top dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction)
    );

    // Clock generation (10 ns period)
    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end
    initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, riscv_top_tb);

    #500;
    $finish;
end

initial begin
#400;
$display("\n===== FINAL MEMORY CONTENT =====");
$display("MEM[8]  = %0d", dut.memory_unit.memory[2]);
$display("MEM[12] = %0d", dut.memory_unit.memory[3]);

$finish;
end
    

    // Monitoring
initial begin
$display("Time\tReset\tPC");
// $monitor(
// "t=%0t Reset=%b PC=%h Instr=%h x2=%d x3=%d x4=%d x5=%d x6=%d",
// $time,
// dut.reset,
// dut.pc,
// dut.instruction,
// dut.decode_unit.u_register_file.registers[2],
// dut.decode_unit.u_register_file.registers[3],
// dut.decode_unit.u_register_file.registers[4],
// dut.decode_unit.u_register_file.registers[5],
// dut.decode_unit.u_register_file.registers[6]
// // );
// $monitor(
// "t=%0t PC=%h Instr=%h | rd_D=%0d rd_E=%0d rd_M=%0d rd_W=%0d | RegD=%b RegE=%b dut.decode_unit.u_register_file.RegWrite_W=%b RegW=%b | ALU_W=%0d WB=%0d x2=%0d",
// $time,
// dut.pc,
// dut.instruction,

// dut.rd_D,
// dut.rd_E,
// dut.rd_M,
// dut.rd_W,

// dut.Reg_write_D,
// dut.reg_write_E,
// dut.reg_write_M,
// dut.RegWrite_W,

// dut.alu_result_W,
// dut.write_data_W,

// dut.decode_unit.u_register_file.registers[2]
// );
// end
$monitor(
"t=%0t regE=%b regM=%b regW=%b rdW=%0d WB=%0d x2=%0d",
$time,
dut.reg_write_E,
dut.reg_write_M,
dut.RegWrite_W,
dut.rd_W,
dut.write_data_W,
dut.decode_unit.u_register_file.registers[2]
);
end
always @(posedge clk) begin
    if (dut.MemWrite_M) begin
        $display(
            "STORE addr=%0d data=%0d funct3=%b",
            dut.alu_result_M,
            dut.rs2_data_M,
            dut.funct3_M
        );
    end
end
endmodule