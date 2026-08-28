`timescale 1ns/1ps

module register_file (
    input wire clk,
    input wire reset,
    input wire we,

    input wire [2:0] write_addr,
    input wire [2:0] read_addr1,
    input wire [2:0] read_addr2,

    input wire [7:0] write_data,

    output wire [7:0] read_data1,
    output wire [7:0] read_data2
);

    // 8 registers, each 8 bits
    reg [7:0] registers [0:7];

    integer i;

    // Write operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 8; i = i + 1) begin
                registers[i] <= 8'b00000000;
            end
        end
        else if (we) begin
            registers[write_addr] <= write_data;
        end
    end

    // Read operation
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];

endmodule