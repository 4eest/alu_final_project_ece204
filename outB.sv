//and

module alu_outB (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_outB,
output logic [7:0]result_outB,
output logic overflow
);



assign result_outB = enable_outB * (B);
assign overflow = 0;

endmodule 

