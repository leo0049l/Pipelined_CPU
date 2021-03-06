//Subject:     CO project 4 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_RegIDIF(
            rst_i,
			clk_i,   
			data_i,
			data_o,
			IFIDwrite
);
					
parameter size = 0;
input 					 IFIDwrite;
input                    rst_i;
input                    clk_i;		  
input      [size-1: 0] data_i;
output reg [size-1: 0] data_o;
	  
always @(posedge clk_i or negedge  rst_i) begin
	if( rst_i == 0) data_o <= 0;
	else if (IFIDwrite) data_o <=data_o;
    else data_o <= data_i;
end

endmodule	