module tb();
reg [3:0] A, B; 
reg [1:0] opcode;
reg  enable;
wire a,b,c,d,e,f,g;
integer i;
segment_LED_display d1(A,B, opcode, enable, a,b,c,d,e,f,g);

initial begin

enable=1;
	for(i=0;i<100;i=i+1) begin
A=$random;
B=$random;
opcode=$random;
#1;
    end
$stop;
	end
    endmodule





    