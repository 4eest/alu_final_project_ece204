//addition operation 
module alu_add (
input logic [7:0]A,
input logic [7:0]B,
input logic enable_add,
output logic [7:0]result_add,
output logic overflow
);

assign {overflow,result_add} = enable_add ? (A + B) : 0;
endmodule
