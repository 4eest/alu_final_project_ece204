module Top_Level(
	input logic reset_n,
	input logic [7:0] sw,
	output logic [6:0] seg0,
	output logic [6:0] seg1

);


logic [7:0] inputA = 0;
logic [7:0] inputB = 0;
logic [2:0] opcode = 0;
logic [7:0] result = 0;
logic [7:0] result_or = 0;
logic [7:0] result_xor = 0;
logic [7:0] result_and = 0;
logic [7:0] result_nand = 0;
logic [7:0] result_add = 0;
logic [7:0] result_subtract = 0;
logic overflow = 0;
//more wires needed for parser -> sevensegdecoder
logic [3:0] ones_place;
logic [3:0] tens_place;


// count A

// count B

Opcode decoder(

	.sw(sw),
	.enable_or(enable_or),
	.enable_xor(enable_xor),
	.enable_and(enable_and),
	.enable_nand(enable_nand),
	.enable_add(enable_add),
	.enable_subtract(enable_subtract)
);

ALU Calculator(

	.inputA(inputA),
	.inputB(inputB),
	.result(result),
	.result_or(result_or),
	.result_xor(result_xor),
	.result_add(result_add),
	.result_nand(result_nand),
	.result_add(result_add),
	.result_subtract(result_subtract),
	.overflow(overflow)

);



// parser
Parser ALU_parser(
	.count(result),
	.overflow(overflow),
	.ones(ones_place),
	.tens(tens_place)
);


SevenSegmentDecode Hex0(
	.digit(ones_place),
	.segments(seg0)
);

SevenSegmentDecode Hex1(
	.digit(tens_place),
	.segments(seg1)
);




endmodule