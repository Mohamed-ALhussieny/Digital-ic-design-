module fifo(wr, rd, clk, rst_n,data_in,data_out,fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow);
/*----------design parameters-------*/
parameter WIDTH=8;
parameter DEPTH=16;
parameter POINTER_SIZE=4;
parameter THRESHOLD=8;
parameter FULL=15;
/*----------i/o ports-------*/
input  wr, rd, clk, rst_n;
input  [WIDTH-1:0] data_in;
output [WIDTH-1:0] data_out;
output fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow;  
/*----------internal connections-------*/
wire  [POINTER_SIZE:0] wptr,rptr;  
wire  fifo_wr,fifo_rd; //read and write only if fifo is not empty or full.
wire [WIDTH-1:0] DOUT_W;
//reg  [WIDTH-1:0] mem [DEPTH-1:0];
/*----------instances-------*/
mem           #(WIDTH ,DEPTH,4,1)                 mem1(.data_in(data_in),.data_out(DOUT_W),.clk(clk),.wr_en(fifo_wr),.rd_en(fifo_rd),.wr_addr(wptr),.rd_addr(rptr),.rst_n(1));  
status_logic  #(THRESHOLD,POINTER_SIZE,FULL) status_logic(fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow,wptr,rptr,wr,rd);
pointer_logic #(POINTER_SIZE)                pointer_logic(rptr,wptr,fifo_wr,fifo_rd,rd,wr,fifo_empty,fifo_full,clk,rst_n); 
/*------assigning dout------*/
assign data_out=DOUT_W;
endmodule 