`timescale 1ns/1ps

module data_memory (
    input  wire        clk,
    input  wire        reset,

    input  wire        mem_read,
    input  wire        mem_write,

    input  wire [31:0] address,
    input  wire [7:0]  write_data,

    output reg  [7:0]  read_data
);

    // 64 locations, 8 bits each
    reg [7:0] memory [0:63];

    integer i;

    // =====================================
    // Reset and Write
    // =====================================

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            for (i = 0; i < 64; i = i + 1)
                memory[i] <= 8'd0;

        end

        else if (mem_write) begin

            if (address < 32'd64)
                memory[address[5:0]] <= write_data;

        end

    end

    // =====================================
    // Read
    // =====================================

    always @(*) begin

        if (mem_read && address < 32'd64)
            read_data = memory[address[5:0]];

        else
            read_data = 8'd0;

    end

endmodule