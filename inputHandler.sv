module inputHandler(
    input logic [7:0] data_in,
    input logic save,
    input logic reset_n,
    output logic [7:0] input_passthrough,
    output logic [7:0] reg1,
    output logic [7:0] reg2
);

logic [1:0] counter;
logic clear_sig_n;
logic [7:0] reg1_out;
logic [7:0] reg2_out;

RegisterNBit #(
    .WIDTH(8)
) register1 (
    .clock(~save),
    .d(data_in),
    .clear_n(clear_sig_n),
    .reset_n(reset_n),
    .q(reg1_out)
);

RegisterNBit #(
    .WIDTH(8)
) register2 (
    .clock(~save),
    .d(reg1_out),
    .clear_n(clear_sig_n),
    .reset_n(reset_n),
    .q(reg2_out)
);

always_ff @(posedge save or negedge reset_n) begin
    
    if (reset_n == 1'b0) begin
        counter <= 0;
        clear_sig_n <= 1;
        input_passthrough <= 0;
        reg1 <= 0;
        reg2 <= 0;

    end else begin

        counter <= counter + 1;

        if (counter < 2) begin

            clear_sig_n <= 1;

            if (counter == 1) begin
                input_passthrough <= data_in;
                reg1 <= reg1_out;
                reg2 <= reg2_out;
            end else begin
                input_passthrough <= 0;
                reg1 <= 0;
                reg2 <= 0;
            end

        end else if (counter == 2) begin
            clear_sig_n <= 0;
            counter <= 0;
        end
    end

end

endmodule

