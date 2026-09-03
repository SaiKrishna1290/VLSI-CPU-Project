`timescale 1ns/1ps

module execute_unit_tb;

    reg        clk;
    reg        reset;

    reg        reg_write;
    reg [2:0]  write_addr;
    reg [2:0]  read_addr1;
    reg [2:0]  read_addr2;
    reg [7:0]  write_data;

    reg [3:0]  alu_sel;

    wire [7:0] alu_result;
    wire       zero;
    wire       carry;
    wire       overflow;


    // =====================================
    // Execute Unit
    // =====================================

    execute_unit uut (
        .clk(clk),
        .reset(reset),

        .reg_write(reg_write),
        .write_addr(write_addr),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_data(write_data),

        .alu_sel(alu_sel),

        .alu_result(alu_result),
        .zero(zero),
        .carry(carry),
        .overflow(overflow)
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

        $dumpfile("execute_unit_waveform.vcd");
        $dumpvars(0, execute_unit_tb);

        $monitor(
            "Time=%0t | R1=%d | R2=%d | ALU_SEL=%b | RESULT=%d | ZERO=%b | CARRY=%b | OVERFLOW=%b",
            $time,
            uut.reg_data1,
            uut.reg_data2,
            alu_sel,
            alu_result,
            zero,
            carry,
            overflow
        );


        // =================================
        // RESET
        // =================================

        reset = 1'b1;

        reg_write = 1'b0;
        write_addr = 3'd0;
        read_addr1 = 3'd0;
        read_addr2 = 3'd0;
        write_data = 8'd0;
        alu_sel = 4'b0000;

        #10;


        // =================================
        // RELEASE RESET
        // =================================

        reset = 1'b0;


        // =================================
        // WRITE R1 = 10
        // =================================

        reg_write = 1'b1;
        write_addr = 3'd1;
        write_data = 8'd10;

        #10;


        // =================================
        // WRITE R2 = 5
        // =================================

        write_addr = 3'd2;
        write_data = 8'd5;

        #10;


        // Stop writing
        reg_write = 1'b0;


        // Read R1 and R2
        read_addr1 = 3'd1;
        read_addr2 = 3'd2;


        // =================================
        // ADD
        // 10 + 5 = 15
        // =================================

        alu_sel = 4'b0000;

        #10;


        // =================================
        // SUBTRACT
        // 10 - 5 = 5
        // =================================

        alu_sel = 4'b0001;

        #10;


        // =================================
        // AND
        // =================================

        alu_sel = 4'b0010;

        #10;


        // =================================
        // OR
        // =================================

        alu_sel = 4'b0011;

        #10;


        // =================================
        // XOR
        // =================================

        alu_sel = 4'b0100;

        #10;


        $finish;

    end

endmodule