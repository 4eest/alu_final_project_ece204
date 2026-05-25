//OR

module alu_or (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_or,
output logic [7:0]result_or,
output logic overflow
);

assign result_or = enable_or * (A|B);
assign overflow = 0;

endmodule 
