`timescale 1ns/1ps

module alu_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg [2:0] sel;

    wire [7:0] y;
    wire zero;
    wire carry;
    wire overflow;

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

        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // =========================
        // Normal operations
        // =========================

        // ADD: 10 + 5 = 15
        a = 8'd10;
        b = 8'd5;
        sel = 3'b000;
        #10;

        // SUB: 10 - 5 = 5
        sel = 3'b001;
        #10;

        // AND
        sel = 3'b010;
        #10;

        // OR
        sel = 3'b011;
        #10;

        // XOR
        sel = 3'b100;
        #10;

        // NOT A
        sel = 3'b101;
        #10;

        // =========================
        // Zero flag test
        // =========================

        // 5 - 5 = 0
        a = 8'd5;
        b = 8'd5;
        sel = 3'b001;
        #10;

        // =========================
        // Carry flag test
        // =========================

        // 255 + 1 = 256
        // Result = 0, Carry = 1
        a = 8'd255;
        b = 8'd1;
        sel = 3'b000;
        #10;

        // =========================
        // Overflow flag test
        // =========================

        // 127 + 1 = 128
        // Signed overflow occurs
        a = 8'd127;
        b = 8'd1;
        sel = 3'b000;
        #10;

        $finish;

    end

endmodule