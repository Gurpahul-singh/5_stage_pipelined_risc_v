module pc (
    input clk, reset,PCWrite,
    input [31:0] next_address,
    output reg [31:0] pc
);

always@(posedge clk or posedge reset) begin
    if(reset) pc<=32'b0;
    else if(PCWrite) pc<=next_address;
end
    
endmodule
