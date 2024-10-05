module mux_adder_reg(in1,in2,out,sel);
 
parameter width=18;

input [width-1:0] in1,in2;
input sel;
output[width-1:0] out;

assign out = sel ? in2:in1;
endmodule 