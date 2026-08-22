module alu(
    input [7:0] a,
    input [7:0] b,
    input [2:0] sel,

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

        case (sel)

            // ADD
            3'b000: begin
                temp = {1'b0, a} + {1'b0, b};
                y = temp[7:0];
                carry = temp[8];

                // Signed overflow
                overflow = (~(a[7] ^ b[7])) & (a[7] ^ y[7]);
            end

            // SUB
            3'b001: begin
                y = a - b;

                // Signed overflow
                overflow = (a[7] ^ b[7]) & (a[7] ^ y[7]);
            end

            // AND
            3'b010: begin
                y = a & b;
            end

            // OR
            3'b011: begin
                y = a | b;
            end

            // XOR
            3'b100: begin
                y = a ^ b;
            end

            // NOT A
            3'b101: begin
                y = ~a;
            end

            default: begin
                y = 8'b00000000;
            end

        endcase

        // Zero flag
        if (y == 8'b00000000)
            zero = 1'b1;
        else
            zero = 1'b0;

    end

endmodule