`timescale 1ns/1ps

module data_memory_tb;

    reg        clk;
    reg        reset;
    reg        mem_read;
    reg        mem_write;

    reg [31:0] address;
    reg [7:0]  write_data;

    wire [7:0] read_data;


    // =====================================
    // Instantiate Data Memory
    // =====================================

    data_memory uut (
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
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

        $dumpfile("data_memory_waveform.vcd");
        $dumpvars(0, data_memory_tb);

        $monitor(
            "Time=%0t | Reset=%b | Read=%b | Write=%b | Address=%d | WriteData=%h | ReadData=%h",
            $time,
            reset,
            mem_read,
            mem_write,
            address,
            write_data,
            read_data
        );


        // =================================
        // RESET
        // =================================

        reset = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        address = 32'd0;
        write_data = 8'd0;

        #10;


        // =================================
        // RELEASE RESET
        // =================================

        reset = 1'b0;

        #5;


        // =================================
        // WRITE 25 TO ADDRESS 10
        // =================================

        address = 32'd10;
        write_data = 8'd25;
        mem_write = 1'b1;

        #10;


        // Stop writing
        mem_write = 1'b0;


        // =================================
        // READ ADDRESS 10
        // Expected = 25
        // =================================

        mem_read = 1'b1;

        #10;


        // =================================
        // WRITE 100 TO ADDRESS 20
        // =================================

        mem_read = 1'b0;
        address = 32'd20;
        write_data = 8'd100;
        mem_write = 1'b1;

        #10;


        // =================================
        // READ ADDRESS 20
        // Expected = 100
        // =================================

        mem_write = 1'b0;
        mem_read = 1'b1;

        #10;


        // =================================
        // READ ADDRESS 10 AGAIN
        // Expected = 25
        // =================================

        address = 32'd10;

        #10;


        // =================================
        // INVALID ADDRESS
        // =================================

        address = 32'd100;

        #10;


        $finish;

    end

endmodule