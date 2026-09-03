`timescale 1ns/1ps

module execute_unit (
    input  wire        clk,
    input  wire        reset,

    // Register File control
    input  wire        reg_write,
    input  wire [2:0]  write_addr,
    input  wire [2:0]  read_addr1,
    input  wire [2:0]  read_addr2,
    input  wire [7:0]  write_data,

    // ALU control
    input  wire [3:0]  alu_sel,

    // Outputs
    output wire [7:0]  alu_result,
    output wire        zero,
    output wire        carry,
    output wire        overflow
);

    // =====================================
    // Register File outputs
    // =====================================

    wire [7:0] reg_data1;
    wire [7:0] reg_data2;


    // =====================================
    // Register File
    // =====================================

    register_file rf (
        .clk(clk),
        .reset(reset),
        .we(reg_write),
        .write_addr(write_addr),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_data(write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );


    // =====================================
    // ALU
    // =====================================

    alu alu_unit (
        .a(reg_data1),
        .b(reg_data2),
        .sel(alu_sel),
        .y(alu_result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
    );

endmodule