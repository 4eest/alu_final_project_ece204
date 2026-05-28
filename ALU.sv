module ALU(

	input logic reset_n,
	input logic [7:0] inputA,
	input logic [7:0] inputB,
	input logic [7:0] opcode,
	input logic enable,

	output logic [7:0] result,
	output logic overflow
);

logic [7:0] result_or;
logic [7:0] result_xor;
logic [7:0] result_and;
logic [7:0] result_nand;
logic [7:0] result_add;
logic [7:0] result_subtract;
logic [7:0] result_outA;
logic [7:0] result_outB;

logic enable_add;
logic enable_subtract;
logic enable_and;
logic enable_xor;
logic enable_or;
logic enable_outA;
logic enable_outB;
logic enable_nand;

logic overflow_add;
logic overflow_subtract;
logic overflow_and;
logic overflow_xor;
logic overflow_or;
logic overflow_outA;
logic overflow_outB;
logic overflow_nand;

assign {enable_add, enable_subtract, enable_and, enable_or, enable_xor, enable_outA, enable_outB, enable_nand} = enable ? opcode : 0;

alu_or OR_instance(
	.A(inputA),
	.B(inputB),
	.enable_or(enable_or),
	.result_or(result_or),
	.overflow(overflow_or)
);

alu_xor XOR_instance(
	.A(inputA),
	.B(inputB),
	.enable_xor(enable_xor),
	.result_xor(result_xor),
	.overflow(overflow_xor)
);


alu_and AND_instance(
	.A(inputA),
	.B(inputB),
	.enable_and(enable_and),
	.result_and(result_and),
	.overflow(overflow_and)
);

alu_nand NAND_instance(
	.A(inputA),
	.B(inputB),
	.enable_nand(enable_nand),
	.result_nand(result_nand),
	.overflow(overflow_nand)
);


alu_add ADD_instance(
	.A(inputA),
	.B(inputB),
	.enable_add(enable_add),
	.result_add(result_add),
	.overflow(overflow_add)
);


alu_subtract SUB_instance(
	.A(inputA),
	.B(inputB),
	.enable_subtract(enable_subtract),
	.result_subtract(result_subtract),
	.overflow(overflow_subtract)
);

alu_outA outA_instance(
	.A(inputA),
	.B(inputB),
	.enable_outA(enable_outA),
	.result_outA(result_outA),
	.overflow(overflow_outA)
);

alu_outB outB_instance(
	.A(inputA),
	.B(inputB),
	.enable_outB(enable_outB),
	.result_outB(result_outB),
	.overflow(overflow_outB)
);

assign result = result_add | result_and | result_subtract | result_nand | result_or | result_outA | result_outB | result_xor;
assign overflow = overflow_outA | overflow_outB | overflow_add | overflow_and | overflow_nand | overflow_or | overflow_xor | overflow_subtract; 

endmodule

