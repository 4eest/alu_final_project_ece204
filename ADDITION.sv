//addition operation 
module alu_add (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_add,
output logic [7:0]result_add,
output logic overflow
);

assign result_add = enable_and * (A + B);
endmodule
