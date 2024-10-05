module mux(in1,in2,out);

parameter B_INPUT="DIRECT";
parameter width=18;

input [width-1:0] in1,in2;
output[width-1:0] out;


generate 
        if ( B_INPUT=="DIRECT"||B_INPUT=="OPMODE5")
               connection_only #(width) c1(in1,out);
              
        else if(B_INPUT=="LATENCY") 
               connection_only #(width) c1(in2,out);

endgenerate 
generate 
        if ( B_INPUT=="OPMODE5")
               connection_only #(width) c1(in1,out);
              
        else if(B_INPUT=="cin") 
               connection_only #(width) c1(in2,out);

endgenerate

endmodule 
