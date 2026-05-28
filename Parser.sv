module Parser(
	input logic [7:0] count,
	input logic overflow,
	output logic [3:0] ones,
	output logic [3:0] tens
);

	always_comb begin
	
		if(overflow == 1) begin
			assign hundreds = count / 100;
			assign remainder = count % 100;
			assign tens = remainder / 10;
			assign ones = remainder % 10;
		end else begin
			assign ones = 4'b1111;
			assign tens = 4'b1111;
		end


	end

endmodule
