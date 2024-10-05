module n_bit_alu(in0, in1, opcode, out); 
parameter N = 4;
input [N-1:0] in0, in1; 
input [1:0] opcode;
 output reg [N-1:0] out;
always@(*) begin
 case (opcode)

0: out = in0 + in1; 
1: out = in0 | in1;
2: out = in0 - in1;
3: out = in0 ^ in1;
endcase
end
endmodule






















