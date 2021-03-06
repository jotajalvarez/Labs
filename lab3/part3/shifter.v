`timescale 1ns / 1ns // `timescale time_unit/time_precision

module shifter(SW,KEY,LEDR);

    //GUIDE: SW[7:0] LoadVal
    // SW[9] Reset
    //KEY[0] Clock
    // KEY[1] Load_n
    // KEY[2] Shift Right
    // KEY[3] ASR
    input [9:0] SW;
    input [3:0] KEY;
    output [7:0] LEDR;
    wire s1,s2,s3,s4,s5,s6,s7,s8,special;

    // Create the Logic of ASR to either make a sign extension or load zeros
    // which is just a 2-to1 mux
    mux2to1 ASR(
        .x(1'b0),
        .y(s1),
        .s(KEY[3]),
        .m(special)
    );
    // Instantiate 8 modules of ShiftBit
    shiftbit first(
        .in(special),
        .load_v(SW[0]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s1)
    );
assign LEDR[0] = s1;
    shiftbit second(
        .in(s1),
        .load_v(SW[1]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s2)
    );
assign LEDR[1] = s2;
    shiftbit third(
        .in(s2),
        .load_v(SW[2]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s3)
    );
assign LEDR[2] = s3;
    shiftbit fourth(
        .in(s3),
        .load_v(SW[3]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s4)
    );
assign LEDR[3] = s4;
    shiftbit fifth(
        .in(s4),
        .load_v(SW[4]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s5)
    );
assign LEDR[4] = s5;
    shiftbit sixth(
        .in(s5),
        .load_v(SW[5]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s6)
    );
assign LEDR[5] = s6;
    shiftbit seventh(
        .in(s6),
        .load_v(SW[6]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s7)
    );
assign LEDR[6] = s7;
    shiftbit eigth(
        .in(s7),
        .load_v(SW[7]),
        .load_n(KEY[1]),
        .clock(KEY[0]),
        .reset_n(SW[9]),
        .shift(KEY[2]),
        .out(s8)
    );
assign LEDR[7] = s8;



endmodule

module shiftbit(in,load_v,load_n, clock, reset_n, shift,out);
    // we will need three wires
    input in,load_v, load_n, clock, reset_n, shift;
    output out;
    wire c1,c2,c3;

    mux2to1 firstMux(
        .x(c1),
        .y(in),
        .s(shift),
        .m(c2)
    );
    mux2to1 secondMux(
        .x(load_val),
        .y(c2),
        .s(load_n),
        .m(c3)
    );

    dpositiveflipflop flip1(
        .clock(clock),
        .reset(reset_n),
        .d(c3),
        .q(c1)
    );
assign out = c1;
endmodule
module dpositiveflipflop(clock, reset,d,q);
    input clock;
    input reset;
    input d;
    output q;
    reg q;
    always@(posedge clock)
        begin
        if (reset == 1'b0)
            q<=0;
        else
            q<=d;
        end
endmodule

module mux2to1(x,y,s,m);
    input  x,y,s;
    output m;
    assign m = x &~s | y &s;
endmodule