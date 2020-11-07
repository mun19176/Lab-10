module Ej2();

  reg CLOCK, EN1, EN2, EN3, RESET; reg [3:0]INPUT; reg [2:0]SELECTION;
  wire [3:0]Y; wire MJM, CARGAR;

	Eje2 U1(CLOCK, RESET, EN1, EN2, EN3, INPUT, SELECTION, Y, MJM, CARGAR);


initial begin
	CLOCK=0;
	forever #5 CLOCK = ~CLOCK;
end
  initial begin
	#3
	$display("         EJ2\n");
    $display("CLK R E1 E2 E3  INPUT   Sel | Y   MJM CARGAR");
    $display("-------------------------------------------");
    $monitor("%b   %b %b  %b  %b  %b  %b | %b  %b    %b", CLOCK, RESET, EN1, EN2, EN3, INPUT, SELECTION, Y, MJM, CARGAR);
       RESET = 1; EN1 = 0; EN2 = 0; EN3 = 0; INPUT = 0; SELECTION = 0;
	   #10 RESET = 0; EN1 = 1; EN2 = 1; EN3 = 1;
	   #10 INPUT = 1;
	   #10 INPUT = 2;
	   #10 INPUT = 3;
	   #10 INPUT = 10;
	   #10 SELECTION = 2;
	   #10 INPUT = 10;
	   #10 SELECTION = 1; INPUT = 5;
	   #10 SELECTION = 3;
	   #20 SELECTION = 4;   
  end


	initial
    #130 $finish;
  initial begin
    $dumpfile("Ej2_tb.vcd");
    $dumpvars(0, Ej2);
  end
endmodule