module pointer_logic (rptr,wptr,fifo_wr,fifo_rd,rd,wr,fifo_empty,fifo_full,clk,rst_n); 

parameter POINTER_SIZE=4;
input  rd,wr,fifo_empty,fifo_full,clk,rst_n;
output reg [POINTER_SIZE:0] rptr,wptr;
output  fifo_wr,fifo_rd;

assign fifo_wr = (~fifo_full  & wr) ?  1:0;
assign fifo_rd = (~fifo_empty & rd) ?  1:0;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
	   wptr<=5'b0; 
	   rptr<=5'b0;
	end
	else begin
	   if(fifo_wr)     
	     wptr<=wptr+5'b1;
	   else if(fifo_rd) 
	     rptr<=rptr+5'b1;	
	end
end
endmodule 