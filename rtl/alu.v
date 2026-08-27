`timescale 1ns/1ps

module alu_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg [4:0] sel;

    wire [7:0] y;
    wire zero;
    wire carry;
    wire overflow;
    wire div_zero;

    // Instantiate ALU
    alu uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .div_zero(div_zero)
    );

    initial begin

        // =========================
        // ADDITION
        // 10 + 5 = 15
        // =========================
        a = 8'd10;
        b = 8'd5;
        sel = 5'b00000;
        #10;

        // =========================
        // SUBTRACTION
        // 10 - 5 = 5
        // =========================
        a = 8'd10;
        b = 8'd5;
        sel = 5'b00001;
        #10;

        // AND
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 5'b00010;
        #10;

        // OR
        sel = 5'b00011;
        #10;

        // XOR
        sel = 5'b00100;
        #10;

        // NOT
        sel = 5'b00101;
        #10;

        // SHIFT LEFT
        a = 8'b00001111;
        sel = 5'b00110;
        #10;

        // SHIFT RIGHT
        a = 8'b11110000;
        sel = 5'b00111;
        #10;

        // INCREMENT: 25 + 1 = 26
        a = 8'd25;
        sel = 5'b01000;
        #10;

        // EQUAL
        a = 8'd10;
        b = 8'd10;
        sel = 5'b01001;
        #10;

        // GREATER THAN
        a = 8'd20;
        b = 8'd10;
        sel = 5'b01010;
        #10;

        // LESS THAN
        a = 8'd5;
        b = 8'd10;
        sel = 5'b01011;
        #10;

        // NAND
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 5'b01100;
        #10;

        // NOR
        sel = 5'b01101;
        #10;

        // XNOR
        sel = 5'b01110;
        #10;

        // MULTIPLICATION: 5 × 3 = 15
        a = 8'd5;
        b = 8'd3;
        sel = 5'b01111;
        #10;

        // DIVISION: 20 / 4 = 5
        a = 8'd20;
        b = 8'd4;
        sel = 5'b10000;
        #10;

        // DIVISION BY ZERO
        a = 8'd20;
        b = 8'd0;
        sel = 5'b10000;
        #10;

        // =========================
        // DAY 8
        // DECREMENT: 10 - 1 = 9
        // =========================
        a = 8'd10;
        b = 8'd0;
        sel = 5'b10001;
        #10;

        // DECREMENT ZERO: 0 - 1
        a = 8'd0;
        sel = 5'b10001;
        #10;

        // =========================
        // MODULUS: 20 % 6 = 2
        // =========================
        a = 8'd20;
        b = 8'd6;
        sel = 5'b10010;
        #10;

        // MODULUS BY ZERO
        a = 8'd20;
        b = 8'd0;
        sel = 5'b10010;
        #10;

        $finish;

    end

endmodule