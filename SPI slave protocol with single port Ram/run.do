vlib work
vlog SPI_SLAVE.v test_bench.v
vsim -voptargs=+acc work.test_bench
add wave *
run -all
#quit -sim