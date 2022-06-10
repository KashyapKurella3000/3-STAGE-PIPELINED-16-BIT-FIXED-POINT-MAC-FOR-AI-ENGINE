module keyboardScanner (input clk, input wire [3:0] col,output reg [3:0] row, output reg [3:0] keyHex);
reg [1:0] state=2'b00;
reg [1:0] nextState=2'b00;
reg [7:0] keyCode;
//state register
always @(posedge clk)  begin 
    state <= nextState;
end
//keyHexput CL
always@(posedge clk) begin
    case (state)
    2'b00: row <= 4'b1110;
    2'b01: row <= 4'b1101;
    2'b10: row <= 4'b1011;
    2'b11: row <= 4'b0111;
    default: row <= 4'b1110;
  endcase
    if (col != 4'b0000) begin
    keyCode <= {row[3],row[2],row[1],row[0],col[3],col[2],col[1],col[0]};
    case(keyCode)
      8'h77: keyHex=4'h1;
      8'h7B: keyHex=4'h4;
      8'h7D: keyHex=4'h7;
      8'h7E: keyHex=4'hF;
      8'hB7: keyHex=4'h2;
      8'hBB: keyHex=4'h5;
      8'hBD: keyHex=4'h8;
      8'hBE: keyHex=4'h0;
      8'hD7: keyHex=4'h3;
      8'hDB: keyHex=4'h6;
      8'hDD: keyHex=4'h9;
      8'hDE: keyHex=4'hE;
      8'hE7: keyHex=4'hA;
      8'hEB: keyHex =4'hB; 
      8'hED: keyHex =4'hC;
      8'hEE: keyHex=4'hD;
		endcase	 
    end
end

//next state CL
always @(posedge clk) begin
        case (state)
            2'b00: nextState <=2'b01;
            2'b01: nextState <= 2'b10;
            2'b10: nextState <=2'b11;
            2'b11: nextState <=2'b00;
            default: nextState <=2'b00;
        endcase
end

endmodule
