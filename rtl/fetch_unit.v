`timescale 1ns/1ps

module fetch_unit (
    input  wire        clk,
    input  wire        reset,
    input  wire        enable,

    output wire [31:0] pc,
    output wire [31:0] instruction
);

    // =====================================
    // Program Counter
    // =====================================

    program_counter pc_unit (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load(1'b0),
        .load_address(32'd0),
        .pc(pc)
    );


    // =====================================
    // Instruction Memory
    // =====================================

    instruction_memory imem (
        .address(pc),
        .instruction(instruction)
    );

endmodule