module  testBench();
//____DUT Input regs  
 reg     clk;  
 reg     rst_n;  
 reg     wr;  
 reg     rd;  
 reg     [7:0] data_in;  
 //___DUT Output wires  
 wire     [7:0] data_out;  
 wire     fifo_empty;  
 wire     fifo_full;  
 wire     fifo_threshold;  
 wire     fifo_overflow;  
 wire     fifo_underflow;  
 //____DUT
 fifo #(8,16,4,8,15) FIFO_module(wr, rd, clk, rst_n,data_in,data_out,fifo_full, fifo_empty, fifo_threshold, fifo_overflow, fifo_underflow);
 integer i;
 //reg  [WIDTH-1:0] mem [DEPTH-1:0];
//____clk generation
initial begin
    clk=0;
    forever 
    #5 clk=~clk;
end
//____stimulus
initial begin
$readmemh("mem.dat",FIFO_module.mem1.mem);
rst_n=0;
wr=0;  
rd=0;  
data_in=0; 
@(negedge clk);
rst_n=1;
for(i=0;i<20;i=i+1) begin
   wr=1;    
   data_in=i;
 @(negedge clk);
end
//rst_n=0;  @(negedge clk);  rst_n=1;
for(i=0;i<20;i=i+1) begin
   wr=0;
   rd=1;    
   data_in=0;
 @(negedge clk);
end
rst_n=0;  @(negedge clk);  rst_n=1;
for(i=0;i<20;i=i+1) begin
   wr=$random;
   rd=$random;    
   data_in=i;
 @(negedge clk);
end
$stop;	
end
initial begin
           $display("----------------------------------------------"); 
           $display("----------------------------------------------");  
           $display("----------- SIMULATION RESULT ----------------");  
           $display("----------------------------------------------");  
           $display("----------------------------------------------");  
           $monitor(" wr = %b, rd = %b, data_in = %d", wr, rd, data_in);
end
endmodule 

