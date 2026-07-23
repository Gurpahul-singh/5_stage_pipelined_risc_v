module control_unit (
    input [31:0] instruction_D,
    output reg RegWrite_D,ALUSrc_D,MemoryRead_D,MemoryWrite_D,Branch_D,Jump_D,operandA_sel_D,
    output reg [2:0] ImmSel_D,ALUOp_D,
    output reg [1:0] WriteBackSel_D
);

    wire [6:0] opcode;
    assign opcode = instruction_D[6:0];

    always @(*) begin
        operandA_sel_D = 0; 
        case (opcode)
            7'b0110011: begin // R-type
                RegWrite_D = 1; ALUSrc_D = 0; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b111; ALUOp_D = 3'b010; WriteBackSel_D = 2'b00;
            end
            7'b0010011: begin // I-type
                RegWrite_D = 1; ALUSrc_D = 1; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b000; ALUOp_D = 3'b011; WriteBackSel_D = 2'b00;
            end
            7'b0000011: begin // Load
                RegWrite_D = 1; ALUSrc_D = 1; MemoryRead_D = 1; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b000; ALUOp_D = 3'b000; WriteBackSel_D = 2'b01;
            end
            7'b0100011: begin // Store
                RegWrite_D = 0; ALUSrc_D = 1; MemoryRead_D = 0; MemoryWrite_D = 1; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b001; ALUOp_D = 3'b000; WriteBackSel_D = 2'b11;
            end
            7'b1100011: begin // Branch
                RegWrite_D = 0; ALUSrc_D = 0; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 1; Jump_D = 0;
                ImmSel_D = 3'b010; ALUOp_D = 3'b001; WriteBackSel_D = 2'b11;
            end
            7'b1101111: begin // JAL
                RegWrite_D = 1; ALUSrc_D = 0; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 1;
                ImmSel_D = 3'b100; ALUOp_D = 3'b111; WriteBackSel_D = 2'b10;
            end
            7'b1100111: begin // JALR
                RegWrite_D = 1; ALUSrc_D = 1; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 1;
                ImmSel_D = 3'b000; ALUOp_D = 3'b000; WriteBackSel_D = 2'b10;
            end
            7'b0110111: begin // LUI
                RegWrite_D = 1; ALUSrc_D = 1; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b011; ALUOp_D = 3'b100; WriteBackSel_D = 2'b00;
            end
            7'b0010111: begin // AUIPC
                RegWrite_D = 1; ALUSrc_D = 1; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b011; ALUOp_D = 3'b101; WriteBackSel_D = 2'b00; operandA_sel_D = 1;
            end
            default: begin // Unsupported instructions
                RegWrite_D = 0; ALUSrc_D = 0; MemoryRead_D = 0; MemoryWrite_D = 0; Branch_D = 0; Jump_D = 0;
                ImmSel_D = 3'b000; ALUOp_D = 3'b111; WriteBackSel_D = 2'b00;
            end
        endcase
    end
endmodule

// WriteBackSel	Source
// 2'b00	ALU Result
// 2'b01	Memory Data
// 2'b10	PC + 4
// 2'b11	nothing



// ImmSel	Immediate Type
// 3'b000	I-Type
// 3'b001	S-Type
// 3'b010	B-Type
// 3'b011	U-Type
// 3'b100	J-Type
// 3'b101	Reserved
// 3'b110	Reserved
// 3'b111	Reserved


// ALUOp (3 bits)
// ALUOp	Meaning
// 3'b000	Load/Store Address Calculation
// 3'b001	Branch Comparison
// 3'b010	R-Type
// 3'b011	I-Type ALU
// 3'b100	LUI
// 3'b101	AUIPC
// 3'b110	Reserved
// 3'b111	Reserved