module RegisterNBit
#(
    parameter int WIDTH
)
(
    input logic clock,
    input logic clear_n, // Active low clear signal
    input logic reset_n,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);

// Update `q` only on the rising edge of `clock` and when `clear_n` is not active
    always_ff @(posedge clock or negedge reset_n) begin

        if (reset_n == 1'b0) begin
            // Set `q` to 0 asynchronously
            q <= '0;
        end else if (clear_n == 1'b0) begin
            // Set `q` to 0 when `clear_n` is low (active) on clock rising edge
            q <= '0;
        end else begin
            // Set `q` to `d` on `clock` rising edge
            q <= d;
        end
    end
endmodule


