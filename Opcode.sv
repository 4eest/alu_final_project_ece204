module opcode(

	input logic [2:0] sw,
		
	output logic [7:0] enable_or,
	output logic [7:0] enable_xor,
	output logic [7:0] enable_and,
	output logic [7:0] enable_nand,
	output logic [7:0] enable_add,
	output logic [7:0] enable_subtract


);

logic enable = 1;

always_comb begin
	
	enable_or = 0;
   enable_xor = 0;
   enable_and = 0;
	enable_nand = 0;
   enable_add = 0;
   enable_subtract = 0;
	enable_outA = 0;
	enable_outB = 0;
	
	case(enable)

		3'b000: enable_add      = 8’b10000000;
      3'b001: enable_subtract = 8’b01000000;
      3'b010: enable_and      = 8’b00100000;
      3'b011: enable_xor      = 8’b00010000;
		3'b100: enable_or       = 8’b00001000;
		3'b101: enable_outA     = 8’b00000100;
      3'b110: enable_outB     = 8’b00000010;
      3'b111: enable_nand     = 8’b00000001;

		
		default: begin
			enable_or       = 0;
         enable_xor      = 0;
         enable_and      = 0;
         enable_nand     = 0;
         enable_add      = 0;
         enable_subtract = 0;
			enable_outA     = 0;
			enable_outB     = 0;

      end
	endcase
end


endmodule