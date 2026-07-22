// module instruction_memory(
//     input [31:0] address,
//     output reg [31:0] instruction
// );

// always @(*) begin
//     case(address)

//         // x2 = 45
//         32'h00000000: instruction = 32'h02D00113; // addi x2,x0,45

//         // x3 = 80
//         32'h00000004: instruction = 32'h05000193; // addi x3,x0,80

//         // x4 = x2 + x3
//         32'h00000008: instruction = 32'h00310233; // add x4,x2,x3

//         // MEM[8] = x4
//         32'h0000000C: instruction = 32'h00402423; // sw x4,8(x0)

//         // x5 = 100
//         32'h00000010: instruction = 32'h06400293; // addi x5,x0,100

//         // if (100 < sum) goto GREATER
//         32'h00000014: instruction = 32'h0042C863; // blt x5,x4,GREATER

//         // LESS:
//         // x6 = 100 - sum
//         32'h00000018: instruction = 32'h40428333; // sub x6,x5,x4

//         // MEM[12] = x6
//         32'h0000001C: instruction = 32'h00602623; // sw x6,12(x0)

//         // Jump to END
//         32'h00000020: instruction = 32'h00C0006F; // jal x0,END

//         // GREATER:
//         // x6 = sum - 100
//         32'h00000024: instruction = 32'h40520333; // sub x6,x4,x5

//         // MEM[12] = x6
//         32'h00000028: instruction = 32'h00602623; // sw x6,12(x0)

//         // END
//         32'h0000002C: instruction = 32'h00000013; // nop

//         default: instruction = 32'h00000013; // nop

//     endcase
// end

// endmodule








// **********************************************



// this is for the pipelined architecture without forwarding and hazard detection unit. The program is designed to test the pipeline's ability to handle data hazards by introducing NOPs (no operation) where necessary. The program performs a series of arithmetic operations and conditional branches, storing results in memory and registers. The expected behavior is that the pipeline will correctly execute the instructions while managing hazards through stalling or inserting NOPs as needed.

module instruction_memory(
    input  [31:0] address,
    output [31:0] instruction
);

    reg [31:0] memory [0:255];
    integer i;
    
    // initial begin
    //     // Program:
    //     // addi x1, x0, 5
    //     // nop
    //     // nop
    //     // nop
    //     // addi x2, x1, 10
    //     // nop
    //     // nop
    //     // nop
    //     // add x3, x1, x2

    //     memory[0] = 32'h00500093; // addi x1, x0, 5
    //     memory[1] = 32'h00000013; // nop
    //     memory[2] = 32'h00000013; // nop
    //     memory[3] = 32'h00000013; // nop

    //     memory[4] = 32'h00A08113; // addi x2, x1, 10
    //     memory[5] = 32'h00000013; // nop
    //     memory[6] = 32'h00000013; // nop
    //     memory[7] = 32'h00000013; // nop

    //     memory[8] = 32'h002081B3; // add x3, x1, x2

    //     // Fill remaining memory with NOPs
        
    //     for (i = 9; i < 256; i = i + 1)
    //         memory[i] = 32'h00000013;
    // end

    // assign instruction = memory[address[31:2]];

initial begin
    $readmemh("program.hex", memory);
end
assign instruction = memory[address[31:2]];
endmodule