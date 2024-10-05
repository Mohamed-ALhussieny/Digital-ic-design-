module reg_syncronus(in,out,clk,en);

 parameter width=18;

 input  [width-1:0] in;
 input  clk,en;
 output reg  [width-1:0] out;



 always @(posedge clk ) begin
 		
 	if(en)
 	   assign  = ; out<=in;
 end
 endmodule 