`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

module mux7to1(LEDR,SW);

    input [9:0] SW;
    output [9:0] LEDR;
    mux u1(
	.IN(SW[6:0]),
	.SEL(SW[9:7]),
	.Out(LEDR[0])
	);

endmodule

module mux(IN,SEL,Out); 
 input [6:0]IN;
 input [2:0]SEL;
 output Out;
 reg Out;
 always@(*)
	begin
	  case(SEL[2:0])
	 	3'b000: Out = IN[0];
        	3'b001: Out = IN[4];
        	3'b010: Out = IN[2];
        	3'b011: Out = IN[6];
        	3'b100: Out = IN[1];
        	3'b101: Out = IN[5];
        	3'b110: Out = IN[3];
        	3'b111: Out = IN[6];
        default Out = 1;
        endcase
	end
endmodule

