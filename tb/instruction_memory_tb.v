`timescale 1ns/1ps

module instruction_memory_tb;

    reg [31:0] address;
    wire [31:0] instruction;

    // Instantiate Instruction Memory
    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        // Create waveform
        $dumpfile("instruction_memory_waveform.vcd");
        $dumpvars(0, instruction_memory_tb);

        $monitor(
            "Time=%0t | Address=%d | Instruction=%h",
            $time,
            address,
            instruction
        );

        // =========================
        // Instruction 0
        // =========================

        address = 32'd0;
        #10;

        // =========================
        // Instruction 1
        // =========================

        address = 32'd4;
        #10;

        // =========================
        // Instruction 2
        // =========================

        address = 32'd8;
        #10;

        // =========================
        // Instruction 3
        // =========================

        address = 32'd12;
        #10;

        // =========================
        // Instruction 4
        // =========================

        address = 32'd16;
        #10;

        // =========================
        // Instruction 5
        // =========================

        address = 32'd20;
        #10;

        // =========================
        // Instruction 10
        // =========================

        address = 32'd40;
        #10;

        // =========================
        // Invalid address
        // =========================

        address = 32'd100;
        #10;

        $finish;

    end

endmodule