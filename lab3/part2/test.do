#set the working dir, where all complied Verilog goes
 vlib work
# 
#Complue all verilog modules in full4adder.v to working dir
 vlog bit8register.v
# 
#Load simulation using full4adder as top level module
 vsim bit8register
#Log alll signals and add some sognals to waveform window.
 log {/*}
#add wave would add all items in top level module
 add wave {/*}
# 
#First test case: Make sure that first HEX0 is showing the correct number in its display. Alu performs full4adder, Data will be 10
# We will make the option 0001 in the middle of the running to prove they are the same operation
force {SW[0]} 0 ;
force {SW[1]} 1 ;
force {SW[2]} 0 ;
force {SW[3]} 1 ;
force {SW[9]} 0 0, 1 10 -repeat 100;
force {KEY[0]} 0 0, 1 5 -repeat 10 ;
force {KEY[3]} 0 ;
force {KEY[2]} 0 ;
force {KEY[1]} 0 0, 1 20 -repeat 40 -cancel 100 ;

run 100 ns

# Second Test Case: Case 2 where we need XOR and OR operations concatenated with the B store in Register
force {SW[0]} 0 ;
force {SW[1]} 1 ;
force {SW[2]} 0 ;
force {SW[3]} 1 ;
force {SW[9]} 0 0, 1 10 -repeat 100 ;
force {KEY[0]} 0 0, 1 5 -repeat 10 ;
force {KEY[3]} 0 ;
force {KEY[2]} 1 ;
force {KEY[1]} 0;

run 100 ns

# Third Test Case: Test the Unary OR operation since our input has a 1 our B should always have a 1 as well. 
force {SW[0]} 0 ;
force {SW[1]} 1 ;
force {SW[2]} 0 ;
force {SW[3]} 0 ;
force {SW[9]} 0 0, 1 10 -repeat 100 ;
force {KEY[0]} 0 0, 1 2 -repeat 10 ;
force {KEY[3]} 0 ;
force {KEY[2]} 1 ;
force {KEY[1]} 1 ;

run 100 ns

# FOurth Test Case: Test unary AND we are passing one zero in our input and expect the register to always hold 0
force {SW[0]} 0 ;
force {SW[1]} 1 ;
force {SW[2]} 1 ;
force {SW[3]} 1 ;
force {SW[9]} 0 0, 1 10 -repeat 100 ;
force {KEY[0]} 0 0, 1 2 -repeat 10 ;
force {KEY[3]} 1 ;
force {KEY[2]} 0 ;
force {KEY[1]} 0;

run 100 ns

#FIfth Test Case: Left shift of B by A units. SO we will fix A to be 0010, two bits of A must be shifted to the left
# Every time there is a positive edge signal

force {SW[0]} 1 ;
force {SW[1]} 1 ;
force {SW[2]}  0;
force {SW[3]} 0 ;
force {SW[9]} 0 0, 1 10 -repeat 100 ;
force {KEY[0]} 0 0, 1 2 -repeat 10 ;
force {KEY[3]} 1 ;
force {KEY[2]} 1 ;
force {KEY[1]} 0;
run 100ns

#Sixth Test Case: Logic Shift of B to the right by A units, we will fix A = 0001 it will put leading
#zeros in the output B every time there is a positive edge trigger. ss

force {SW[0]} 0 ;
force {SW[1]} 0 ;
force {SW[2]} 1 ;
force {SW[3]} 1 ;
force {SW[9]} 0 0, 1 10 -repeat 100 ;
force {KEY[0]} 0 0, 1 2 -repeat 10 ;
force {KEY[3]} 1 ;
force {KEY[2]} 0 ;
force {KEY[1]} 1;
run 100ns
