`timescale 1ns/1ps

module immediate_generator (
    input  wire [31:0] instruction,
    output reg  [31:0] immediate
);

    wire [5:0] opcode;

    assign opcode = instruction[31:26];

    always @(*) begin

        case (opcode)

            // ADDI
            6'b001000: begin
                immediate = {{16{instruction[15]}}, instruction[15:0]};
            end

            // SUBI
            6'b001001: begin
                immediate = {{16{instruction[15]}}, instruction[15:0]};
            end

            // LOAD
            6'b100011: begin
                immediate = {{16{instruction[15]}}, instruction[15:0]};
            end

            // STORE
            6'b101011: begin
                immediate = {{16{instruction[15]}}, instruction[15:0]};
            end

            // BRANCH
            6'b000100: begin
                immediate = {{16{instruction[15]}}, instruction[15:0]};
            end

            // Default
            default: begin
                immediate = 32'd0;
            end

        endcase

    end

endmodule