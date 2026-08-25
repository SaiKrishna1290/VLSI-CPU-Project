`timescale 1ns/1ps

module alu_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] sel;

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

        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);


        // =====================================
        // DAY 1 OPERATIONS
        // =====================================

        // ADDITION: 10 + 5 = 15
        a = 8'd10;
        b = 8'd5;
        sel = 4'b0000;
        #10;


        // SUBTRACTION: 10 - 5 = 5
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
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 4'b0011;
        #10;


        // =====================================
        // DAY 2 OPERATIONS
        // =====================================

        // XOR
        a = 8'b10101010;
        b = 8'b11001100;
        sel = 4'b0100;
        #10;


        // NOT
        a = 8'b10101010;
        b = 8'b00000000;
        sel = 4'b0101;
        #10;


        // =====================================
        // DAY 4 OPERATIONS
        // =====================================

        // SHIFT LEFT
        a = 8'b00001111;
        b = 8'b00000000;
        sel = 4'b0110;
        #10;


        // SHIFT RIGHT
        a = 8'b11110000;
        b = 8'b00000000;
        sel = 4'b0111;
        #10;


        // INCREMENT
        a = 8'd25;
        b = 8'd0;
        sel = 4'b1000;
        #10;


        // =====================================
        // DAY 5 OPERATIONS
        // =====================================

        // LESS THAN
        // 10 < 20 → y = 1

        a = 8'd10;
        b = 8'd20;
        sel = 4'b1001;
        #10;


        // GREATER THAN
        // 25 > 10 → y = 1

        a = 8'd25;
        b = 8'd10;
        sel = 4'b1010;
        #10;


        // EQUAL TO
        // 15 == 15 → y = 1

        a = 8'd15;
        b = 8'd15;
        sel = 4'b1011;
        #10;


        // LESS THAN FALSE
        // 30 < 10 → y = 0

        a = 8'd30;
        b = 8'd10;
        sel = 4'b1001;
        #10;


        // GREATER THAN FALSE
        // 10 > 20 → y = 0

        a = 8'd10;
        b = 8'd20;
        sel = 4'b1010;
        #10;


        $finish;

    end

endmodule