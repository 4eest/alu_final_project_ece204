//and

module alu_outA (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_outA,
output logic [7:0]result_outA,
output logic overflow
);



assign result_outA = enable_outA * (A);
assign overflow = 0;

endmodule 

