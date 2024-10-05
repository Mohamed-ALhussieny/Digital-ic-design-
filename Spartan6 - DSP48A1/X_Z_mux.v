module X_Z_mux(in0,in1,in2,in3,sel,out);
parameter width_in0=48;
parameter width_in1=48;
parameter width_in2=36;
parameter width_in3=1 ;
parameter width_out=48;
/////////////////////////////
input [width_in0-1:0] in0;
input [width_in1-1:0] in1;
input [width_in2-1:0] in2;
input [width_in3-1:0] in3;
input [1:0] sel;
/////////////////////////////
output reg [width_out-1:0] out ;
/////////////////////////////
always @(*) begin
	case(sel)
  2'b00: out =in0;
  2'b01: out =in1;
  2'b10: out =in2;
  2'b11: out =in3;
	endcase 
end
endmodule 


