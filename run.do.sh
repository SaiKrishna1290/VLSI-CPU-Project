# ==========================================
# VLSI CPU PROJECT - RUN ALL SIMULATIONS
# ==========================================

# Create work library
if {![file exists work]} {
    vlib work
}

vmap work work


# ==========================================
# COMPILE RTL FILES
# ==========================================

echo "=========================================="
echo "        COMPILING RTL FILES"
echo "=========================================="

vlog rtl/alu.v
vlog rtl/register_file.v
vlog rtl/program_counter.v


# ==========================================
# COMPILE TESTBENCH FILES
# ==========================================

echo "=========================================="
echo "      COMPILING TESTBENCH FILES"
echo "=========================================="

vlog tb/alu_tb.v
vlog tb/register_file_tb.v
vlog tb/program_counter_tb.v


# ==========================================
# ALU SIMULATION
# ==========================================

echo "=========================================="
echo "          ALU SIMULATION"
echo "=========================================="

vsim -c work.alu_tb
run -all
quit -sim


# ==========================================
# REGISTER FILE SIMULATION
# ==========================================

echo "=========================================="
echo "      REGISTER FILE SIMULATION"
echo "=========================================="

vsim -c work.register_file_tb
run -all
quit -sim


# ==========================================
# PROGRAM COUNTER SIMULATION
# ==========================================

echo "=========================================="
echo "       PROGRAM COUNTER SIMULATION"
echo "=========================================="

vsim work.program_counter_tb

add wave *
run 120 ns


# ==========================================
# COMPLETE
# ==========================================

echo "=========================================="
echo "     ALL SIMULATIONS COMPLETED"
echo "=========================================="