//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o//,
	//sha
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [5-1:0]   ctrl_i;
//input [4:0] sha;
output [32-1:0]  result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
reg [31:0] r;
//Main function
/*your code here*/
assign zero_o=(result_o==0)?1:0;
always@(*)
begin
if(ctrl_i==0)
r<=src1_i&src2_i;
else if(ctrl_i==1)
r<=src1_i|src2_i;
else if(ctrl_i==2)
r<=src1_i+src2_i;
else if(ctrl_i==6)
r<=src1_i-src2_i;
else if(ctrl_i==12)
r<=src1_i|{{16{0}},src2_i[15:0]};
else if(ctrl_i==13)
r<=src2_i<<16;
else if(ctrl_i==7)
r<=src1_i+(~src2_i)+1;
else if(ctrl_i==8)
r<=src1_i+(~src2_i)+1;
else if(ctrl_i==9)
r<=src1_i+(~src2_i)+1;
else if(ctrl_i==10)
r<=src1_i+(~src2_i)+1;
else if(ctrl_i==11)
r<=src1_i+(~src2_i)+1;
else if(ctrl_i==14)//bne
r<=src1_i-src2_i;
else if(ctrl_i==3)
r<=src1_i*src2_i;
//else if(ctrl_i==5)//SLL
//r<=src2_i<<sha;
else if(ctrl_i==15)//SR
r<=src2_i>>src1_i;
else if(ctrl_i==21)//BGT
r<=(src1_i>src2_i)?0:1;
else if(ctrl_i==22)//BNEZ
r<=(src1_i!=0)?0:1;
else if(ctrl_i==23)//BGEZ
r<=(src1_i>=0)?0:1;
else if(ctrl_i==24)//JAL
r<=0;
else if(ctrl_i==17)//JR
r<=1;
end

always@(*)
begin
if(ctrl_i==7)
result_o<=r[31];
else if(ctrl_i==21)
result_o<=r;

else if(ctrl_i==8)
begin 
if((r[31]|(r==0))==1)
result_o<=0;
else
result_o<=1;
end
else if(ctrl_i==9)
result_o<=(r[31]|(r==0));
else if(ctrl_i==10)
begin
if(r[31]==0)result_o<=1;
else result_o<=0;
end
else if(ctrl_i==11)
begin
if(r==0)result_o<=1;
else result_o<=0;
end
else if(ctrl_i==14)//bne
begin
if(r==0)result_o<=1;
else result_o<=0;
end
else
result_o<=r;
end
endmodule





                    
                    