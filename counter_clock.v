module clock_counter(input clk ,output reg clk_1); 

initial begin 
	clk_1 = 0; 
end
integer i =0; 
 
always @(posedge clk) begin 

	i = i+1; 
	if(i==6553600) begin 
		clk_1 =~clk_1;
		i=0;
	end
end	
endmodule
