`timescale 1ns/1ps

module decode_unit_tb;

    reg [31:0] instruction;

    wire [3:0]  alu_sel;
    wire        reg_write;
    wire        mem_read;
    wire        mem_write;
    wire        alu_src;
    wire        branch;
    wire        jump;

    wire [31:0] immediate;


    // =====================================
    // Decode Unit
    // =====================================

    decode_unit uut (
        .instruction(instruction),

        .alu_sel(alu_sel),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),

        .immediate(immediate)
    );


    // =====================================
    // Test
    // =====================================

    initial begin

        $dumpfile("decode_unit_waveform.vcd");
        $dumpvars(0, decode_unit_tb);

        $monitor(
            "Time=%0t | Instruction=%h | ALU_SEL=%b | REG_WRITE=%b | MEM_READ=%b | MEM_WRITE=%b | ALU_SRC=%b | BRANCH=%b | JUMP=%b | IMM=%h",
            $time,
            instruction,
            alu_sel,
            reg_write,
            mem_read,
            mem_write,
            alu_src,
            branch,
            jump,
            immediate
        );


        // =================================
        // ADD IMMEDIATE
        // opcode = 001000
        // immediate = 10
        // =================================

        instruction = 32'b001000_00001_00010_0000000000001010;

        #10;


        // =================================
        // SUBTRACT IMMEDIATE
        // immediate = 20
        // =================================

        instruction = 32'b001001_00001_00010_0000000000010100;

        #10;


        // =================================
        // LOAD WORD
        // immediate = 16
        // =================================

        instruction = 32'b100011_00001_00010_0000000000010000;

        #10;


        // =================================
        // STORE WORD
        // immediate = 24
        // =================================

        instruction = 32'b101011_00001_00010_0000000000011000;

        #10;


        // =================================
        // BRANCH
        // =================================

        instruction = 32'b000100_00001_00010_0000000000000100;

        #10;


        // =================================
        // JUMP
        // =================================

        instruction = 32'b000010_00000000000000000000000100;

        #10;


        // =================================
        // Invalid instruction
        // =================================

        instruction = 32'b111111_00000000000000000000000000;

        #10;


        $finish;

    end

endmodule