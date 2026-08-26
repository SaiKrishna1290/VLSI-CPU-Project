`timescale 1ns/1ps

module alu_tb;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] sel;

    // Outputs
    wire [7:0] y;
    wire zero;
    wire carry;
    wire overflow;

    // Instantiate ALU
    alu uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
    );

    initial begin

        // Waveform file
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // =========================
        // Day 1: Basic Operations
        // =========================

        // ADD: 10 + 5 = 15
        a = 8'd10;
        b = 8'd5;
        sel = 4'b0000;
        #10;

        // SUB: 10 - 5 = 5
        a = 8'd10;
        b = 8'd5;
        sel = 4'b0001;
        #10;

        // AND
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 4'b0010;
        #10;

        // OR
        sel = 4'b0011;
        #10;

        // XOR
        sel = 4'b0100;
        #10;

        // NOT
        a = 8'b10101010;
        sel = 4'b0101;
        #10;

        // =========================
        // Day 4: Shift Operations
        // =========================

        // Shift Left
        a = 8'b00001111;
        sel = 4'b0110;
        #10;

        // Shift Right
        a = 8'b11110000;
        sel = 4'b0111;
        #10;

        // Increment
        a = 8'd25;
        sel = 4'b1000;
        #10;

        // =========================
        // Day 5: Comparison
        // =========================

        // Equal
        a = 8'd10;
        b = 8'd10;
        sel = 4'b1001;
        #10;

        // Greater Than
        a = 8'd20;
        b = 8'd10;
        sel = 4'b1010;
        #10;

        // Less Than
        a = 8'd5;
        b = 8'd10;
        sel = 4'b1011;
        #10;

        // =========================
        // Day 6: NAND
        // =========================

        a = 8'b10101010;
        b = 8'b11001100;
        sel = 4'b1100;
        #10;

        // NOR
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 4'b1101;
        #10;

        // XNOR
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 4'b1110;
        #10;

        $finish;

    end

endmodule