module opcode(

	input logic [2:0] sw,
	input logic enable,	
	output logic [7:0] opcode_decode


);

;

always_comb begin
	
	opcode_decode = 0;
	
	case(enable)

		3'b000: opcode_decode     = 8'b10000000;
      3'b001: opcode_decode = 8'b01000000;
      3'b010: opcode_decode      = 8'b00100000;
      3'b011: opcode_decode      = 8'b00010000;
		3'b100: opcode_decode       = 8'b00001000;
		3'b101: opcode_decode     = 8'b00000100;
      3'b110: opcode_decode     = 8'b00000010;
      3'b111: opcode_decode     = 8'b00000001;

		
		default: begin
			opcode_decode      = 0;

      end
	endcase
end


endmodule