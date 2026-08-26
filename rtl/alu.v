module alu(
    input [7:0] a,
    input [7:0] b,
    input [3:0] sel,

    output reg [7:0] y,
    output reg zero,
    output reg carry,
    output reg overflow
);

reg [8:0] temp;

always @(*) begin

    // Default values
    y = 8'b00000000;
    carry = 1'b0;
    overflow = 1'b0;
    temp = 9'b000000000;

    case (sel)

        // Basic arithmetic operations
        4'b0000: begin
            temp = a + b;
            y = temp[7:0];
            carry = temp[8];
            overflow = (~(a[7] ^ b[7])) & (y[7] ^ a[7]);
        end

        4'b0001: begin
            y = a - b;
            carry = (a >= b);
            overflow = (a[7] ^ b[7]) & (y[7] ^ a[7]);
        end

        // Basic logic operations
        4'b0010: y = a & b;       // AND

        4'b0011: y = a | b;       // OR

        4'b0100: y = a ^ b;       // XOR

        4'b0101: y = ~a;          // NOT

        // Shift operations
        4'b0110: y = a << 1;      // Shift Left

        4'b0111: y = a >> 1;      // Shift Right

        // Increment
        4'b1000: begin
            temp = a + 1;
            y = temp[7:0];
            carry = temp[8];
        end

        // Comparison operations
        4'b1001: y = (a == b) ? 8'b00000001 : 8'b00000000;

        4'b1010: y = (a > b) ? 8'b00000001 : 8'b00000000;

        4'b1011: y = (a < b) ? 8'b00000001 : 8'b00000000;

        // =========================
        // Day 6 Operations
        // =========================

        4'b1100: y = ~(a & b);    // NAND

        4'b1101: y = ~(a | b);    // NOR

        4'b1110: y = ~(a ^ b);    // XNOR

        default: y = 8'b00000000;

    endcase

    // Zero flag
    if (y == 8'b00000000)
        zero = 1'b1;
    else
        zero = 1'b0;

end

endmodule