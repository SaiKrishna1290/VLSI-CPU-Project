`timescale 1ns/1ps

module alu_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg [1:0] sel;

    wire [7:0] y;

    alu uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin

        // Generate waveform file
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // Input values
        a = 8'd10;
        b = 8'd5;

        // Addition
        sel = 2'b00;
        #10;

        // Subtraction
        sel = 2'b01;
        #10;

        // AND
        sel = 2'b10;
        #10;

        // OR
        sel = 2'b11;
        #10;

        $finish;

    end

endmodule