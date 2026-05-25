//subtraction operation
module alu_subtract (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_subtract,
output logic [7:0]result_subtract,
output logic overflow
);

assign result_subtract = enable_subtract * (A - B);

endmodule