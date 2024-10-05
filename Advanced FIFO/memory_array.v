module mem(data_in,data_out,clk,wr_en,rd_en,wr_addr,rd_addr,rst_n);
/*----------design parameters-------*/
parameter WIDTH=8;
parameter DEPTH=16;
parameter ADDR_SIZE=4;
parameter PRIORITY=2'b11; //priority for write
/*----------i/o ports-------*/
input  clk, wr_en, rd_en,rst_n; 
input  [ADDR_SIZE:0] wr_addr,rd_addr;
input  [WIDTH-1:0] data_in;
output reg [WIDTH-1:0] data_out;
/*----------memory creation-------*/
reg  [WIDTH-1:0] mem [DEPTH-1:0];
/*----------code-------*/
always @(posedge clk ) begin  
    if (~rst_n) 
       data_out<=0;
	else begin
	     if (PRIORITY==2'b10)  begin 
	        if(wr_en)
	           mem[wr_addr]<=data_in;
	        else if (rd_en) 
	           data_out<=mem[rd_addr];	
	     end 

        else if(PRIORITY==2'b01) begin
	        if (rd_en) 
	           data_out<=mem[rd_addr];
           else if(wr_en)
               mem[wr_addr]<=data_in;
        end
        
        else if(PRIORITY==2'b11) begin
	        if(rd_en) 
	           data_out<=mem[rd_addr];
           if(wr_en)
               mem[wr_addr]<=data_in;
        end  
   end

end endmodule 