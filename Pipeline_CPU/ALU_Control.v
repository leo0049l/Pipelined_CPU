//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Control(
          funct_i,
          ALUOp_i,
          ALUCtrl_o//,
			// JRSelect_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;
//output              JRSelect_o;
output     [5-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [5-1:0] ALUCtrl_o;
//reg              JRSelect_o;
//Parameter


       
//Select exact operation
always@(*)
begin
 if(ALUOp_i==4'b0000)//ADDI
  begin
   ALUCtrl_o<=5'b0010;
  end
 else if(ALUOp_i==4'b0001)//BEQ
  begin
   ALUCtrl_o<=5'b0110;
  end
 else if(ALUOp_i==4'b0010) //R -------------------
  begin
   if(funct_i==6'b000000)
	ALUCtrl_o<=5'b00101;//SHIFT LEFT
	else if(funct_i==6'b100000)
	ALUCtrl_o<=5'b00010;//ADD
   else if(funct_i==6'b100010)
   ALUCtrl_o<=5'b00110;//SUB
   else if(funct_i==6'b100100)
   ALUCtrl_o<=5'b00000;//AND
   else if(funct_i==6'b100101)
   ALUCtrl_o<=5'b00001;//OR
   else if(funct_i==6'b101010)
	ALUCtrl_o<=5'b00111;//SLT
	else if(funct_i==6'b000110)
	ALUCtrl_o<=5'b01111;//SHIFT RIGHT
   else if(funct_i==6'b011000)
   ALUCtrl_o<=5'b00011;// MUL(*)
   else if(funct_i==6'b001000)
   ALUCtrl_o<=5'b10001;// JR(*)
   end 
  //---------------------------------------------------------
   else if(ALUOp_i==4'b0011)
 	ALUCtrl_o<=5'b01101;//LUI
   else if(ALUOp_i==4'b0101)
   ALUCtrl_o<=5'b01110;//BNE 
   else if(ALUOp_i==4'b0111)
   ALUCtrl_o<=5'b01100;//ORI
   else if(ALUOp_i==4'b0100)
   ALUCtrl_o<=5'b00111;//SLT
   else if(ALUOp_i==4'b1011)
   ALUCtrl_o<=5'b10100;//JUMP(*)
   else if(ALUOp_i==4'b1100)
   ALUCtrl_o<=5'b10101;//BGT(*)
   else if(ALUOp_i==4'b1101)
   ALUCtrl_o<=5'b10110;//BNEZ(*)
   else if(ALUOp_i==4'b1110)
   ALUCtrl_o<=5'b10111;//BGEZ(*)
   else if(ALUOp_i==4'b1111)
   ALUCtrl_o<=5'b11000;//JAL(*)
	else if(ALUOp_i==4'b1000)
	ALUCtrl_o<=5'b00010;//LW(*)
	else if(ALUOp_i==4'b1001)
	ALUCtrl_o<=5'b00010;//SW(*)
  
end
/*
always@(*)
begin
if(ALUOp_i==4'b0010 && funct_i==6'b001000)
JRSelect_o <=1;
else
JRSelect_o <=0;
end
*/
endmodule     





                    
     

                    
                    