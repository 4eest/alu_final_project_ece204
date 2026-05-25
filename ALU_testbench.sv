/*
 * ECE 204 Final Project (Arithmetic Logic Unit) Testbench
 *
 * Author(s): Forrest Gentry
 * Last Modified: 5/18/2026
 * 
 * Description:
 * This testbench evaluates and verifies functionality of the 8-bit ALU module.
 *
 */

////////////////////////////////////////////////
// Constants for downstream parameters go here
`define NUM_OPS         8
`define OPERAND_WIDTH   8
`define MAXERRORS       10

////////////////////////////////////////////////

/*
* Helper Functions
*/

function automatic logic [`NUM_OPS-1:0] one_hot_ops(input int idx);
    return (`NUM_OPS)'(1) << idx;
endfunction

/*
* Binary Operator Validation Objects.
*/

class validateOP #(
    parameter int MAXERRORS = 10, 
    parameter int NUM_OPS = 8, 
    parameter int OPERAND_WIDTH = 8
    );
    
    // Expected outputs
    logic [OPERAND_WIDTH - 1:0] resultExpected;
    logic overflowExpected;
    // Measured Outputs
    logic [OPERAND_WIDTH - 1:0] resultMeasured;
    logic overflowMeasured;  

    int numErrors = 0;

    logic [NUM_OPS - 1:0] opcode;

    function new(logic [NUM_OPS - 1:0] op);
        this.opcode = op;
    endfunction

    task validate(input logic [OPERAND_WIDTH - 1:0] inputA, input logic [OPERAND_WIDTH - 1:0] inputB);
        case (this.opcode)
            one_hot_ops(NUM_OPS - 1): begin
                {this.overflowExpected, this.resultExpected}  = inputA + inputB;
            end
            one_hot_ops(NUM_OPS - 2): begin
                {this.overflowExpected, this.resultExpected}  = inputA - inputB;
            end
            one_hot_ops(NUM_OPS - 3): begin
                this.resultExpected  = inputA & inputB;
                this.overflowExpected = 0;
            end
            one_hot_ops(NUM_OPS - 4): begin
                this.resultExpected  = inputA | inputB;
                this.overflowExpected = 0;
            end
            one_hot_ops(NUM_OPS - 5): begin
                this.resultExpected  = inputA ^ inputB;
                this.overflowExpected = 0;
            end
            one_hot_ops(NUM_OPS - 6): begin
                this.resultExpected  = inputA;
                this.overflowExpected = 0;
            end
            one_hot_ops(NUM_OPS - 7): begin
                this.resultExpected  = inputB;
                this.overflowExpected = 0;
            end
            one_hot_ops(NUM_OPS - 8): begin
                this.resultExpected  = ~(inputA & inputB);
                this.overflowExpected = 0;
            end
        endcase

        this.validateState(inputA, inputB);

    endtask
    
    function void getMeasurements(input logic [OPERAND_WIDTH - 1:0] resultMeasurement, input logic overflowMeasurement);
        this.resultMeasured = resultMeasurement;
        this.overflowMeasured = overflowMeasurement;
    endfunction

    task validateState(input logic [OPERAND_WIDTH - 1:0] inputA, input logic [OPERAND_WIDTH - 1:0] inputB);

        if (this.resultExpected !== this.resultMeasured || this.overflowExpected !== this.overflowMeasured) begin

            this.numErrors++;
            if (this.numErrors > MAXERRORS) begin
                $display("Too many errors for operation %b.  Halting simulation.", this.opcode);
                $stop;
            end

            // Print current time, inputs, measured & expected quantities
            $display("(%0t ps) OpCode: %b | Input A: %b | Input B: %b | Measured: %b, %b (Result, Overflow) | Expected: %b, %b (Result, Overflow)",
                $time,
                this.opcode,
                inputA, inputB,
                this.resultMeasured, this.overflowMeasured,
                this.resultExpected, this.overflowExpected);

        end

    endtask

endclass

class sweep #(
    parameter int MAXERRORS = 10, 
    parameter int NUM_OPS = 8, 
    parameter int OPERAND_WIDTH = 8
);

    virtual ALU_if vif;
    validateOP #(MAXERRORS, NUM_OPS, OPERAND_WIDTH) validator;

    function new(virtual ALU_if vif, validateOP #(MAXERRORS, NUM_OPS, OPERAND_WIDTH) validator);
        this.vif       = vif;
        this.validator = validator;
    endfunction

    task run();
        for (int i = 0; i < (2**OPERAND_WIDTH); i++) begin
            for (int j = 0; j < (2**OPERAND_WIDTH); j++) begin
                vif.inputA  = i[OPERAND_WIDTH - 1:0];
                vif.inputB  = j[OPERAND_WIDTH - 1:0];
                vif.enable  = 1;
                #10;  // wait for DUT to settle
                validator.getMeasurements(vif.result, vif.overflow);
                validator.validate(i[OPERAND_WIDTH - 1:0], j[OPERAND_WIDTH - 1:0]);
            end
        end
    endtask
endclass

interface ALU_if #(
    parameter int NUM_OPS = 8, 
    parameter int OPERAND_WIDTH = 8
);
    logic        reset_n;
    logic        enable;
    logic [OPERAND_WIDTH - 1:0]  inputA;
    logic [OPERAND_WIDTH - 1:0]  inputB;
    logic [NUM_OPS - 1:0]  opcode;
    logic [OPERAND_WIDTH - 1:0]  result;
    logic        overflow;
endinterface

module ALUTestbench();

    parameter int MAXERRORS = `MAXERRORS;
    parameter int NUM_OPS = `NUM_OPS;
    parameter int OPERAND_WIDTH = `OPERAND_WIDTH;

    /*
    * Instantiate ALU as device under test.
    */
    ALU_if #(
        NUM_OPS, 
        OPERAND_WIDTH
    ) alu_if();

    task reset();
        alu_if.reset_n = 1'b0;
        #10;
        alu_if.reset_n = 1'b1;
    endtask

    ALU #(
    ) dut (
        .reset_n(alu_if.reset_n),
        .enable(alu_if.enable),
        .inputA(alu_if.inputA),
        .inputB(alu_if.inputB),
        .opcode(alu_if.opcode),
        .result(alu_if.result),
        .overflow(alu_if.overflow)
    );

    sweep #(
        MAXERRORS, 
        NUM_OPS, 
        OPERAND_WIDTH
    ) sweeper;

    initial begin
        // construct validators first

        validateOP #(
        MAXERRORS, 
        NUM_OPS, 
        OPERAND_WIDTH
        ) validator;    

        for (int i = 0; i < NUM_OPS; i++) begin
            /* Reset the system, then validate all. */
            alu_if.opcode = one_hot_ops(NUM_OPS - 1 - i);
            validator = new(alu_if.opcode);
            reset();
            sweeper = new(alu_if, validator); // pass it into sweep
            sweeper.run();
        end
    end
endmodule
