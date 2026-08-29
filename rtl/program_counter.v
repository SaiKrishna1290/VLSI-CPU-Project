`timescale 1ns/1ps

module program_counter (
    input  wire        clk,
    input  wire        reset,
    input  wire        enable,
    input  wire        load,
    input  wire [31:0] load_address,

    output reg  [31:0] pc
);

always @(posedge clk or posedge reset) begin

    if (reset) begin
        pc <= 32'd0;
    end

    else if (load) begin
        pc <= load_address;
    end

    else if (enable) begin
        pc <= pc + 32'd4;
    end

end

endmodule