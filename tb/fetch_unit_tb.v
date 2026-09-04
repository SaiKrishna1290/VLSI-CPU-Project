`timescale 1ns/1ps

module fetch_unit_tb;

    reg clk;
    reg reset;
    reg enable;

    wire [31:0] pc;
    wire [31:0] instruction;


    // =====================================
    // Fetch Unit
    // =====================================

    fetch_unit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .pc(pc),
        .instruction(instruction)
    );


    // =====================================
    // Clock
    // =====================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // =====================================
    // Test
    // =====================================

    initial begin

        $dumpfile("fetch_unit_waveform.vcd");
        $dumpvars(0, fetch_unit_tb);

        $monitor(
            "Time=%0t | Reset=%b | Enable=%b | PC=%d | Instruction=%h",
            $time,
            reset,
            enable,
            pc,
            instruction
        );


        // =================================
        // RESET
        // =================================

        reset = 1'b1;
        enable = 1'b0;

        #10;


        // =================================
        // START FETCHING
        // =================================

        reset = 1'b0;
        enable = 1'b1;

        #10;
        #10;
        #10;
        #10;
        #10;


        // =================================
        // HOLD PC
        // =================================

        enable = 1'b0;

        #20;


        // =================================
        // CONTINUE
        // =================================

        enable = 1'b1;

        #20;


        $finish;

    end

endmodule