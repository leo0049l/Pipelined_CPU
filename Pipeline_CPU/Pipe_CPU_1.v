//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
        clk_i,
		rst_n
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_n;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
wire [31:0]pc_out;
wire [31:0]instr;
wire [31:0]IF_IDinstr;
wire [31:0]pc_four;
wire [31:0]pc_next;
/**** ID stage ****/
wire [31:0]RS_Data;
wire [31:0]RT_Data;
wire [31:0]extend;
wire [31:0]ID_pc;
//control signal
wire PCwrite;
wire IFIDwrite;
wire Decode2zero;

/**** EX stage ****/
wire [31:0] EXRS_Data;
wire [31:0] EXRT_Data;
wire [31:0] EXextend;
wire [4:0] EXRT;
wire [4:0] EXRD;
wire [4:0] EXRS;
wire [31:0] ALUinput;
wire [4:0] Regdst;
wire [5:0] ALUctrl;
wire zero;
wire [31:0]result;
wire [1:0]forwardingA;
wire [1:0]forwardingB;
wire [31:0] forward_oA;
wire [31:0] forward_oB;
wire [10:0]	decode3;
wire [31:0] EX_pc;
wire [31:0] EXextend_left;
wire [31:0] EX_branch_pc;

//control signal
wire    instr_op;
wire	 funct;

wire	RegWrite;
wire [3:0]	ALU_op;
wire	ALUSrc;
wire	RegDst;
wire	Branch;
wire	MemRead;
wire   MemWrite;
wire	MemtoReg;
wire  [10:0] Decode;
wire  [10:0] EXDecode;
wire  [10:0] Decode2;
assign Decode={RegWrite,ALU_op[3:0],ALUSrc,RegDst,Branch,MemRead,MemWrite,MemtoReg};
assign Decode2=(IF_IDinstr==0)?0:Decode;
/**** MEM stage ****/
wire MEMzero;
wire [31:0] MEMresult;
wire [31:0] MEMRT_Data;
wire [31:0] MEMRegdst;
wire [31:0] Data;
wire [31:0] MEM_branch_pc;
//control signal
wire [10:0] MEMDecode;

/**** WB stage ****/
wire [31:0] WBData;
wire [31:0] WBresult;
wire [4:0]  WBRegdst;
wire [31:0] WBwrite; 
//control signal
wire [10:0] WBDecode;

/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
PC PC(.clk_i(clk_i),
	.rst_i(rst_n),
	.pc_in_i(pc_next),
	.pc_out_o(pc_out),
	.pc_write(PCwrite)
        );

Instr_Memory IM(.pc_addr_i(pc_out),
	.instr_o(instr)
	    );
			
Adder Add_pc(.src1_i(pc_out),
	.src2_i(32'd4),
	.sum_o(pc_four)
		);

		
Pipe_RegIDIF #(.size(32)) IF_ID(.rst_i(rst_n),  //-------------------------------------
			.clk_i(clk_i),   
			.data_i(instr),
			.data_o(IF_IDinstr),
			.IFIDwrite(IFIDwrite)
		); 


Pipe_RegIDIF #(.size(32)) IF_ID_pc(.rst_i(rst_n),  //*********************************
			.clk_i(clk_i),   
			.data_i(pc_four),
			.data_o(ID_pc),
			.IFIDwrite(IFIDwrite)
		); 





		
//Instantiate the components in ID stage
Reg_File RF(.clk_i(clk_i),
	.rst_n(rst_n),
   .RSaddr_i(IF_IDinstr[25:21]),
   .RTaddr_i(IF_IDinstr[20:16]),
   .RDaddr_i(WBRegdst),
   .RDdata_i(WBwrite),
   .RegWrite_i(WBDecode[10]),
   .RSdata_o(RS_Data),
   .RTdata_o(RT_Data)
		);

Decoder Control(.instr_op_i(IF_IDinstr[31:26]),
	 .funct_i(IF_IDinstr[5:0]),
	.RegWrite_o(RegWrite),
	.ALU_op_o(ALU_op),
	.ALUSrc_o(ALUSrc),
	.RegDst_o(RegDst),
	.Branch_o(Branch),
	.MemRead_o(MemRead),
   .MemWrite_o(MemWrite),
	.MemtoReg_o(MemtoReg)
		);

Sign_Extend Sign_Extend(.data_i(IF_IDinstr[15:0]),
    .data_o(extend)
		);	

Pipe_Reg #(.size(32)) ID_EX1(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(RS_Data),
			.data_o(EXRS_Data)
		);

Pipe_Reg #(.size(32)) ID_EX2(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(RT_Data),
			.data_o(EXRT_Data)
		);

Pipe_Reg #(.size(32)) ID_EX3(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(extend),
			.data_o(EXextend)
		);

Pipe_Reg #(.size(5)) ID_EX4(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(IF_IDinstr[20:16]),
			.data_o(EXRT)
		);
Pipe_Reg #(.size(5)) ID_EX7(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(IF_IDinstr[25:21]),
			.data_o(EXRS)
		);

Pipe_Reg #(.size(5)) ID_EX5(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(IF_IDinstr[15:11]),
			.data_o(EXRD)
		);	

Pipe_Reg #(.size(11)) ID_EX6(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(decode3),
			.data_o(EXDecode)
		);			


