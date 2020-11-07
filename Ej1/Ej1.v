module CL(input wire [11:0]DATA, input wire LOAD, ENABLE, CLOCK, RESET, output reg [11:0]Y1);
	always @(posedge CLOCK or posedge LOAD or posedge RESET)
		if (RESET) begin
			Y1 <= 12'b0 ;
		end else if (LOAD) begin
			Y1 <= DATA;
		end else if (ENABLE) begin
			Y1 <= Y1 + 1;
		end
endmodule 


module ROM (input wire [11:0]ADDSS, output wire [7:0]DATA);           
	reg [11:0] mem [0:4095] ;  
    
	assign DATA = mem[ADDSS];

initial begin
  $readmemb("MEM.txt", mem); 
end

endmodule


module Fetch(input wire CLOCKS, input wire [7:0]D, input wire RESET, input wire ENABLE, output [3:0]Q1, output [3:0]Q0);
reg Q1;
reg Q0;
wire [3:0]D1;
wire [3:0]D0;
assign D1[0] = D[4];
assign D1[1] = D[5];
assign D1[2] = D[6];
assign D1[3] = D[7];
assign D0[0] = D[0];
assign D0[1] = D[1];
assign D0[2] = D[2];
assign D0[3] = D[3];
	always @(posedge CLOCKS or	posedge RESET or posedge ENABLE)
		if (RESET)begin
		Q1 <= 0;
		Q0 <= 0;
	end else if(ENABLE) begin
		Q1 <= D1;
		Q0 <= D0;
	end
endmodule


module Ejer1 (input wire LOAD, CLOCK, EN1, EN2, RESET, input wire [11:0]DATA, output wire [3:0]Q1, output wire [3:0]Q0);
	wire [11:0]YCL;
	wire [7:0]YROM;
	CL O1(DATA, LOAD,  EN1, CLOCK, RESET, YCL);
	ROM O2(YCL, YROM);
	Fetch O3(CLOCK, YROM, RESET, EN2, Q1, Q0);
endmodule
	
