module clock_counter_2(input clk,output reg clk_1); 

initial begin 
	clk_1 = 0; 
end
reg [25:0] counter = 0;  

always @(posedge clk) begin 

	counter = counter +1; 
	if(counter==26'h3FFFFFFF) begin 
		clk_1 =~clk_1;
		counter=0;
	end
end
endmodule
