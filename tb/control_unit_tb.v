`timescale 1ns/1ps

module control_unit_tb;

    reg [31:0] instruction;

    wire [3:0] alu_sel;
    wire       reg_write;
    wire       mem_read;
    wire       mem_write;
    wire       alu_src;
    wire       branch;
    wire       jump;


    // =====================================
    // Instantiate Control Unit
    // =====================================

    control_unit uut (
        .instruction(instruction),

        .alu_sel(alu_sel),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump)
    );


    initial begin

        // =================================
        // Waveform
        // =================================

        $dumpfile("control_unit_waveform.vcd");
        $dumpvars(0, control_unit_tb);


        $monitor(
            "Time=%0t | Instruction=%h | ALU_SEL=%b | REG_WRITE=%b | MEM_READ=%b | MEM_WRITE=%b | ALU_SRC=%b | BRANCH=%b | JUMP=%b",
            $time,
            instruction,
            alu_sel,
            reg_write,
            mem_read,
            mem_write,
            alu_src,
            branch,
            jump
        );


        // =================================
        // R-TYPE
        // =================================

        instruction = 32'b000000_00000000000000000000;

        #10;


        // =================================
        // ADD IMMEDIATE
        // =================================

        instruction = 32'b001000_00000000000000000000;

        #10;


        // =================================
        // SUBTRACT IMMEDIATE
        // =================================

        instruction = 32'b001001_00000000000000000000;

        #10;


        // =================================
        // AND
        // =================================

        instruction = 32'b001100_00000000000000000000;

        #10;


        // =================================
        // OR
        // =================================

        instruction = 32'b001101_00000000000000000000;

        #10;


        // =================================
        // LOAD WORD
        // =================================

        instruction = 32'b100011_00000000000000000000;

        #10;


        // =================================
        // STORE WORD
        // =================================

        instruction = 32'b101011_00000000000000000000;

        #10;


        // =================================
        // BRANCH EQUAL
        // =================================

        instruction = 32'b000100_00000000000000000000;

        #10;


        // =================================
        // JUMP
        // =================================

        instruction = 32'b000010_00000000000000000000;

        #10;


        // =================================
        // INVALID OPCODE
        // =================================

        instruction = 32'b111111_00000000000000000000;

        #10;


        $finish;

    end

endmodule