module status_logic(fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow,wptr,rptr,wr,rd);
/*----------design parameters-------*/
parameter THRESHOLD=8;
parameter POINTER_SIZE=4;
parameter FULL=15;
/*----------i/o ports-------*/
input  [POINTER_SIZE:0] wptr,rptr;
input  wr,rd;
output reg fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow;
/*----------code-------*/
always @(*) begin
//fifo full and overfolw
	if ( (wptr-rptr) >= (FULL+1) ) begin  // checks if differance is equal one cycle
	   fifo_full<=1;
	   if(wr==1) 
	     fifo_overflow<=1;
    end else begin fifo_full<=0; fifo_overflow<=0; end 

//fifo empty and fifo underflow 
    if (wptr==rptr) begin 
       fifo_empty<=1;
       if(rd==1)
         fifo_underflow<=1;
    end else begin  fifo_empty<=0; fifo_underflow<=0; end

//fifo thershold
    if ((wptr-rptr)==8) begin 
       fifo_threshold<=1;
    end else begin fifo_threshold<=0; end
end
endmodule 