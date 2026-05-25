//NAND extra credit option

module alu_nand (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_nand,
output logic [7:0]result_nand,
output logic overflow
);



assign result_nand = enable_nand ? ~(A & B) : 0;
assign overflow = 0;

endmodule 
