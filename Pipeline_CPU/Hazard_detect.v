module Hazard_detect(IDRS,IDRT,EXDecode,EXRT,PCwrite,IFIDwrite,Decode2zero);
input [4:0] IDRS;
input [4:0] IDRT;
input [10:0] EXDecode;
input [4:0] EXRT;
output reg PCwrite;
output reg IFIDwrite;
output reg Decode2zero;



always @(*) begin
if((IDRS==EXRT||IDRT==EXRT)&&EXDecode[2])	begin
PCwrite<=1;
IFIDwrite<=1;
Decode2zero<=1;
end
else	begin
PCwrite<=0;
IFIDwrite<=0;
Decode2zero<=0;
end
end

endmodule
