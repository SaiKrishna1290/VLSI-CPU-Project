`timescale 1ns/1ps

module immediate_generator_tb;

    reg [31:0] instruction;
    wire [31:0] immediate;

    immediate_generator uut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("immediate_generator_waveform.vcd");
        $dumpvars(0, immediate_generator_tb);

        $monitor(
            "Time=%0t | Instruction=%h | Immediate=%h (%d)",
            $time,
            instruction,
            immediate,
            immediate
        );

        // =================================
        // ADDI with +10
        // =================================

        instruction = 32'b001000_00001_00010_0000000000001010;

        #10;

        // =================================
        // ADDI with +25
        // =================================

        instruction = 32'b001000_00001_00010_0000000000011001;

        #10;

        // =================================
        // ADDI with -1
        // =================================

        instruction = 32'b001000_00001_00010_1111111111111111;

        #10;

        // =================================
        // ADDI with -10
        // =================================

        instruction = 32'b001000_00001_00010_1111111111110110;

        #10;

        // =================================
        // LOAD with +20
        // =================================

        instruction = 32'b100011_00001_00010_0000000000010100;

        #10;

        // =================================
        // STORE with +32
        // =================================

        instruction = 32'b101011_00001_00010_0000000000100000;

        #10;

        // =================================
        // Invalid instruction
        // =================================

        instruction = 32'b111111_00000000000000000000000000;

        #10;

        $finish;

    end

endmodule