module alu(
    input [7:0] a,
    input [7:0] b,
    input [4:0] sel,

    output reg [7:0] y,
    output reg zero,
    output reg carry,
    output reg overflow,
    output reg div_zero
);

reg [8:0] temp;

always @(*) begin

    // Default values
    y = 8'b00000000;
    carry = 1'b0;
    overflow = 1'b0;
    div_zero = 1'b0;
    temp = 9'b000000000;

    case (sel)

        // =========================
        // BASIC ARITHMETIC
        // =========================

        // ADDITION
        5'b00000: begin
            temp = a + b;
            y = temp[7:0];
            carry = temp[8];
            overflow = (~(a[7] ^ b[7])) & (y[7] ^ a[7]);
        end

        // SUBTRACTION
        5'b00001: begin
            y = a - b;
            carry = (a >= b);
            overflow = (a[7] ^ b[7]) & (y[7] ^ a[7]);
        end

        // =========================
        // LOGICAL OPERATIONS
        // =========================

        // AND
        5'b00010: y = a & b;

        // OR
        5'b00011: y = a | b;

        // XOR
        5'b00100: y = a ^ b;

        // NOT
        5'b00101: y = ~a;

        // =========================
        // SHIFT OPERATIONS
        // =========================

        // SHIFT LEFT
        5'b00110: begin
            y = a << 1;
            carry = a[7];
        end

        // SHIFT RIGHT
        5'b00111: begin
            y = a >> 1;
            carry = a[0];
        end

        // =========================
        // INCREMENT
        // =========================

        5'b01000: begin
            temp = a + 1;
            y = temp[7:0];
            carry = temp[8];
        end

        // =========================
        // COMPARISON OPERATIONS
        // =========================

        // EQUAL
        5'b01001:
            y = (a == b) ? 8'd1 : 8'd0;

        // GREATER THAN
        5'b01010:
            y = (a > b) ? 8'd1 : 8'd0;

        // LESS THAN
        5'b01011:
            y = (a < b) ? 8'd1 : 8'd0;

        // =========================
        // DAY 6 LOGIC OPERATIONS
        // =========================

        // NAND
        5'b01100: y = ~(a & b);

        // NOR
        5'b01101: y = ~(a | b);

        // XNOR
        5'b01110: y = ~(a ^ b);

        // =========================
        // DAY 7 OPERATIONS
        // =========================

        // MULTIPLICATION
        5'b01111: begin
            temp = a * b;
            y = temp[7:0];
            carry = temp[8];
        end

        // DIVISION
        5'b10000: begin
            if (b != 0)
                y = a / b;
            else begin
                y = 8'd0;
                div_zero = 1'b1;
            end
        end

        default: begin
            y = 8'd0;
        end

    endcase

    // ZERO FLAG
    if (y == 8'd0)
        zero = 1'b1;
    else
        zero = 1'b0;

end

endmodule