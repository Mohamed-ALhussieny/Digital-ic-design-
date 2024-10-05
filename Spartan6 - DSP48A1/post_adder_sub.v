module post_adder_sub(in1,in2,out,sel,cin,cout);

input [47:0] in1,in2;
input sel,cin;
output [47:0] out;
output cout;
wire  [48:0] add,sub;
wire [48:0]  out1;
//////////////////////
assign add = in1+(in2+cin);
assign sub = in1-(in2+cin);
assign out1 =sel ? sub:add;
assign out=out1[47:0];
assign cout =out1[48]; 

endmodule 