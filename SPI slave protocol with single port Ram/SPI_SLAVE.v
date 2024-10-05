module SPI_SLAVE(clk,rstn,MOSI,SS_n,tx_data,tx_valid,MISO, rx_valid,rx_data);
/*parameters*/
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADDR=3'b011;
parameter READ_DATA=3'b100;
/*inputs--------------------------*/
input clk;
input rstn;
input MOSI;
input SS_n;
input [7:0] tx_data;
input tx_valid;
/*outputs-------------------------*/
output reg MISO;
output reg rx_valid;
output reg [9:0] rx_data;
/*wires---------------------------*/
reg [2:0] CS ,NS;
reg flag_read_addr;
reg [3:0] i=3'b000;
reg [9:0] rx_temp;
reg []
/*---------------FSM-----------------*/
(*fsm_encoding="one_hot"*)
always @(*) begin
case(CS)
IDLE: begin
           rx_valid=0;
           if(SS_n==0) begin
              NS=CHK_CMD;
           end
      end 

 CHK_CMD: begin
            if( MOSI==0)
              NS=WRITE;
            else if(MOSI==1 && flag_read_addr==0)
              NS=READ_ADDR;
            else if(MOSI==1)
              NS=READ_DATA;
            else if(SS_n==1)
              NS=IDLE;
          end

WRITE: begin
         if(SS_n==1) 
           NS=IDLE;
       end
READ_ADDR: begin 
             if(SS_n==1) 
              NS=IDLE;
           end
 /*_______________________________________*/
READ_DATA: begin
             if(SS_n==1) 
               NS=IDLE;
           end
endcase 
end
/*----------------state memory----------------*/
always@(posedge clk or negedge rstn) begin
  if(~rstn)
    CS=IDLE;
  else
    CS=NS;
end
/*----------------output logic----------------*/
always@(posedge clk) begin
 if(CS==WRITE) begin 
    rx_temp[0]<=MOSI;
    rx_temp=rx_temp<<1;
    i<=i+1;
     if(i==10) begin 
       rx_data=rx_temp; 
       rx_valid<=1;
       i=0;
       end 
 end
/*_______________________________________*/
 else if(CS==READ_ADDR) begin 
    rx_temp[0]<=MOSI;
    rx_temp=rx_temp<<1;
    i=i+1;
     if(i==10) begin 
       rx_data=rx_temp; 
       rx_valid<=1;
       flag_read_addr=1;
       i=0;
     end 
  end 
/*_______________________________________*/
 else if(CS==READ_DATA) begin
     rx_temp[0]<=MOSI;
     rx_temp=rx_temp<<1;
     i<=i+1;
       if(i==10) begin 
          rx_data=rx_temp; 
          rx_valid<=1;
          flag_read_addr=1;
          i=0;
       end
 end
end 
/*----------------output logic----------------*/
always@(posedge clk) begin
   if(tx_valid==1) begin
     MISO<=tx_data[7]; 
     tx_data=tx_data<<1;
       if(i==8) i=0; 
end

 else if(tx_valid!=1) begin
      MISO=0; 
  end 
end
endmodule