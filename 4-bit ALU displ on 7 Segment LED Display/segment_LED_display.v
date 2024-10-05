module segment_LED_display(A,B, opcode, enable, a,b,c,d,e,f,g);
input [3:0] A,B;
input [1:0] opcode;
input enable;
output reg a,b,c,d,e,f,g;
wire [3:0] alu_out;
reg  [6:0] display_out;
n_bit_alu #(4) alu1(A,B,opcode,alu_out);
always @(*) begin
if (~enable)
//reset
display_out = 7'b0;

else begin
 case(alu_out)
4'h0 : display_out=7'b111_1110;
4'h1 : display_out=7'b011_0000;
4'h2 : display_out=7'b110_1101; 
4'h3 : display_out=7'b111_1001;
4'h4 : display_out=7'b011_0011;
4'h5 : display_out=7'b101_1011;
4'h6 : display_out=7'b101_1111;
4'h7 : display_out=7'b111_0000;
4'h8 : display_out=7'b111_1111;
4'h9 : display_out=7'b111_1011;
4'hA : display_out=7'b111_0111;
4'hB : display_out=7'b001_1111;
4'hC : display_out=7'b100_1110;
4'hD : display_out=7'b011_1101;
4'hE : display_out=7'b100_1111;
default : display_out=7'b100_0111;

endcase
end 
end 

always @(*) begin
a=display_out[6];
b=display_out[5];
c=display_out[4];
d=display_out[3];
e=display_out[2];
f=display_out[1];
g=display_out[0];

end 
endmodule