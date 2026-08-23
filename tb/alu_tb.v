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

    // =====================================
    // Instantiate ALU
    // =====================================
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

        // Generate waveform
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // =====================================
        // DAY 1: BASIC OPERATIONS
        // =====================================

        // ADD: 10 + 5 = 15
        a = 8'd10;
        b = 8'd5;
        sel = 4'b0000;
        #100;

        // SUB: 10 - 5 = 5
        sel = 4'b0001;
        #100;

        // AND
        sel = 4'b0010;
        #100;

        // OR
        sel = 4'b0011;
        #100;

        // =====================================
        // DAY 2: XOR AND NOT
        // =====================================

        // XOR
        sel = 4'b0100;
        #100;

        // NOT A
        sel = 4'b0101;
        #100;

        // =====================================
        // DAY 3: FLAG TESTS
        // =====================================

        // ZERO FLAG: 5 - 5 = 0
        a = 8'd5;
        b = 8'd5;
        sel = 4'b0001;
        #100;

        // CARRY FLAG: 255 + 1 = 256
        a = 8'd255;
        b = 8'd1;
        sel = 4'b0000;
        #100;

        // OVERFLOW FLAG: 127 + 1
        a = 8'd127;
        b = 8'd1;
        sel = 4'b0000;
        #100;

        // =====================================
        // DAY 4: SHIFT OPERATIONS
        // =====================================

        // SHIFT LEFT
        // 10000001 << 1 = 00000010
        // Carry = 1
        a = 8'b10000001;
        b = 8'd0;
        sel = 4'b0110;
        #100;

        // SHIFT RIGHT
        // 10000001 >> 1 = 01000000
        // Carry = 1
        sel = 4'b0111;
        #100;

        // =====================================
        // DAY 5: INCREMENT OPERATION
        // =====================================

        // 10 + 1 = 11
        a = 8'd10;
        b = 8'd0;
        sel = 4'b1000;
        #100;

        // Increment carry test
        // 255 + 1 = 256
        // Result = 0, Carry = 1
        a = 8'd255;
        sel = 4'b1000;
        #100;

        // Increment overflow test
        // 127 + 1 = -128 (signed)
        a = 8'd127;
        sel = 4'b1000;
        #100;

        // Finish simulation
        $finish;

    end

endmodule