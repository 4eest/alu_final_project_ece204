//NAND extra credit option

module alu_nand (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_nand,
output logic [7:0]result_and,
output logic overflow
);



assign result_and = enable_nand * ~(A & B);
assign overflow = 0;

endmodule 
