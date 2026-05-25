//and

module alu_and (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_and,
output logic [7:0]result_and,
output logic overflow
);



assign result_and = enable_and ? (A & B) : 0;
assign overflow = 0;

endmodule 

