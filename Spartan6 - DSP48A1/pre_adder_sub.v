module pre_adder_sub(in1,in2,out,sel);
////////////////////////

input [17:0] in1,in2;
input sel;
output [17:0] out ;
wire [17:0] add,sub;
////////////////////////
assign add=in1+in2;
assign sub=in1-in2;
assign out = sel ? sub : add ;

endmodule 