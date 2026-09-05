`timescale 1ns/1ps

module decode_unit (
    input wire [31:0] instruction,

    output wire [3:0] alu_sel,
    output wire       reg_write,
    output wire       mem_read,
    output wire       mem_write,
    output wire       alu_src,
    output wire       branch,
    output wire       jump,

    output wire [31:0] immediate
);

    // =====================================
    // Control Unit
    // =====================================

    control_unit control (
        .instruction(instruction),
        .alu_sel(alu_sel),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump)
    );


    // =====================================
    // Immediate Generator
    // =====================================

    immediate_generator imm_gen (
        .instruction(instruction),
        .immediate(immediate)
    );

endmodule