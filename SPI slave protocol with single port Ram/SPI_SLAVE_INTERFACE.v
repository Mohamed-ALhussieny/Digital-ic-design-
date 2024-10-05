module SPI_INTERFACE(MOSI,SCK,SS_n,rstn,MISO);
input  MOSI;
input  SCK;
input  SS_n;
input  rstn;
output MISO;

wire [7:0] tx_data;
wire tx_valid;
wire rx_valid;
wire [9:0] rx_data;


SPI_SLAVE #(3'b000,3'b001,3'b010,3'b011,3'b100) 
SLAVE (SCK,rstn,MOSI,SS_n,tx_data,tx_valid,MISO,rx_valid,rx_data);


RAM  #(256,8) RAM1(SCK,rstn,rx_valid,tx_valid,tx_data,rx_data);



endmodule  

//XC7A35TICPG236-1L

