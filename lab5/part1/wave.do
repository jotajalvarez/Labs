# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog sequence_detector.v

#load simulation using mux as the top level simulation module
vsim sequence_detector

#log all signals and add some signals to waveform window
log -r {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#Case #1: Using Reset to Bring back our FSM to State A
force {SW[0]} 1 0, 0 30ns
force {KEY[0]} 0 0, 1 5ns -repeat 10ns
force {SW[1]} 0 0, 1 4ns
run 100ns

#Case #2: W is high for four consecutive clock pulses
#Expected: z = 1 and FF = F(0101)
force {KEY[0]} 0 0, 1 5ns -repeat 10ns
force {SW[1]} 0 0, 1 4ns
force {SW[0]} 1 0
run 100ns

#Case #3: Get to F and the input 0, should take us back to A
force {KEY[0]} 0 0, 1 5ns -repeat 10ns
force {SW[1]} 0 0, 1 4ns,0 54ns
force {SW[0]} 1 0, 0 10ns, 1 20ns
run 100ns

#Case #4 Getting to F and then to G
# Starting at A, keeping w at 1 for four clock cycles
# Then moving to E by putting it low
# Then moving to G by letting it go high again
force {SW[1]} 1 0, 1 4ns, 0 46ns,1 56ns
force {KEY[0]} 0 0, 1 5ns -repeat 10ns
force {SW[0]} 1 0
run 100ns

