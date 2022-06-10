module demux(input select_signal,output reg select_output1,select_output2);
	always @* begin 
		if(select_signal==1'b1) select_output1 <= 1'b1; 
		else select_output1 <= 1'b0;
	select_output2 <= ~select_output1; 
	end	
endmodule
