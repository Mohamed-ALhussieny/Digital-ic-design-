module Spartan6_DSP48A1(A,B,D,C,BCIN,CARRYIN,clk1,OPMODE,PCIN,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,CEA
,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP,p,PCOUT,m,CARRYOUT,CARRYOUTF,BCOUT);
parameter A0REG=0;
parameter A1REG=1;
parameter B0REG=0;
parameter B1REG=1;
parameter CREG=1;
parameter DREG=1;
parameter MREG=1;
parameter PREG=1;
parameter CARRYINREG=1;
parameter CARRYOUTREG=1;
parameter OPMODEREG=1;
parameter CARRYINSEL="OPMODE5";
parameter B_INPUT="DIRECT";
parameter RSTTYPE="SYNC";
///////////////////////////////

input [17:0] A,B,D;
input [47:0] C;
input [17:0] BCIN;
input   CARRYIN;
input   clk1;
input [7:0] OPMODE ;
input [47:0] PCIN ;

input RSTA;
input RSTB;
input RSTC;
input RSTCARRYIN ;
input RSTD;
input RSTM;
input RSTOPMODE;
input RSTP;
input CEA;
input CEB;
input CEC;
input CECARRYIN;
input CED;
input CEM ;
input CEOPMODE;
input CEP;
///////////////////////////////
output [47:0] p,PCOUT;
output [35:0] m;
output CARRYOUT,CARRYOUTF;
output [17:0] BCOUT;
///////////////////////////////
//wire [47:0] pre;
wire [17:0] A_in,B_in,D_in,B_SELECT;
wire [47:0] C_in;
wire [17:0] PRE_OUT;
wire [17:0] ALU_Bin;
wire [17:0] MUL_IN1;
wire [17:0] MUL_IN2;
wire [35:0] MUL_OUT;
wire [35:0] MUL_OUT_IN;
wire [47:0] X;
wire [47:0] Z;
wire [47:0] POST_OUT;
wire [7:0] opcode_in;
wire CIN,CIN_IN;
wire CYO;
wire [7:0] OPMODE_in;
wire [47:0] concatination ;
///////////////////////////////
reg_mux #(8,OPMODEREG,RSTTYPE) opmode_reg(OPMODE,OPMODE_in,clk1,RSTOPMODE,CEOPMODE);
////////////////////////////////////////////////////////////////////////////////////
reg_mux #(18,DREG,RSTTYPE) D_reg(D,D_in,clk1,RSTD,CED);
mux #(B_INPUT,18) mux_b(B,BCIN,B_SELECT);
reg_mux #(18,B0REG,RSTTYPE) B_reg1(B_SELECT,B_in,clk1,RSTB,CEB);
reg_mux #(18,A0REG,RSTTYPE) A_reg1(A,A_in,clk1,RSTA,CEA);
reg_mux #(48,CREG,RSTTYPE) C_reg(C,C_in,clk1,RSTC,CEC);
////////////////////////////////////////////////////////////////////////////////////////////////
pre_adder_sub pre_add_sub(D_in,B_in,PRE_OUT,OPMODE_in[6]);
mux_adder_reg #(18) mux1(B_in,PRE_OUT,ALU_Bin,OPMODE_in[4]);
///////////////////////////////////////////////////////////////////////////////////////////
reg_mux #(18,B1REG,RSTTYPE) B_reg2(ALU_Bin,MUL_IN2,clk1,RSTB,CEB);
reg_mux #(18,A1REG,RSTTYPE) A_reg2(A_in,MUL_IN1,clk1,RSTA,CEA);
///////////////////////////////////////////////////////////////////////////////////////////
mul #(18) mul1(MUL_IN1,MUL_IN2,MUL_OUT);
reg_mux #(36,MREG,RSTTYPE) reg_mul(MUL_OUT,MUL_OUT_IN,clk1,RSTM,CEM);
//////////////////////////////////////////////////////////////////////////////////////////
mux #(CARRYINSEL,1) mux_cin(OPMODE_in[5],CARRYIN,CIN);
reg_mux #(1,CARRYINREG,RSTTYPE) Cyi_reg1(CIN,CIN_IN,clk1,RSTCARRYIN,CECARRYIN);
//////////////////////////////////////////////////////////////////////////////////////////
assign concatination = {D_in[11:0],A_in[17:0],B_in[17:0]};
 X_Z_mux #(48,48,36,1) x(concatination,p,MUL_OUT_IN,1'b0,OPMODE_in[1:0],X);
 X_Z_mux #(48,48,48,1) z(C_in,p,PCIN,1'b0,OPMODE_in[3:2],Z);
 ////////////////////////////////////////////////////////////////////////////////////////////
post_adder_sub post_add_sub(Z,X,POST_OUT,OPMODE_in[7],CIN_IN,CYO);
reg_mux #(48,PREG,RSTTYPE) p_reg(POST_OUT,p,clk1,RSTP,CEP);
/////////////////////////////////////////////////////////////////////////////////////////////
reg_mux #(1,CARRYOUTREG,RSTTYPE) cyo_reg(CYO,CARRYOUT,clk1,RSTCARRYIN,CECARRYIN);
////////////////////////////////////////////////////////////////////////////////////////////

assign  PCOUT=p;
assign  BCOUT =MUL_IN2 ;
assign  m= MUL_OUT_IN ;
assign  CARRYOUTF= CARRYOUT ;

endmodule



