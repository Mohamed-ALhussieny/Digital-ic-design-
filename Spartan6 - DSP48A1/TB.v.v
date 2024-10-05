module tb();
reg [17:0] A,B,D;  reg [47:0] C;  reg [17:0] BCIN ;  reg CARRYIN;  reg clk;  reg [7:0] OPMODE ;reg [47:0] PCIN ;  reg RSTA;  reg RSTB;  reg RSTC;  reg RSTCARRYIN ;  reg RSTD;  reg RSTM;
reg RSTOPMODE;  reg RSTP;  reg CEA;  reg CEB;  reg CEC;  reg CECARRYIN;  reg CED;  reg CEM ;  reg CEOPMODE;  reg CEP;
//////////////////////////////////
wire [47:0] p_tb,PCOUT_tb;
reg  [47:0] p_exp,PCOUT_exp;
wire [35:0] m_tb;
reg  [35:0] m_exp;
wire CARRYOUT_tb ,CARRYOUTF_tb;
reg  CARRYOUT_exp;
wire [17:0] BCOUT_tb;
reg  [17:0] BCOUT_exp;
/////////////////////////////////
integer i;


/////////////////////////////////
Spartan6_DSP48A1 #(0,1,0,1,1,1,1,1,1,1,1,"OPMODE5","DIRECT","SYNC") 
dut(A,B,D,C,BCIN,CARRYIN,clk,OPMODE,PCIN,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,p_tb,PCOUT_tb,m_tb,CARRYOUT_tb,CARRYOUTF_tb,BCOUT_tb);
/////////////////////////////////
initial begin
/////////////////////////////////
clk=0;
forever 
  #1 clk=~clk ;
end 
////////////////////////////////
initial begin
RSTA=1;RSTB=1;RSTC=1;RSTCARRYIN=0;RSTD=1;RSTM=1;RSTOPMODE=1;RSTP=1;CEA=1;CEB=1;CEC=1;CECARRYIN=1;CED=1;CEM=1;CEOPMODE=1;CEP=1;
@(negedge clk);
RSTA=0;RSTB=0;RSTC=0;RSTCARRYIN=0;RSTD=0;RSTM=0;RSTOPMODE=0;RSTP=0;CEA=1;CEB=1;CEC=1;CECARRYIN=1;CED=1;CEM=1;CEOPMODE=1;CEP=1;
///////////////////////////////////////////////////////
OPMODE[7:2]=6'b000000;
for(i=0;i<1000;i=i+1)
begin
A=$random; B=$random; D=$random; C=$random; CARRYIN=$random; BCIN=$random; PCIN=$random;
 OPMODE[1:0]=$random;
