module sram(input Cs_b, We_b, Oe_b,input [2:0] address,input [15:0] data_in, output  [15:0]data_out);
reg [15:0] ram_1[8:0];
assign data_out = (Cs_b == 0 && Oe_b ==0) ? ram_1[address]: 16'bz;
always @(*) begin 
	if(Cs_b==0 && We_b ==0) begin 
		ram_1[address]<=data_in;
	end
end
endmodule 
