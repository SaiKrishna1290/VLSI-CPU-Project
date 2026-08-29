`timescale 1ns/1ps

module cpu_blocks_tb;

    reg clk;
    reg reset;

    // =========================
    // ALU signals
    // =========================
    reg [7:0] a;
    reg [7:0] b;
    reg [3:0] sel;

    wire [7:0] alu_y;
    wire alu_zero;
    wire alu_carry;
    wire alu_overflow;
    wire alu_div_zero;

    // =========================
    // Register File signals
    // =========================
    reg rf_we;
    reg [2:0] rf_write_addr;
    reg [2:0] rf_read_addr1;
    reg [2:0] rf_read_addr2;
    reg [7:0] rf_write_data;

    wire [7:0] rf_read_data1;
    wire [7:0] rf_read_data2;

    // =========================
    // Program Counter signals
    // =========================
    reg pc_enable;
    reg pc_load;
    reg [31:0] pc_load_address;

    wire [31:0] pc;


    // =========================
    // ALU
    // =========================

    alu uut_alu (
        .a(a),
        .b(b),
        .sel(sel),
        .y(alu_y),
        .zero(alu_zero),
        .carry(alu_carry),
        .overflow(alu_overflow),
        .div_zero(alu_div_zero)
    );


    // =========================
    // REGISTER FILE
    // =========================

    register_file uut_rf (
        .clk(clk),
        .reset(reset),
        .we(rf_we),
        .write_addr(rf_write_addr),
        .read_addr1(rf_read_addr1),
        .read_addr2(rf_read_addr2),
        .write_data(rf_write_data),
        .read_data1(rf_read_data1),
        .read_data2(rf_read_data2)
    );


    // =========================
    // PROGRAM COUNTER
    // =========================

    program_counter uut_pc (
        .clk(clk),
        .reset(reset),
        .enable(pc_enable),
        .load(pc_load),
        .load_address(pc_load_address),
        .pc(pc)
    );


    // =========================
    // CLOCK
    // =========================

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // =========================
    // TEST
    // =========================

    initial begin

        $monitor(
            "Time=%0t | PC=%d | ALU: A=%d B=%d SEL=%b Y=%d | RF: R1=%d R2=%d",
            $time,
            pc,
            a,
            b,
            sel,
            alu_y,
            rf_read_data1,
            rf_read_data2
        );


        // Initial values

        reset = 1;

        a = 0;
        b = 0;
        sel = 0;

        rf_we = 0;
        rf_write_addr = 0;
        rf_read_addr1 = 0;
        rf_read_addr2 = 0;
        rf_write_data = 0;

        pc_enable = 0;
        pc_load = 0;
        pc_load_address = 0;

        #10;


        // =========================
        // RELEASE RESET
        // =========================

        reset = 0;

        pc_enable = 1;

        #10;


        // =========================
        // ALU ADD
        // 10 + 5 = 15
        // =========================

        a = 10;
        b = 5;
        sel = 4'b0000;

        #10;


        // =========================
        // ALU XOR
        // =========================

        a = 8'b11001100;
        b = 8'b10101010;
        sel = 4'b0100;

        #10;


        // =========================
        // WRITE R1 = 10
        // =========================

        rf_we = 1;
        rf_write_addr = 3'b001;
        rf_write_data = 10;

        #10;


        // =========================
        // WRITE R2 = 20
        // =========================

        rf_write_addr = 3'b010;
        rf_write_data = 20;

        #10;


        // Stop writing

        rf_we = 0;

        rf_read_addr1 = 3'b001;
        rf_read_addr2 = 3'b010;

        #10;


        // =========================
        // PC LOAD
        // =========================

        pc_enable = 0;
        pc_load = 1;
        pc_load_address = 100;

        #10;


        // =========================
        // PC CONTINUE
        // =========================

        pc_load = 0;
        pc_enable = 1;

        #20;


        // =========================
        // ALU MULTIPLICATION
        // 5 * 4 = 20
        // =========================

        a = 5;
        b = 4;
        sel = 4'b1100;

        #10;


        // =========================
        // ALU DIVISION
        // 20 / 4 = 5
        // =========================

        a = 20;
        b = 4;
        sel = 4'b1101;

        #10;


        // =========================
        // FINISH
        // =========================

        $finish;

    end

endmodule