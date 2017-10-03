//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;
wire    [15:0] one;
wire    [15:0] zero;  
assign one=16'b1111111111111111;
assign zero=16'd0;
//Sign extended
always@(*)
begin
 if(data_i[15]==0)
 begin
 data_o[31:16]<=zero;
 data_o[15:0]<=data_i;
 end
 else
 begin
 data_o[31:16]<=one;
 data_o[15:0]<=data_i;
 end
end
          
endmodule      
     