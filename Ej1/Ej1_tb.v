module Ej1();

  reg CLOCK, RESET, EN1, EN2, LOAD; reg [11:0]DATA; 
  wire [3:0]Q1; wire [3:0]Q2;

//Variables para módulo
	Ejer1 U1(LOAD, CLOCK, EN1, EN2, RESET, DATA, Q1, Q2);


//Prueba para FLipFlop de 1 bit
initial begin
	CLOCK=0;
	forever #5 CLOCK = ~CLOCK;
end
  initial begin
	#3
	$display("         Ej1\n");
    $display("CLK E R L      D       |  Q1    Q0");
    $display("------------------------------------");
    $monitor("%b   %b %b %b %b %b | %b  %b", CLOCK, EN1, EN2, RESET, LOAD, DATA, Q1, Q2);
	//es escogieron números aleatorios para A
       RESET = 1; EN1 = 0; EN2 = 0; LOAD = 0; DATA = 0;
    #1 RESET = 0;
	#20 EN1 = 1; EN2 = 1;
	#50 DATA = 50; LOAD = 1;
	#15 LOAD = 0;
	#15 LOAD = 0;
  end




	initial
    #150 $finish;
  initial begin
    $dumpfile("Ej1_tb.vcd");
    $dumpvars(0, Ej1);
  end
endmodule