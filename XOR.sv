//xor

module alu_xor (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_xor,
output logic [7:0]result_xor,
output logic overflow
);



assign result_xor = enable_xor * (A ^ B);
assign overflow = 0;

endmodule 
