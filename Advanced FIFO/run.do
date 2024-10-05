vlib work
vlog fifo.v testBench.v
vsim -voptargs=+acc work.testBench
add wave *
run -all
#quit -sim