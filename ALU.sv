module ALU #(
    parameter int NUM_OPS      = 8,
    parameter int OPERAND_WIDTH = 8
)(
    input  logic                     reset_n,
    input  logic                     enable,
    input  logic [OPERAND_WIDTH-1:0] inputA,
    input  logic [OPERAND_WIDTH-1:0] inputB,
    input  logic [NUM_OPS-1:0]       opcode,
    output logic [OPERAND_WIDTH-1:0] result,
    output logic                     overflow
);
    assign result   = '0;
    assign overflow = 1'b0;

endmodule