Pipe_Reg #(.size(32)) ID_EX8(.rst_i(rst_n),//*************************
			.clk_i(clk_i),   
			.data_i(ID_pc),
			.data_o(EX_pc)
		);			
		
//Instantiate the components in EX stage	   
ALU ALU(.src1_i(forward_oA),
	.src2_i(forward_oB),
	.ctrl_i(ALUctrl),
	.result_o(result),
	.zero_o(zero)//,
	//.sha()
		);
		
ALU_Control ALU_Control(.funct_i(EXextend[5:0]),
          .ALUOp_i(EXDecode[9:6]),
          .ALUCtrl_o(ALUctrl)
		);

MUX_2to1 #(.size(32)) Mux1(.data0_i(EXRT_Data),
               .data1_i(EXextend),
               .select_i(EXDecode[5]),
               .data_o(ALUinput)
        );
		  
MUX_2to1 #(.size(5)) Mux2(.data0_i(EXRT),
               .data1_i(EXRD),
               .select_i(EXDecode[4]),
               .data_o(Regdst)
        );
		  
/*MUX_3to1 #(.size(32)) Mux3(.data0_i(),
               .data1_i(),
					.data2_i(),
               .select_i(),
               .data_o()
        );
*/		  

Pipe_Reg #(.size(1)) EX_MEM1(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(zero),
			.data_o(MEMzero)
		);

Pipe_Reg #(.size(32)) EX_MEM2(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(result),
			.data_o(MEMresult)
		);

Pipe_Reg #(.size(32)) EX_MEM3(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(EXRT_Data),
			.data_o(MEMRT_Data)
		);

Pipe_Reg #(.size(5)) EX_MEM4(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(Regdst),
			.data_o(MEMRegdst)
		);	

Pipe_Reg #(.size(11)) EX_MEM5(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(EXDecode),
			.data_o(MEMDecode)
		);		
Pipe_Reg #(.size(32)) EX_MEM6(.rst_i(rst_n),//***********************
			.clk_i(clk_i),   
			.data_i(EX_branch_pc),
			.data_o(MEM_branch_pc)
		);			
			   
//Instantiate the components in MEM stage
Data_Memory DM(.clk_i(clk_i),
	.addr_i(MEMresult),
	.data_i(MEMRT_Data),
	.MemRead_i(MEMDecode[2]),
	.MemWrite_i(MEMDecode[1]),
	.data_o(Data)
	    );

Pipe_Reg #(.size(32)) MEM_WB1(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(Data),
			.data_o(WBData)      
		);

Pipe_Reg #(.size(32)) MEM_WB2(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(MEMresult),
			.data_o(WBresult)
		);

Pipe_Reg #(.size(5)) MEM_WB3(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(MEMRegdst),
			.data_o(WBRegdst)
		);
		
Pipe_Reg #(.size(11)) MEM_WB4(.rst_i(rst_n),
			.clk_i(clk_i),   
			.data_i(MEMDecode),
			.data_o(WBDecode)
		);
//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3( .data0_i(WBresult),
               .data1_i(WBData),
               .select_i(WBDecode[0]),
               .data_o(WBwrite)
        );
		
		
//------------------------------------------------------------------		
		
		
forwarding_unit	FU(.EXRS(EXRS),
				.EXRT(EXRT),
				.MEMRD(MEMRegdst),
				.WBRD(WBRegdst),
				.ForwardingA(forwardingA),
				.ForwardingB(forwardingB),
				.MEMDecode(MEMDecode),
				.WBDecode(WBDecode)
		);
MUX_3to1 #(.size(32)) Mux4( .data0_i(EXRS_Data),		//forwardingA
               .data1_i(MEMresult),
			   .data2_i(WBwrite),
               .select_i(forwardingA),
               .data_o(forward_oA)
		);

MUX_3to1 #(.size(32)) Mux5( .data0_i(ALUinput),		//forwardingB
               .data1_i(MEMresult),
			   .data2_i(WBwrite),
               .select_i(forwardingB), 
               .data_o(forward_oB)
		);
		
//---------------------------------------------------------------------------		
		
		
Hazard_detect	HDU(.IDRS(IF_IDinstr[25:21]),
					.IDRT(IF_IDinstr[20:16]),
					.EXDecode(EXDecode),
					.EXRT(EXRT),
					.PCwrite(PCwrite),
					.IFIDwrite(IFIDwrite),
					.Decode2zero(Decode2zero)
					);
MUX_2to1 #(.size(11)) Mux6(.data0_i(Decode2),  //hazard decode control
               .data1_i(0),
               .select_i(Decode2zero),
               .data_o(decode3)
        );
		  
Adder pc_branch(.src1_i(EX_pc),
	.src2_i(EXextend_left),
	.sum_o(EX_branch_pc)
		);
Shift_Left_Two_32	 Shift(.data_i(EXextend),
    .data_o(EXextend_left)
	 );

MUX_2to1 #(.size(32)) Mux7(.data0_i(pc_four),  //hazard decode control
               .data1_i(MEM_branch_pc),
               .select_i(MEMDecode[3]&&MEMzero),
               .data_o(pc_next)
        );
/****************************************
signal assignment
****************************************/	
endmodule

