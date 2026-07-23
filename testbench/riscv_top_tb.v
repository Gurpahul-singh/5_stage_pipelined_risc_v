// `timescale 1ns/1ps

// module riscv_top_tb;

//     reg clk;
//     reg reset;

//     wire [31:0] pc,instruction;

//     // DUT
//     riscv_top dut (
//         .clk(clk),
//         .reset(reset),
//         .pc(pc),
//         .instruction(instruction)
//     );

//     // Clock generation (10 ns period)
//     initial begin 
//         clk = 0;
//         forever #5 clk = ~clk;
//     end

//     // Reset generation
//     initial begin
//         reset = 1;
//         #20;
//         reset = 0;
//     end
//     initial begin
//     $dumpfile("top.vcd");
//     $dumpvars(0, riscv_top_tb);

//     #500;
//     $finish;
// end

// initial begin
// #400;
// $display("\n===== FINAL MEMORY CONTENT =====");
// $display("MEM[8]  = %0d", dut.memory_unit.memory[2]);
// $display("MEM[12] = %0d", dut.memory_unit.memory[3]);

// $finish;
// end
    

//     // Monitoring
// initial begin
// $display("Time\tReset\tPC");

// $monitor(
// "t=%0t regE=%b regM=%b regW=%b rdW=%0d WB=%0d x2=%0d",
// $time,
// dut.reg_write_E,
// dut.reg_write_M,
// dut.RegWrite_W,
// dut.rd_W,
// dut.write_data_W,
// dut.decode_unit.u_register_file.registers[2]
// );
// end

// always @(posedge clk) begin
//     if (dut.MemWrite_M) begin
//         $display(
//             "STORE addr=%0d data=%0d funct3=%b",
//             dut.alu_result_M,
//             dut.rs2_data_M,
//             dut.funct3_M
//         );
//     end
// end
// endmodule



`timescale 1ns/1ps

module riscv_top_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    //============================================================
    // DUT
    //============================================================
    riscv_top dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction)
    );

    //============================================================
    // Clock Generation (100 MHz)
    //============================================================
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    //============================================================
    // Reset
    //============================================================
    initial begin
        reset = 1'b1;
        #20;
        reset = 1'b0;
    end

    //============================================================
    // Waveform Dump
    //============================================================
    initial begin
        $dumpfile("top.vcd");
        $dumpvars(0, riscv_top_tb);
    end

    //============================================================
    // Monitor Execution
    //============================================================
    initial begin
        $display("---------------------------------------------------------------");
        $display(" Time     PC         Instruction");
        $display("---------------------------------------------------------------");

        $monitor("%5dns   %08h   %08h",
                 $time,
                 pc,
                 instruction);
    end

    //============================================================
    // Register Writeback Monitor
    //============================================================
    always @(posedge clk) begin
        if (dut.RegWrite_W && (dut.rd_W != 0))
            $display("[%0dns] WB : x%0d <= %0d (0x%08h)",
                $time,
                dut.rd_W,
                dut.write_data_W,
                dut.write_data_W);
    end

    //============================================================
    // Memory Store Monitor
    //============================================================
    always @(posedge clk) begin
        if (dut.MemWrite_M)
            $display("[%0dns] STORE : MEM[%0d] <= %0d",
                $time,
                dut.alu_result_M,
                dut.rs2_data_M);
    end

    //============================================================
    // End Simulation
    //============================================================
    integer i;

    initial begin

        // Adjust depending on your program length
        #500;

        $display("\n================ REGISTER FILE ================");
        for(i=0;i<32;i=i+1)
            $display("x%-2d = %0d (0x%08h)",
                i,
                dut.decode_unit.u_register_file.registers[i],
                dut.decode_unit.u_register_file.registers[i]);

        $display("\n================ DATA MEMORY ==================");

        for(i=0;i<16;i=i+1)
            $display("MEM[%0d] = %0d",
                i*4,
                dut.memory_unit.memory[i]);

        $display("\n============= Simulation Finished =============");

        $finish;
    end

endmodule