module test_bench();

reg  MOSI;
wire MISO;
reg  SS_n;
reg  clk;
reg  rstn;
integer i;


/*_______________instantiation_________________*/
SPI_INTERFACE   dut(MOSI,clk,SS_n,rstn,MISO);

/*_______________generate clk_________________*/
initial begin
    clk=0;
forever 
#1  clk=~clk;
end

initial begin
$readmemh("mem.dat",RAM.RAM1);
/*________________________________*/
rstn=0;
SS_n=1;
@(negedge clk);
rstn=1;
SS_n=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
for(i=0;i<8;i=i+1) begin
MOSI=$random;
@(negedge clk);
end 
SS_n=1;
@(negedge clk);
/*________________________________*/
SS_n=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
      for(i=0;i<8;i=i+1) begin
         MOSI=$random;
         @(negedge clk);
end 
SS_n=1;
@(negedge clk);
/*_______________________________*/
SS_n=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
MOSI=0;
@(negedge clk);
      for(i=0;i<8;i=i+1) begin
          MOSI=$random;
          @(negedge clk);
end 
SS_n=1;
@(negedge clk);

/*________________________________*/
SS_n=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
MOSI=1;
@(negedge clk);
     for(i=0;i<8;i=i+1) begin
           MOSI=$random;
           @(negedge clk);
end 
SS_n=1;
@(negedge clk);
$stop;
end 

endmodule
