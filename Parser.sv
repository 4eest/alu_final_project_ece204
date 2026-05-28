module Parser(
	input logic [7:0] count,
	input logic overflow,
	output logic [3:0] ones,
	output logic [3:0] tens,
	output logic [3:0] hundreds 
);

logic remainder [7:0];
	always_comb begin
	
	
		 hundreds = count / 100;
		 remainder = count % 100;
		 tens = remainder / 10;
		 ones = remainder % 10;
	


	end

endmodule

