`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg reset;
    reg we;

    reg [2:0] write_addr;
    reg [2:0] read_addr1;
    reg [2:0] read_addr2;

    reg [7:0] write_data;

    wire [7:0] read_data1;
    wire [7:0] read_data2;


    // Instantiate Register File
    register_file uut (
        .clk(clk),
        .reset(reset),
        .we(we),

        .write_addr(write_addr),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),

        .write_data(write_data),

        .read_data1(read_data1),
        .read_data2(read_data2)
    );


    // Clock generation
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // Test cases
    initial begin

        // Generate waveform
        $dumpfile("register_file_waveform.vcd");
        $dumpvars(0, register_file_tb);


        // Initial values
        reset = 1;
        we = 0;

        write_addr = 3'b000;
        read_addr1 = 3'b000;
        read_addr2 = 3'b000;

        write_data = 8'b00000000;

        #10;

        // Release reset
        reset = 0;


        // ============================
        // Write 10 into Register R1
        // ============================

        we = 1;
        write_addr = 3'b001;
        write_data = 8'd10;

        #10;


        // ============================
        // Write 20 into Register R2
        // ============================

        write_addr = 3'b010;
        write_data = 8'd20;

        #10;


        // ============================
        // Write 30 into Register R3
        // ============================

        write_addr = 3'b011;
        write_data = 8'd30;

        #10;


        // Disable writing
        we = 0;


        // ============================
        // Read R1 and R2
        // Expected:
        // read_data1 = 10
        // read_data2 = 20
        // ============================

        read_addr1 = 3'b001;
        read_addr2 = 3'b010;

        #10;


        // ============================
        // Read R2 and R3
        // Expected:
        // read_data1 = 20
        // read_data2 = 30
        // ============================

        read_addr1 = 3'b010;
        read_addr2 = 3'b011;

        #10;


        // ============================
        // Read R1 and R3
        // Expected:
        // read_data1 = 10
        // read_data2 = 30
        // ============================

        read_addr1 = 3'b001;
        read_addr2 = 3'b011;

        #20;

        $finish;

    end

endmodule