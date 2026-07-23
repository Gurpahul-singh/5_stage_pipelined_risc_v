module data_memory (
    input clk,MemoryRead_M,MemoryWrite_M,
    input [31:0] address_M, // this is in alu result 
    input [31:0] write_data_M, // this is from the register source 2 data
    input [2:0] funct3_M,
    output reg [31:0] read_data
);
    
    integer i;

reg [31:0] memory [0:255]; // 256 words of 32-bit memory

always @(posedge clk) begin
    if (MemoryWrite_M) begin
        case (funct3_M)
            3'b000: begin // Store Byte
                case (address_M[1:0])
                    2'b00: memory[address_M[31:2]][7:0] <= write_data_M[7:0];
                    2'b01: memory[address_M[31:2]][15:8] <= write_data_M[7:0];
                    2'b10: memory[address_M[31:2]][23:16] <= write_data_M[7:0];
                    2'b11: memory[address_M[31:2]][31:24] <= write_data_M[7:0];
                endcase
            end
            3'b001: begin// Store Halfword
                case (address_M[1]) 
                    1'b0 : memory[address_M[31:2]][15:0] <= write_data_M[15:0];
                    1'b1 : memory[address_M[31:2]][31:16] <= write_data_M[15:0];
                endcase
            end 
            3'b010: memory[address_M[31:2]] <= write_data_M; // Store Word
            // Do nothing for unsupported funct3 values
        endcase
    end
end

always @(*) begin
    read_data = 32'b0; // Default value when not reading
    if (MemoryRead_M) begin
        case (funct3_M)
            3'b000 : read_data =(address_M[1:0] == 2'b00) ? {{24{memory[address_M[31:2]][7]}},memory[address_M[31:2]][7:0]} : 
                                (address_M[1:0] == 2'b01) ? {{24{memory[address_M[31:2]][15]}},memory[address_M[31:2]][15:8]} : 
                                (address_M[1:0] == 2'b10) ? {{24{memory[address_M[31:2]][23]}},memory[address_M[31:2]][23:16]} :
                                {{24{memory[address_M[31:2]][31]}},memory[address_M[31:2]][31:24]}; // Load byte, sign-extend

            3'b001 : read_data =(address_M[1] == 1'b0) ? 
                                {{16{memory[address_M[31:2]][15]}},memory[address_M[31:2]][15:0]} : 
                                {{16{memory[address_M[31:2]][31]}},memory[address_M[31:2]][31:16]}; // Load halfword, sign-extend

            3'b010 : read_data = memory[address_M[31:2]];  // Load word     
            
            3'b100 : read_data =(address_M[1:0] == 2'b00) ? {{24{1'b0}},memory[address_M[31:2]][7:0]} : 
                                (address_M[1:0] == 2'b01) ? {{24{1'b0}},memory[address_M[31:2]][15:8]} : 
                                (address_M[1:0] == 2'b10) ? {{24{1'b0}},memory[address_M[31:2]][23:16]} :
                                {{24{1'b0}},memory[address_M[31:2]][31:24]};  // Load byte, zero-extend

            3'b101 : read_data =(address_M[1] == 1'b0) ? 
                                {{16{1'b0}},memory[address_M[31:2]][15:0]} : 
                                {{16{1'b0}},memory[address_M[31:2]][31:16]}; // Load halfword, zero-extend
        endcase
    end
end

endmodule


// for store instructions
// Instruction	funct3	Meaning
// SB	000	Store Byte
// SH	001	Store Halfword
// SW	010	Store Word


// for load instruction
// | Instruction | funct3   | Operation                  |
// | ----------- | -------- | -------------------------- |
// | **LB**      | `3'b000` | Load byte, sign-extend     |
// | **LH**      | `3'b001` | Load halfword, sign-extend |
// | **LW**      | `3'b010` | Load word                  |
// | **LBU**     | `3'b100` | Load byte, zero-extend     |
// | **LHU**     | `3'b101` | Load halfword, zero-extend |
