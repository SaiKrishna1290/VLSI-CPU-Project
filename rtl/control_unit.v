`timescale 1ns/1ps

module control_unit (
    input  wire [31:0] instruction,

    output reg [3:0]  alu_sel,
    output reg        reg_write,
    output reg        mem_read,
    output reg        mem_write,
    output reg        alu_src,
    output reg        branch,
    output reg        jump
);

    // Opcode is the upper 6 bits
    wire [5:0] opcode;

    assign opcode = instruction[31:26];

    always @(*) begin

        // Default control signals
        alu_sel   = 4'b0000;
        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        alu_src   = 1'b0;
        branch    = 1'b0;
        jump      = 1'b0;

        case (opcode)

            // =================================
            // R-TYPE
            // =================================
            // ALU operation
            6'b000000: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;
            end

            // =================================
            // ADD IMMEDIATE
            // =================================
            6'b001000: begin
                alu_sel   = 4'b0000;
                reg_write = 1'b1;
                alu_src   = 1'b1;
            end

            // =================================
            // SUBTRACT IMMEDIATE
            // =================================
            6'b001001: begin
                alu_sel   = 4'b0001;
                reg_write = 1'b1;
                alu_src   = 1'b1;
            end

            // =================================
            // AND
            // =================================
            6'b001100: begin
                alu_sel   = 4'b0010;
                reg_write = 1'b1;
                alu_src   = 1'b0;
            end

            // =================================
            // OR
            // =================================
            6'b001101: begin
                alu_sel   = 4'b0011;
                reg_write = 1'b1;
                alu_src   = 1'b0;
            end

            // =================================
            // LOAD WORD
            // =================================
            6'b100011: begin
                alu_sel   = 4'b0000;
                reg_write = 1'b1;
                mem_read  = 1'b1;
                alu_src   = 1'b1;
            end

            // =================================
            // STORE WORD
            // =================================
            6'b101011: begin
                alu_sel   = 4'b0000;
                mem_write = 1'b1;
                alu_src   = 1'b1;
            end

            // =================================
            // BRANCH EQUAL
            // =================================
            6'b000100: begin
                alu_sel = 4'b0001;
                branch  = 1'b1;
                alu_src = 1'b0;
            end

            // =================================
            // JUMP
            // =================================
            6'b000010: begin
                jump = 1'b1;
            end

            default: begin
                alu_sel   = 4'b0000;
                reg_write = 1'b0;
                mem_read  = 1'b0;
                mem_write = 1'b0;
                alu_src   = 1'b0;
                branch    = 1'b0;
                jump      = 1'b0;
            end

        endcase

    end

endmodule