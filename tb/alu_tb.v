`timescale 1ns/1ps

module alu_tb;

    // Inputs
    reg [7:0] a;
    reg [7:0] b;
    reg [2:0] sel;

    // Output
    wire [7:0] y;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    // Test operations
    initial begin

        // Generate waveform file
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // Initialize inputs
        a = 8'd10;
        b = 8'd5;

        // ADD: 10 + 5 = 15
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

        // Finish simulation
        $finish;

    end

endmodule