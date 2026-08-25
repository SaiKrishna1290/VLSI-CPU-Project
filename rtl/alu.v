module alu(
    input  [7:0] a,
    input  [7:0] b,
    input  [3:0] sel,

    output reg [7:0] y,
    output zero,
    output carry,
    output overflow
);

    reg carry_reg;
    reg overflow_reg;
    reg [8:0] temp;

    always @(*) begin

        y = 8'b00000000;
        carry_reg = 1'b0;
        overflow_reg = 1'b0;
        temp = 9'b000000000;

        case(sel)

            // ADDITION
            4'b0000: begin
                temp = a + b;
                y = temp[7:0];
                carry_reg = temp[8];

                if ((a[7] == b[7]) && (y[7] != a[7]))
                    overflow_reg = 1'b1;
            end

            // SUBTRACTION
            4'b0001: begin
                y = a - b;

                if (a < b)
                    carry_reg = 1'b1;

                if ((a[7] != b[7]) && (y[7] != a[7]))
                    overflow_reg = 1'b1;
            end

            // AND
            4'b0010:
                y = a & b;

            // OR
            4'b0011:
                y = a | b;

            // XOR
            4'b0100:
                y = a ^ b;

            // NOT
            4'b0101:
                y = ~a;

            // SHIFT LEFT
            4'b0110: begin
                y = a << 1;
                carry_reg = a[7];
            end

            // SHIFT RIGHT
            4'b0111: begin
                y = a >> 1;
                carry_reg = a[0];
            end

            // INCREMENT
            4'b1000: begin
                temp = a + 1'b1;
                y = temp[7:0];
                carry_reg = temp[8];
            end

            // LESS THAN
            4'b1001: begin
                if (a < b)
                    y = 8'b00000001;
                else
                    y = 8'b00000000;
            end

            // GREATER THAN
            4'b1010: begin
                if (a > b)
                    y = 8'b00000001;
                else
                    y = 8'b00000000;
            end

            // EQUAL TO
            4'b1011: begin
                if (a == b)
                    y = 8'b00000001;
                else
                    y = 8'b00000000;
            end

            default: begin
                y = 8'b00000000;
            end

        endcase
    end

    assign zero = (y == 8'b00000000);
    assign carry = carry_reg;
    assign overflow = overflow_reg;

endmodule