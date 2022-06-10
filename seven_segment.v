module seven_segment_display(input [3:0] number ,output reg [7:0] pattern_display ); 
always @*
begin 
		case(number)
			4'h0: pattern_display <= 8'b11000000;
			4'h1: pattern_display <= 8'b11111001;
			4'h2: pattern_display <= 8'b10100100;
			4'h3: pattern_display <= 8'b10110000;
			4'h4: pattern_display <= 8'b10011001;
			4'h5: pattern_display <= 8'b10010010; 
			4'h6: pattern_display <= 8'b10000010;
			4'h7: pattern_display <= 8'b11111000;
			4'h8: pattern_display <= 8'b10000000;
			4'h9: pattern_display <= 8'b10011000;
			4'hA: pattern_display <= 8'b10001000;
			4'hB: pattern_display <= 8'b10000011;
			4'hC: pattern_display <= 8'b11000110;
			4'hD: pattern_display <= 8'b10100001;
			4'hE: pattern_display <= 8'b10000110;
			4'hF: pattern_display <= 8'b10001110;
			default: pattern_display <= 8'b11000000;
		endcase
end
endmodule