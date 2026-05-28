module Top_Level(

	input logic save,
	input logic reset_n,
	input logic [7:0] data_in,
	input logic enable,

	output logic [6:0] seg0,
	output logic [6:0] seg1,
	output logic [6:0] seg2,
	output logic [7:0] LED_out

);


logic [7:0] inputA;
logic [7:0] inputB;
logic [7:0] current_input;

logic [2:0] opcode;
assign opcode = current_input[2:0];

logic [7:0] result;
logic overflow;
assign LED_out = result;

//more wires needed for parser -> sevensegdecoder
logic [3:0] ones_place;
logic [3:0] tens_place;
logic [3:0] hundreds_place;

logic [7:0] opcode_decoded;

// Sequential Input Handling
inputHandler inputHandler(
	.data_in(data_in),
	.save(save),
	.reset_n(reset_n),
	.input_passthrough(current_input),
	.reg1(inputB),
	.reg2(inputA)
);

Opcode decoder(
	.sw(opcode),
	.enable(enable),
	.opcode_decode(opcode_decoded)
);

ALU Calculator(
	.reset_n(reset_n),
	.inputA(inputA),
	.inputB(inputB),
	.result(result),
	.overflow(overflow),
	.opcode(opcode_decoded)
	);

// parser
Parser ALU_parser(
	.count(result),
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

endmodule