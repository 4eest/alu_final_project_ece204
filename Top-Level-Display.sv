module Top_Level(

	input logic save,
	input logic [7:0] inputA,
	input logic [7:0] inputB,
	input logic reset_n,
	input logic [7:0] data_in,
	input logic enable,
	output logic [6:0] seg0,
	output logic [6:0] seg1,
	output logic [6:0] seg2,
	output logic [7:0] LED_out

);


logic [7:0] inputA = 0;
logic [7:0] inputB = 0;
logic [2:0] opcode = 0;
logic [7:0] result = 0;
logic overflow = 0;
//more wires needed for parser -> sevensegdecoder
logic [3:0] ones_place;
logic [3:0] tens_place;
logic [3:0] hundreds_place;
logic [7:0] opcode_decode;



Opcode decoder(

	.sw(sw),
	.opcode_decode(opcode_decode)
);

ALU Calculator(
	.reset_n(reset_n),
	.inputA(inputA),
	.inputB(inputB),
	.result(result),
	.overflow(overflow),
	.opcode(opcode_decode)
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

SevenSegmentDecode Hex2(
	.digit(hundreds_place),
	.segments(seg2)
);

assign LED_out = result;


endmodule