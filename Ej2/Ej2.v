module BUF3(input wire ENABLE, input wire [3:0]INPUT, output wire [3:0]Y1);
	assign Y1 = ENABLE ? INPUT : 4'bz;
endmodule

module ALU (input wire [3:0]A, input wire [3:0]B, input wire [2:0]SELECTION, output reg [3:0]Y, output reg MJM, output reg CARGAR); 
reg [4:0]X;

	always @ (A or B or SELECTION) 
		case (SELECTION) 
			0 : begin
				Y = A;
				MJM = ~Y[0]&~Y[1]&~Y[2]&~Y[3];
				end
			1 : begin
				X = A - B; 
				Y[0] = X[0];
				Y[1] = X[1];
				Y[2] = X[2];
				Y[3] = X[3];
				CARGAR = X[4];
				MJM = ~Y[0]&~Y[1]&~Y[2]&~Y[3];
				end 
			2 : begin
				Y = B;
				MJM = ~Y[0]&~Y[1]&~Y[2]&~Y[3];
				end
			3 : begin
				X = A + B; 
				Y[0] = X[0];
				Y[1] = X[1];
				Y[2] = X[2];
				Y[3] = X[3];
				CARGAR = X[4];
				MJM = ~Y[0]&~Y[1]&~Y[2]&~Y[3];
				end
			4 : begin
				Y = ~(A&B);
				MJM = ~Y[0]&~Y[1]&~Y[2]&~Y[3];
				end
			default : $display("ERROR EN LA SELECCIÓN"); 
		endcase 
endmodule

module ACC(input wire CLOCK, input wire [3:0]FD, input wire RESET, input wire ENABLE, output [3:0]Q0);
reg Q0;
	always @(posedge CLOCK or	posedge RESET or posedge ENABLE)
		if (RESET)begin
		Q0 <= 0;
	end else if(ENABLE) begin
		Q0 <= FD;
	end
endmodule

module Eje2(input wire CLOCK, RESET, EN1, EN2, EN3, input wire [3:0]INPUT, input wire [2:0]SELECTION, output wire [3:0]Y, output wire MJM, CARGAR);
	wire [3:0]YBuf1;
	wire [3:0]YACC;
	wire [3:0]YALU;
	BUF3 O1(EN1, INPUT, YBuf1);
	ACC O3(CLOCK, YALU, RESET, EN3, YACC);
	ALU O2(YACC, YBuf1, SELECTION, YALU, MJM, CARGAR);
	BUF3 O4(EN2, YALU, Y);
endmodule