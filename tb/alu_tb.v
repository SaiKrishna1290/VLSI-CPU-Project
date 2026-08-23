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

        // =====================
        // DAY 1 OPERATIONS
        // =====================

        // ADD: 10 + 5 = 15
        a = 8'd10;
        b = 8'd5;
        sel = 3'b000;
        #100;

        // SUB: 10 - 5 = 5
        sel = 3'b001;
        #100;

        // AND
        sel = 3'b010;
        #100;

        // OR
        sel = 3'b011;
        #100;

        // =====================
        // DAY 2 OPERATIONS
        // =====================

        // XOR
        sel = 3'b100;
        #100;

        // NOT A
        sel = 3'b101;
        #100;

        // =====================
        // DAY 3 FLAG TESTS
        // =====================

        // ZERO FLAG: 5 - 5 = 0
        a = 8'd5;
        b = 8'd5;
        sel = 3'b001;
        #100;

        // CARRY FLAG: 255 + 1
        a = 8'd255;
        b = 8'd1;
        sel = 3'b000;
        #100;

        // OVERFLOW FLAG: 127 + 1
        a = 8'd127;
        b = 8'd1;
        sel = 3'b000;
        #100;

        // =====================
        // DAY 4 SHIFT OPERATIONS
        // =====================

        // SHIFT LEFT
        // 10000001 << 1 = 00000010
        // Carry = 1
        a = 8'b10000001;
        b = 8'd0;
        sel = 3'b110;
        #100;

        // SHIFT RIGHT
        // 10000001 >> 1 = 01000000
        // Carry = 1
        sel = 3'b111;
        #100;

        $finish;

    end

endmodule