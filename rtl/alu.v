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

            // =====================================
            // ADD
            // =====================================
            4'b0000: begin
                temp = {1'b0, a} + {1'b0, b};
                y = temp[7:0];
                carry = temp[8];

                // Signed overflow detection
                overflow = (~(a[7] ^ b[7])) & (a[7] ^ y[7]);
            end

            // =====================================
            // SUBTRACT
            // =====================================
            4'b0001: begin
                y = a - b;

                // Signed overflow detection
                overflow = (a[7] ^ b[7]) & (a[7] ^ y[7]);
            end

            // =====================================
            // AND
            // =====================================
            4'b0010: begin
                y = a & b;
            end

            // =====================================
            // OR
            // =====================================
            4'b0011: begin
                y = a | b;
            end

            // =====================================
            // XOR
            // =====================================
            4'b0100: begin
                y = a ^ b;
            end

            // =====================================
            // NOT
            // =====================================
            4'b0101: begin
                y = ~a;
            end

            // =====================================
            // SHIFT LEFT
            // =====================================
            4'b0110: begin
                y = a << 1;
                carry = a[7];
            end

            // =====================================
            // SHIFT RIGHT
            // =====================================
            4'b0111: begin
                y = a >> 1;
                carry = a[0];
            end

            // =====================================
            // INCREMENT
            // =====================================
            4'b1000: begin
                temp = {1'b0, a} + 9'd1;
                y = temp[7:0];
                carry = temp[8];

                // Overflow: +127 + 1 = -128
                overflow = (~a[7]) & y[7];
            end

            // Default
            default: begin
                y = 8'b00000000;
            end

        endcase

        // =====================================
        // ZERO FLAG
        // =====================================
        if (y == 8'b00000000)
            zero = 1'b1;
        else
            zero = 1'b0;

    end

endmodule