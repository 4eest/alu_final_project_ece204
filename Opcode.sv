module opcode(

	input logic [5:0] sw,
		
	output logic enable_or,
	output logic enable_xor,
	output logic enable_and,
	output logic enable_nand,
	output logic enable_add,
	output logic enable_subtract


);

logic enable = 1;

always_comb begin
	
	enable_or = 0;
   enable_xor = 0;
   enable_and = 0;
	enable_nand = 0;
   enable_add = 0;
   enable_subtract = 0;
	
	case(enable)

		3'b000: enable_or       = 1;
      3'b001: enable_xor      = 1;
      3'b010: enable_and      = 1;
      3'b011: enable_nand     = 1;
      3'b100: enable_add      = 1;
      3'b101: enable_subtract = 1;
		  
		default: begin
			enable_or       = 0;
         enable_xor      = 0;
         enable_and      = 0;
         enable_nand     = 0;
         enable_add      = 0;
         enable_subtract = 0;
      end
	endcase
end


endmodule