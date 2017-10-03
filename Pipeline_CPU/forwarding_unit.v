module	forwarding_unit(EXRS,EXRT,MEMRD,WBRD,ForwardingA,ForwardingB,MEMDecode,WBDecode);

input	[4:0]EXRS;
input	[4:0]EXRT;
input	[4:0]MEMRD;
input	[4:0]WBRD;
input	[10:0]MEMDecode;
input	[10:0]WBDecode;
output reg[1:0]ForwardingA;
output reg[1:0]ForwardingB;



always	@(*)begin	//ForwardingA
if(EXRS==MEMRD&&MEMDecode[10])begin   //MEMfor
ForwardingA<=1;
end
else if (EXRS==WBRD&&WBDecode[10])begin //WBfor
ForwardingA<=2;
end
else	ForwardingA<=0;
end

always	@(*)begin	//ForwardingB
if(EXRT==MEMRD&&MEMDecode[10])begin
ForwardingB<=1;
end
else if (EXRT==WBRD&&WBDecode[10])begin
ForwardingB<=2;
end
else	ForwardingB<=0;
end

endmodule