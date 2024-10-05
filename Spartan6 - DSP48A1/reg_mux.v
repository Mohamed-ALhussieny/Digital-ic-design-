module reg_mux(in,out,clk,rst,clk_en);

parameter width=18;
parameter sel=1;
parameter RSTTYPE="SYNC";

input  [width-1:0] in;
input  clk,clk_en,rst;
output [width-1:0] out;

wire [width-1:0] q;


generate 
     if(sel==1) begin

          if (RSTTYPE=="SYNC") begin
              	reg_syncronus  #(width) rs(in,q,clk,rst,clk_en);
              	
          end    
          else begin
          	reg_Asyncronus #(width) rs(in,q,clk,rst,clk_en);
               //assign out = q ;
          end
     end

     else begin
     	
              q=in;
     end
 endgenerate 

     assign out = q ;
     endmodule 

                 