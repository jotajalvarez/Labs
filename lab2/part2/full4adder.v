
`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

module full4adder(LEDR,SW);

    	input [9:0] SW; 
	 output [9:0] LEDR;
	 wire connection1, connection2, connection3;
	 
	 fulladder a1(
		.a(SW[4]),
		.b(SW[0]),
		.c0(SW[8]),
		.s(LEDR[0]),
		.c1(connection1)
	 );
	 
	 fulladder a2(
		.a(SW[5]),
		.b(SW[1]),
		.c0(connection1),
		.s(LEDR[1]),
		.c1(connection2)
	 );
	 
	 fulladder a3(
		.a(SW[6]),
		.b(SW[2]),
		.c0(connection2),
		.s(LEDR[2]),
		.c1(connection3)
	 );
	 
	 fulladder a4(
		.a(SW[7]),
		.b(SW[3]),
		.c0(connection3),
		.s(LEDR[3]),
		.c1(LEDR[9])
	 );
endmodule

module fulladder(a,b,c0,s,c1);
    input a,b,c0;
    output s,c1;
    assign s = ~b&~a&c0 | ~b&a&~c0 | b&~a&~c0 | b&a&c0;
    assign c1 =b&c0 | a&c0 | a&b;
endmodule