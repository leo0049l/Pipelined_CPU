//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	 funct_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	MemRead_o,
   MemWrite_o,
//	Jump_o,
	MemtoReg_o,
//	JalSelect_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
inout  [6-1:0] funct_i;

output         RegWrite_o;
output [4-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         MemRead_o;
output         MemWrite_o;
//output         Jump_o;
output   [1:0]      MemtoReg_o;
//output         JalSelect_o;
//Internal Signals
reg    [4-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg            MemRead_o;
reg            MemWrite_o;
//reg            Jump_o;
reg     [1:0]       MemtoReg_o;
//reg            JalSelect_o;
//Parameter


//Main function
always@(*)
begin
if(instr_op_i==6'b000000 && funct_i==6'b001000)//R TYPE(JR) 0
begin
 RegDst_o <= 1'b1;
 ALU_op_o <= 4'b0010;//2
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b1;
 MemtoReg_o <= 1'b0;
// JalSelect_o <= 1'b0;
end
else if(instr_op_i==6'b000000 && funct_i!=6'b001000)//R TYPE(MUL and others) 0
begin
 RegDst_o <= 1'b1;
 ALU_op_o <= 4'b0010;//2
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
// JalSelect_o <= 1'b0;
end
else if(instr_op_i==6'b001000)//ADDI 8
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b0000;//0
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b001010)//SLTI 10
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b0100;//4
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
 //Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b000100)//BEQ 4
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b0001;//1
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b1;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
// JalSelect_o <= 1'b0;
end
else if(instr_op_i==6'b000101)//BNE 5
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b0101;//5
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b1;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b001101)//ORI 13
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b0111;//7
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b001111)//LUI 15
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b0011;//3
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0; 
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b100011)//LW 35
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1000;//8
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b1;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b1;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b101011)//SW 43
begin
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1001;//9
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b1;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end 
else if(instr_op_i==6'b000010)//JUMP 2
begin 
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1011;//11
 ALUSrc_o <= 1'b1;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b1;
 MemtoReg_o <= 1'b0;
//JalSelect_o <= 1'b0; 
end
else if(instr_op_i==6'b000111)//BGT 7
begin 
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1100;//12
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b1;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
// Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
// JalSelect_o <= 1'b0;
end
else if(instr_op_i==6'b000101)//BNEZ 37
begin 
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1101;//13
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b1;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
 //Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
// JalSelect_o <= 1'b0;
end
else if(instr_op_i==6'b000001)//BGEZ 1
begin 
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1110;//14
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b0;
 Branch_o <= 1'b1;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
 //Jump_o <= 1'b0;
 MemtoReg_o <= 1'b0;
 //JalSelect_o <= 1'b0;
end
else if(instr_op_i==6'b000011)//JAL 3
begin 
 RegDst_o <= 1'b0;
 ALU_op_o <= 4'b1111;//15
 ALUSrc_o <= 1'b0;
 RegWrite_o <= 1'b1;
 Branch_o <= 1'b0;
 MemRead_o <= 1'b0;
 MemWrite_o <= 1'b0;
 //Jump_o <= 1'b1;
 MemtoReg_o <= 1'b0;
 //JalSelect_o <= 1'b1;
end
end
endmodule





                    
                    