if(OPMODE[1:0]==2'b00) begin    {CARRYOUT_exp,p_exp}={D[11:0],A[17:0],B[17:0]}+C  ;PCOUT_exp=p_exp;       m_exp=B*A; BCOUT_exp=B; end
if(OPMODE[1:0]==2'b01) begin    {CARRYOUT_exp,p_exp}= p_exp+C                   ;PCOUT_exp=p_exp;       m_exp=B*A; BCOUT_exp=B; end
if(OPMODE[1:0]==2'b10) begin    {CARRYOUT_exp,p_exp}=( A*B)+C                     ;PCOUT_exp=p_exp;       m_exp=B*A; BCOUT_exp=B;  end
if(OPMODE[1:0]==2'b11) begin    {CARRYOUT_exp,p_exp}= C                           ;PCOUT_exp=p_exp;       m_exp=B*A; BCOUT_exp=B;  end
@(negedge clk);
end
$stop;
///////////////////////////////////////////////////////
OPMODE[7:4]=4'b0000;
OPMODE[1:0]=2'b00;
for(i=0;i<1000;i=i+1)
begin
A=$random; B=$random; D=$random; C=$random; CARRYIN=$random; BCIN=$random; PCIN=$random;
OPMODE[3:2]=$random;
if(OPMODE[3:2]==2'b00) begin    {CARRYOUT_exp,p_exp}=({D[11:0],A[17:0],B[17:0]})+ C     ;PCOUT_exp=p_exp; m_exp=B*A;BCOUT_exp=B;  end 
if(OPMODE[3:2]==2'b01) begin    {CARRYOUT_exp,p_exp}=({D[11:0],A[17:0],B[17:0]})+p_exp  ;PCOUT_exp=p_exp; m_exp=B*A;BCOUT_exp=B;  end
if(OPMODE[3:2]==2'b10) begin    {CARRYOUT_exp,p_exp}=C                                  ;PCOUT_exp=p_exp; m_exp=A*B;BCOUT_exp=B;  end
if(OPMODE[3:2]==2'b11) begin    {CARRYOUT_exp,p_exp}=({D[11:0],A[17:0],B[17:0]})        ;PCOUT_exp=p_exp; m_exp=B*A;BCOUT_exp=B;  end
@(negedge clk);
end
$stop;
///////////////////////////////////////////////////////
OPMODE[7:6]=2'b00;
OPMODE[3:0]=4'b0000;
for(i=0;i<1000;i=i+1)
begin
A=$random; B=$random; D=$random; C=$random; CARRYIN=$random; BCIN=$random; PCIN=$random;
OPMODE[5:4]=$random;
if(OPMODE[5:4]==2'b00) begin    {CARRYOUT_exp,p_exp}={D[11:0],A[17:0],B[17:0]}+C            ;PCOUT_exp=p_exp; m_exp=B*A;     BCOUT_exp=B  ;      end 
if(OPMODE[5:4]==2'b01) begin    {CARRYOUT_exp,p_exp}={D+B[11:0],A[17:0],B[17:0]}+PCIN       ;PCOUT_exp=p_exp; m_exp=(D+B)*A; BCOUT_exp=B+D;      end
if(OPMODE[5:4]==2'b10) begin    {CARRYOUT_exp,p_exp}={D[11:0],A[17:0],B[17:0]}+C+1          ;PCOUT_exp=p_exp; m_exp=B*A;     BCOUT_exp=B  ;      end
if(OPMODE[5:4]==2'b11) begin    {CARRYOUT_exp,p_exp}={D+B[11:0],A[17:0],B[17:0]}+PCIN+1     ;PCOUT_exp=p_exp; m_exp=(D+B)*A; BCOUT_exp=B+D;      end
@(negedge clk); 
end
$stop;
///////////////////////////////////////////////////////
OPMODE[5:0]=6'b000000;
for(i=0;i<1000;i=i+1)
begin
A=$random; B=$random; D=$random; C=$random; CARRYIN=$random; BCIN=$random; PCIN=$random; 
OPMODE[7:6]=$random;  
if(OPMODE[7:6]==2'b00) begin    {CARRYOUT_exp,p_exp}= (C)+({D[11:0],A[17:0],B[17:0]})       ;PCOUT_exp=p_exp; m_exp= B*A ;           BCOUT_exp=B;        end 
if(OPMODE[7:6]==2'b01) begin    {CARRYOUT_exp,p_exp}= (C)+({D[11:0],A[17:0],B[17:0]})       ;PCOUT_exp=p_exp; m_exp= B*A ;           BCOUT_exp=B;        end
if(OPMODE[7:6]==2'b10) begin    {CARRYOUT_exp,p_exp}= (C)-({D[11:0],A[17:0],B[17:0]})       ;PCOUT_exp=p_exp; m_exp= B*A ;           BCOUT_exp=B;        end
if(OPMODE[7:6]==2'b11) begin    {CARRYOUT_exp,p_exp}= (C)-({D[11:0],A[17:0],B[17:0]})       ;PCOUT_exp=p_exp; m_exp= B*A ;           BCOUT_exp=B;        end
@(negedge clk); 
end
$stop;
end
endmodule 
















