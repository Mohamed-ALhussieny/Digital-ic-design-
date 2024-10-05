vlib work
vlog PROJECT.v  TB.v
vsim -voptargs=+acc work.TB
add wave *
run -all
run -all
run -all
run -all
#quit -sim