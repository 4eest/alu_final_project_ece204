module ALU(

	input logic reset_n,
	input logic [7:0] inputA,
	input logic [7:0] inputB,
	
	input logic enable_or,
	input logic enable_xor,
	input logic enable_and,
	input logic enable_nand,
	input logic enable_add,
	input logic enable_subtract,

	input logic [7:0] result,
	output logic [7:0] result_or,
	output logic [7:0] result_xor,
	output logic [7:0] result_and,
	output logic [7:0] result_nand,
	output logic [7:0] result_add,
	output logic [7:0] result_subtract,
	output logic overflow
);




alu_or OR_instance(
	.A(inputA),
	.B(inputB),
	.enable_or(enable_or),
	.result_or(result_or),
	.overflow(overflow)
);



alu_xor XOR_instance(
	.A(inputA),
	.B(inputB),
	.enable_xor(enable_xor),
	.result_xor(result_xor),
	.overflow(overflow)
);


alu_and AND_instance(
	.A(inputA),
	.B(inputB),
	.enable_and(enable_and),
	.result_and(result_and),
	.overflow(overflow)
);


alu_nand NAND_instance(
	.A(inputA),
	.B(inputB),
	.enable_nand(enable_nand),
	.result_nand(result_nand),
	.overflow(overflow)
);


alu_add ADD_instance(
	.A(inputA),
	.B(inputB),
	.enable_add(enable_add),
	.result_add(result_add),
	.overflow(overflow)
);


alu_subtract SUB_instance(
	.A(inputA),
	.B(inputB),
	.enable_subtract(enable_subtract),
	.result_subtract(result_subtract),
	.overflow(overflow)
);


endmodule

