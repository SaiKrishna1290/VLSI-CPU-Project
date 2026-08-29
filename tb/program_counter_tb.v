`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg reset;
    reg enable;
    reg load;

    reg [31:0] load_address;

    wire [31:0] pc;


    // =====================================
    // Instantiate Program Counter
    // =====================================

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load(load),
        .load_address(load_address),
        .pc(pc)
    );


    // =====================================
    // Clock Generation
    // =====================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // =====================================
    // Testbench
    // =====================================

    initial begin

        // Create waveform
        $dumpfile("program_counter_waveform.vcd");
        $dumpvars(0, program_counter_tb);
$monitor(
    "Time=%0t | Reset=%b | Enable=%b | Load=%b | Load_Address=%d | PC=%d",
    $time, reset, enable, load, load_address, pc
);

        // Initial values
        reset = 1'b1;
        enable = 1'b0;
        load = 1'b0;
        load_address = 32'd0;

        #10;


        // =================================
        // Release Reset
        // PC should be 0
        // =================================

        reset = 1'b0;
        enable = 1'b1;

        #10;


        // =================================
        // PC increments
        // 0 -> 4
        // =================================

        #10;


        // =================================
        // PC increments
        // 4 -> 8
        // =================================

        #10;


        // =================================
        // PC increments
        // 8 -> 12
        // =================================

        #10;


        // =================================
        // LOAD ADDRESS
        // PC = 100
        // =================================

        load = 1'b1;
        enable = 1'b0;
        load_address = 32'd100;

        #10;


        // =================================
        // Continue incrementing
        // 100 -> 104
        // =================================

        load = 1'b0;
        enable = 1'b1;

        #10;


        // =================================
        // 104 -> 108
        // =================================

        #10;


        // =================================
        // HOLD PC
        // =================================

        enable = 1'b0;

        #20;


        // =================================
        // RESET
        // PC should return to 0
        // =================================

        reset = 1'b1;

        #10;

        reset = 1'b0;

        #10;


        $finish;

    end

endmodule