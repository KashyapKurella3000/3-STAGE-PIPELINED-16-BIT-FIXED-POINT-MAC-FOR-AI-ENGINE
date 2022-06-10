module main_file(input clk,rst, next_trigger,input wire[3:0] col_driver, output reg [3:0] arduino_comm, output reg [7:0] tracker, output wire [3:0] row_driver, output reg [7:0] led,led1,led2,led3); 
parameter S0 = 7'h0;
parameter S1 = 7'h1;
parameter S2 = 7'h2;
parameter S3 = 7'h3;
parameter S4 = 7'h04;
parameter S5 = 7'h5;
parameter S6 = 7'h6;
parameter S7 = 7'h7;
parameter S8 = 7'h8;
parameter S9 = 7'h9;
parameter S10 = 7'ha;
parameter S11 = 7'hb;
parameter S12 = 7'hc;
parameter S13 = 7'hd;
parameter S14 = 7'he;
parameter S15 = 7'hf;
parameter S16 = 7'h10;
parameter S17 = 7'h11;
parameter S18 = 7'h12;
parameter S19 = 7'h13;
parameter S20 = 7'h14;
parameter S21 = 7'h15;
parameter S22 = 7'h16;
parameter S23 = 7'h17;
parameter S24 = 7'h18;
parameter S25 = 7'h19;
parameter S26 = 7'h1a;
parameter S27 = 7'h1b;
parameter S28 = 7'h1c;
parameter S29 = 7'h1d;
parameter S30 = 7'h1e;
parameter S31 = 7'h1f;
parameter S32 = 7'h20;
parameter S33 = 7'h21;
parameter S34 = 7'h22;
parameter S35 = 7'h23;
parameter S36 = 7'h24;
parameter S37 = 7'h25;
parameter S38 = 7'h26;
parameter S39 = 7'h27;
parameter S40 = 7'h28;
parameter S41 = 7'h29;
parameter S42 = 7'h2a;
parameter S43 = 7'h2b;
parameter S44 = 7'h2c;
parameter S45 = 7'h2d;
parameter S46 = 7'h2e;
parameter S47 = 7'h2f;
parameter S48 = 7'h30;
parameter S49 = 7'h31;
parameter S50 = 7'h32;
parameter S51 = 7'h33;
parameter S52 = 7'h34;
parameter S53 = 7'h35;
parameter S54  = 7'h36;
parameter S55 = 7'h37;
parameter S56 = 7'h38;
parameter S57 = 7'h39;
parameter S58 = 7'h3a;
parameter S59  = 7'h3b;
parameter S60 = 7'h3c;
parameter S61 = 7'h3d;
parameter S62 = 7'h3e;
parameter S63  =7'h3f;
parameter S64 = 7'h40;
parameter S65 = 7'h41; 
parameter S66 = 7'h42;
parameter S67 = 7'h43; 
parameter S68 = 7'h44; 
parameter S69 = 7'h45; 
parameter S70 = 7'h46; 
parameter S71 = 7'h47; 
parameter S72 = 7'h48; 
parameter S73 = 7'h49; 
parameter S74 = 7'h4A; 
parameter S75 = 7'h4B; 
parameter S76 = 7'h4C; 
parameter S77 = 7'h4D; 
parameter S78 = 7'h4E; 
parameter S79 = 7'h4F; 
parameter S80 = 7'h50; 
parameter S81 = 7'h51; 
parameter S82 = 7'h52; 
parameter S83 = 7'h53; 


reg [2:0] address;
reg [6:0] current_state,next_state = 0; 
reg [15:0] data_11,data_12,data_13,data_14,data_15,data_16,data_17,data_18;
reg [15:0] data_21,data_22,data_23,data_24,data_25,data_26,data_27,data_28;
reg [15:0] data_into_sram1,data_into_sram2;
reg write_enable,output_enable,select,mac_rst;
reg [15:0] op_data,op_data_1;
wire [15:0] result;
wire [3:0] data;
wire clk1,clk2;

wire [15:0] data_from_sram1,data_from_sram2;

wire chip_select_1,chip_select_2 ;
initial begin 
	write_enable = 1'b1;
	select = 1'b1; 
	output_enable = 1'b1;
	current_state = S0; 
	next_state = S0;  
	mac_rst = 1;
	address = 0;
end

clock_counter c1(clk,clk1);
clock_counter_2 c2(clk,clk2);

keyboardScanner k1(clk1,col_driver, row_driver,data);
demux d1(select,chip_select_1,chip_select_2); 


MAC_unit M1(clk1,mac_rst,op_data,op_data_1,result);
sram s1(chip_select_1,write_enable,output_enable,address,data_into_sram1,data_from_sram1);
sram s2(chip_select_2,write_enable,output_enable,address,data_into_sram2,data_from_sram2);
integer i =0;
always @(posedge clk2) begin 
	case(current_state)
	S0: begin
		data_11 = 0;
		data_12 = 0; 
		data_13 = 0; 
		data_14 = 0; 
		data_15 = 0; 
		data_16 = 0; 
		data_17 = 0; 
		data_18 = 0;
		data_21 =0;
		data_22 = 0;
		data_23 = 0;
		data_24 = 0;
		data_25 =0; 
		data_26= 0;
		data_27 = 0;
		data_28 =0; 
		arduino_comm = 4'h1; 
		next_state = S1;
	end
	S1: begin 
		data_11[15:4] = 0; 
		data_11[3:0] = data; 
		seven_segment_display(data_11[3:0],led);
		seven_segment_display(data_11[7:4],led1);
		seven_segment_display(data_11[11:8],led2);
		seven_segment_display(data_11[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S2; 
		tracker = 8'hFE;
	end
	S2: begin 
		data_11[15:8] = 0; 
		data_11[7:4] = data; 
		seven_segment_display(data_11[3:0],led);
		seven_segment_display(data_11[7:4],led1);
		seven_segment_display(data_11[11:8],led2);
		seven_segment_display(data_11[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S3; 
		tracker = 8'hFE;
	end
	S3: begin 
		data_11[15:12] = 0; 
		data_11[11:8] = data; 
		seven_segment_display(data_11[3:0],led);
		seven_segment_display(data_11[7:4],led1);
		seven_segment_display(data_11[11:8],led2);
		seven_segment_display(data_11[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S4; 
		tracker = 8'hFE;
	end
	S4: begin  
		data_11[15:12] = data; 
		seven_segment_display(data_11[3:0],led);
		seven_segment_display(data_11[7:4],led1);
		seven_segment_display(data_11[11:8],led2);
		seven_segment_display(data_11[15:12],led3);
		arduino_comm = 4'h2; 
		write_to_memory_1(16'h1);
		next_state = S5; 	
		tracker = 8'hFE;
	end
	S5:begin
		write_high_1(3'b000); 
		data_12[15:4] = 0; 
		data_12[3:0] = data; 
		seven_segment_display(data_12[3:0],led);
		seven_segment_display(data_12[7:4],led1);
		seven_segment_display(data_12[11:8],led2);
		seven_segment_display(data_12[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S6;
		tracker = 8'hFD;
	end
	S6: begin 
		close_write;
		data_12[15:8] = 0; 
		data_12[7:4] = data; 
		seven_segment_display(data_12[3:0],led);
		seven_segment_display(data_12[7:4],led1);
		seven_segment_display(data_12[11:8],led2);
		seven_segment_display(data_12[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S7; 
		tracker = 8'hFD;
	end
	S7: begin 
		data_12[15:12] = 0; 
		data_12[11:8] = data; 
		seven_segment_display(data_12[3:0],led);
		seven_segment_display(data_12[7:4],led1);
		seven_segment_display(data_12[11:8],led2);
		seven_segment_display(data_12[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S8;
		tracker = 8'hFD;		
	end
	S8: begin 
		data_12[15:12] = data; 
		seven_segment_display(data_12[3:0],led);
		seven_segment_display(data_12[7:4],led1);
		seven_segment_display(data_12[11:8],led2);
		seven_segment_display(data_12[15:12],led3);
		write_to_memory_1(data_12);
		arduino_comm = 4'h2;
		next_state = S9; 	
		tracker = 8'hFD;
	end
	S9: begin 
		write_high_1(3'b001);
		data_13[15:4] = 0; 
		data_13[3:0] = data; 
		seven_segment_display(data_13[3:0],led);
		seven_segment_display(data_13[7:4],led1);
		seven_segment_display(data_13[11:8],led2);
		seven_segment_display(data_13[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S10; 
		tracker = 8'hFB;
	end
	S10: begin 
		close_write; 
		data_13[15:8] = 0; 
		data_13[7:4] = data; 
		seven_segment_display(data_13[3:0],led);
		seven_segment_display(data_13[7:4],led1);
		seven_segment_display(data_13[11:8],led2);
		seven_segment_display(data_13[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S11; 
		tracker = 8'hFB;	
	end
	S11: begin 
		data_13[15:12] = 0; 
		data_13[11:8] = data; 
		seven_segment_display(data_13[3:0],led);
		seven_segment_display(data_13[7:4],led1);
		seven_segment_display(data_13[11:8],led2);
		seven_segment_display(data_13[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S12; 
		tracker = 8'hFB;	
	end
	S12: begin 
		data_13[15:12] = data; 
		seven_segment_display(data_13[3:0],led);
		seven_segment_display(data_13[7:4],led1);
		seven_segment_display(data_13[11:8],led2);
		seven_segment_display(data_13[15:12],led3);
		arduino_comm = 4'h2;
		write_to_memory_1(data_13);
		next_state = S13;
		tracker = 8'hFB; 		
	end
	S13:begin 
		write_high_1(3'b010);
		data_14[15:4] = 0; 
		data_14[3:0] = data; 
		seven_segment_display(data_14[3:0],led);
		seven_segment_display(data_14[7:4],led1);
		seven_segment_display(data_14[11:8],led2);
		seven_segment_display(data_14[15:12],led3);
		arduino_comm = 4'h2;
		next_state = S14; 
		tracker = 8'hF7;		
	end
	S14: begin 
		close_write;
		data_14[15:8] = 0; 
		data_14[7:4] = data; 
		seven_segment_display(data_14[3:0],led);
		seven_segment_display(data_14[7:4],led1);
		seven_segment_display(data_14[11:8],led2);
		seven_segment_display(data_14[15:12],led3);
		arduino_comm = 4'h2;
		next_state = S15; 
		tracker = 8'hF7;	
	end
	S15: begin 
		data_14[15:12] = 0; 
		data_14[11:8] = data; 
		seven_segment_display(data_14[3:0],led);
		seven_segment_display(data_14[7:4],led1);
		seven_segment_display(data_14[11:8],led2);
		seven_segment_display(data_14[15:12],led3);
		arduino_comm = 4'h2;
		next_state = S16; 
		tracker = 8'hF7;		
	end
	S16: begin 
		data_14[15:12] = data; 
		seven_segment_display(data_14[3:0],led);
		seven_segment_display(data_14[7:4],led1);
		seven_segment_display(data_14[11:8],led2);
		seven_segment_display(data_14[15:12],led3);
		arduino_comm = 4'h2;
		next_state = S17;
		tracker = 8'hF7;
		write_to_memory_1(data_14);
	end
	S17: begin 
		write_high_1(3'b011);

		data_15[15:4] = 0;
		data_15[3:0] = data;
		seven_segment_display(data_15[3:0],led);
		seven_segment_display(data_15[7:4],led1);
		seven_segment_display(data_15[11:8],led2);
		seven_segment_display(data_15[15:12],led3);	
		arduino_comm = 4'h2;
		next_state = S18; 
		tracker = 8'hEF;
	end
	S18: begin 
		close_write;
		data_15[15:8] = 0; 
		data_15[7:4] = data; 
		seven_segment_display(data_15[3:0],led);
		seven_segment_display(data_15[7:4],led1);
		seven_segment_display(data_15[11:8],led2);
		seven_segment_display(data_15[15:12],led3);	
		arduino_comm = 4'h2;
		next_state = S19; 
		tracker = 8'hF7;	
	end
	S19: begin 
		data_15[15:12] = 0; 
		data_15[11:8] = data; 
		seven_segment_display(data_15[3:0],led);
		seven_segment_display(data_15[7:4],led1);
		seven_segment_display(data_15[11:8],led2);
		seven_segment_display(data_15[15:12],led3);	
		arduino_comm = 4'h2;
		next_state = S20; 
		tracker = 8'hF7;
		
	end
	S20: begin 
		data_15[15:12] = data; 
		seven_segment_display(data_15[3:0],led);
		seven_segment_display(data_15[7:4],led1);
		seven_segment_display(data_15[11:8],led2);
		seven_segment_display(data_15[15:12],led3);
		arduino_comm = 4'h2;
		next_state = S21;
		write_to_memory_1(data_15);
		tracker = 8'hF7;	
	end
	S21:begin 
		write_high_1(3'b100);
		data_16[15:4] = 0; 
		data_16[3:0] = data; 
		seven_segment_display(data_16[3:0],led);
		seven_segment_display(data_16[7:4],led1);
		seven_segment_display(data_16[11:8],led2);
		seven_segment_display(data_16[15:12],led3);	
		arduino_comm = 4'h2; 
		next_state = S22;
		tracker = 8'hF7;	
	end
	S22: begin 
		close_write;
		data_16[15:8] = 0; 
		data_16[7:4] = data; 
		seven_segment_display(data_16[3:0],led);
		seven_segment_display(data_16[7:4],led1);
		seven_segment_display(data_16[11:8],led2);
		seven_segment_display(data_16[15:12],led3);	
		arduino_comm = 4'h2; 
		next_state = S23; 
		tracker = 8'hDF;
	end
	S23: begin 
		data_16[15:12] = 0; 
		data_16[11:8] = data; 
		seven_segment_display(data_16[3:0],led);
		seven_segment_display(data_16[7:4],led1);
		seven_segment_display(data_16[11:8],led2);
		seven_segment_display(data_16[15:12],led3);	
		arduino_comm = 4'h2; 
		next_state = S24; 
		tracker = 8'hDF;
	end
	S24: begin 
		data_16[15:12] = data; 
		seven_segment_display(data_16[3:0],led);
		seven_segment_display(data_16[7:4],led1);
		seven_segment_display(data_16[11:8],led2);
		seven_segment_display(data_16[15:12],led3);

		write_to_memory_1(data_16);
		arduino_comm = 4'h2; 
		next_state = S25;
		tracker = 8'hDF;		
	end
	S25: begin 
		write_high_1(3'b101);
		data_17[15:4] = 0; 
		data_17[3:0] = data; 
		seven_segment_display(data_17[3:0],led);
		seven_segment_display(data_17[7:4],led1);
		seven_segment_display(data_17[11:8],led2);
		seven_segment_display(data_17[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S26; 
		tracker = 8'hBF;	
	end
	S26: begin 
		close_write;
		data_17[15:8] = 0; 
		data_17[7:4] = data; 
		seven_segment_display(data_17[3:0],led);
		seven_segment_display(data_17[7:4],led1);
		seven_segment_display(data_17[11:8],led2);
		seven_segment_display(data_17[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S27; 
		tracker = 8'hBF;
	end
	S27: begin 
		data_17[15:12]  = 0;
		data_17[11:8] = data; 
		seven_segment_display(data_17[3:0],led);
		seven_segment_display(data_17[7:4],led1);
		seven_segment_display(data_17[11:8],led2);
		seven_segment_display(data_17[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S28;
		tracker = 8'hBF;	
	end
	S28:begin 
		data_17[15:12] = data;
		seven_segment_display(data_17[3:0],led);
		seven_segment_display(data_17[7:4],led1);
		seven_segment_display(data_17[11:8],led2);
		seven_segment_display(data_17[15:12],led3);
		arduino_comm = 4'h2; 
		next_state = S29; 
		tracker = 8'hBF;
		write_to_memory_1(data_17);
	end
	S29: begin 
		write_high_1(3'b110);
		data_18[15:4] = 0;
		data_18[3:0] = data;
		seven_segment_display(data_18[3:0],led);
		seven_segment_display(data_18[7:4],led1);
		seven_segment_display(data_18[11:8],led2);
		seven_segment_display(data_18[15:12],led3);
		arduino_comm = 4'h2;	
		next_state = S30;	
		tracker = 8'h7F;	
	end
	S30: begin 
		close_write;
		data_18[15:8] = 0; 
		data_18[7:4] = data; 
		seven_segment_display(data_18[3:0],led);
		seven_segment_display(data_18[7:4],led1);
		seven_segment_display(data_18[11:8],led2);
		seven_segment_display(data_18[15:12],led3);
		arduino_comm = 4'h2;	
		next_state = S31;	
		tracker = 8'h7F;			
	end
	S31: begin
		data_18[15:12] = 0; 
		data_18[11:8] = data; 
		seven_segment_display(data_18[3:0],led);
		seven_segment_display(data_18[7:4],led1);
		seven_segment_display(data_18[11:8],led2);
		seven_segment_display(data_18[15:12],led3);
		arduino_comm = 4'h2;	
		next_state = S32;	
		tracker = 8'h7F;			
	end
	S32: begin 
		data_18[15:12] = data; 
		seven_segment_display(data_18[3:0],led);
		seven_segment_display(data_18[7:4],led1);
		seven_segment_display(data_18[11:8],led2);
		seven_segment_display(data_18[15:12],led3);

		write_to_memory_1(data_18);
		arduino_comm = 4'h2; 
		next_state = S33; 
		tracker = 8'h7F;	
	end
	S33: begin 
		write_high_1(3'b111); 
		arduino_comm = 4'h3; 
		data_21[15:4] = 0; 
		data_21[3:0] = data; 
		seven_segment_display(data_21[3:0],led);
		seven_segment_display(data_21[7:4],led1);
		seven_segment_display(data_21[11:8],led2);
		seven_segment_display(data_21[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S34; 
		tracker = 8'hFE;
	end
	S34: begin 
		close_write;
		arduino_comm = 4'h3; 
		data_21[15:8] = 0; 
		data_21[7:4] = data; 
		seven_segment_display(data_21[3:0],led);
		seven_segment_display(data_21[7:4],led1);
		seven_segment_display(data_21[11:8],led2);
		seven_segment_display(data_21[15:12],led3);
		next_state = S35; 
		tracker = 8'hFE;
	end
	S35: begin 
		data_21[15:12] = 0; 
		data_21[11:8] = data; 
		seven_segment_display(data_21[3:0],led);
		seven_segment_display(data_21[7:4],led1);
		seven_segment_display(data_21[11:8],led2);
		seven_segment_display(data_21[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S36;
		tracker = 8'hFE;	
	end
	S36:begin
		data_21[15:12] = data; 
		seven_segment_display(data_21[3:0],led);
		seven_segment_display(data_21[7:4],led1);
		seven_segment_display(data_21[11:8],led2);
		seven_segment_display(data_21[15:12],led3);
		next_state = S37; 
		arduino_comm = 4'h3;
		write_to_memory_2(data_21);
		tracker = 8'hFE;
	end
	S37: begin 
		write_high_2(3'b000);
		data_22[15:4] = 0; 
		data_22[3:0] = data; 
		seven_segment_display(data_22[3:0],led);
		seven_segment_display(data_22[7:4],led1);
		seven_segment_display(data_22[11:8],led2);
		seven_segment_display(data_22[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S38;
		tracker = 8'hFD;
	end
	S38: begin 
		close_write;
		data_22[15:8] = 0; 
		data_22[7:4] = data; 
		seven_segment_display(data_22[3:0],led);
		seven_segment_display(data_22[7:4],led1);
		seven_segment_display(data_22[11:8],led2);
		seven_segment_display(data_22[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S39;
		tracker = 8'hFD;
	end
	S39: begin 
		data_22[15:12] = 0; 
		data_22[11:8] = data; 
		seven_segment_display(data_22[3:0],led);
		seven_segment_display(data_22[7:4],led1);
		seven_segment_display(data_22[11:8],led2);
		seven_segment_display(data_22[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S40;
		tracker = 8'hFD;
	end
	S40: begin  
		data_22[15:12] = data; 
		seven_segment_display(data_22[3:0],led);
		seven_segment_display(data_22[7:4],led1);
		seven_segment_display(data_22[11:8],led2);
		seven_segment_display(data_22[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S41;
		
		write_to_memory_2(data_22);
		tracker = 8'hFD;
	end
	S41: begin 
		write_high_2(3'b001);	
		data_23[15:4] = 0; 
		data_23[3:0] = data; 
		seven_segment_display(data_23[3:0],led);
		seven_segment_display(data_23[7:4],led1);
		seven_segment_display(data_23[11:8],led2);
		seven_segment_display(data_23[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S42;	
		tracker = 8'hFB;	
	end
	S42: begin
		close_write; 
		data_23[15:8] = 0; 
		data_23[7:4] = data; 
		seven_segment_display(data_23[3:0],led);
		seven_segment_display(data_23[7:4],led1);
		seven_segment_display(data_23[11:8],led2);
		seven_segment_display(data_23[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S43;
		tracker = 8'hFB;
	end
	S43: begin 
		data_23[15:12] = 0; 
		data_23[11:8] = data; 
		seven_segment_display(data_23[3:0],led);
		seven_segment_display(data_23[7:4],led1);
		seven_segment_display(data_23[11:8],led2);
		seven_segment_display(data_23[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S44;
		tracker = 8'hFB;
	end
	S44:begin 
		data_23[15:12] = data; 
		seven_segment_display(data_23[3:0],led);
		seven_segment_display(data_23[7:4],led1);
		seven_segment_display(data_23[11:8],led2);
		seven_segment_display(data_23[15:12],led3);
		arduino_comm = 4'h3;
		next_state = S45;
		write_to_memory_2(data_23);
		
		tracker = 8'hFB;
	end
	S45: begin 
		write_high_2(3'b010);
		data_24[15:4] = 0; 
		data_24[3:0] = data; 
		seven_segment_display(data_24[3:0],led);
		seven_segment_display(data_24[7:4],led1);
		seven_segment_display(data_24[11:8],led2);
		seven_segment_display(data_24[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S46; 
		tracker = 8'hF7;
	end
	S46: begin 
		close_write;
		data_24[15:8] = 0; 
		data_24[7:4] = data; 
		seven_segment_display(data_24[3:0],led);
		seven_segment_display(data_24[7:4],led1);
		seven_segment_display(data_24[11:8],led2);
		seven_segment_display(data_24[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S47; 
		tracker = 8'hF7;
	end
	S47: begin 
		data_24[15:12] = 0; 
		data_24[11:8] = data; 
		seven_segment_display(data_24[3:0],led);
		seven_segment_display(data_24[7:4],led1);
		seven_segment_display(data_24[11:8],led2);
		seven_segment_display(data_24[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S48; 
		tracker = 8'hF7;
	end
	S48: begin 
		data_24[15:12] = data; 
		seven_segment_display(data_24[3:0],led);
		seven_segment_display(data_24[7:4],led1);
		seven_segment_display(data_24[11:8],led2);
		seven_segment_display(data_24[15:12],led3);
		arduino_comm = 4'h3;
		write_to_memory_2(data_24); 
		next_state = S49;
		tracker = 8'hF7;
	end
	S49: begin 
		write_high_2(3'b011);
		data_25[15:4] = 0; 
		data_25[3:0] = data; 
		seven_segment_display(data_25[3:0],led);
		seven_segment_display(data_25[7:4],led1);
		seven_segment_display(data_25[11:8],led2);
		seven_segment_display(data_25[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S50; 
		tracker = 8'hEF;
	end
	S50: begin 
		close_write;
		data_25[15:8] = 0; 
		data_25[7:4] = data; 
		seven_segment_display(data_25[3:0],led);
		seven_segment_display(data_25[7:4],led1);
		seven_segment_display(data_25[11:8],led2);
		seven_segment_display(data_25[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S51; 
		tracker = 8'hEF;
	end
	S51: begin
		data_25[15:12] = 0; 
		data_25[11:8] = data; 
		seven_segment_display(data_25[3:0],led);
		seven_segment_display(data_25[7:4],led1);
		seven_segment_display(data_25[11:8],led2);
		seven_segment_display(data_25[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S52; 
		tracker = 8'hEF;	
	end
	S52:begin 
		data_25[15:12] = data; 
		seven_segment_display(data_25[3:0],led);
		seven_segment_display(data_25[7:4],led1);
		seven_segment_display(data_25[11:8],led2);
		seven_segment_display(data_25[15:12],led3);
		arduino_comm = 4'h3; 
		next_state = S53;
		write_to_memory_2(data_25); 
		
		tracker = 8'hEF;
	end
	S53: begin 
		write_high_2(3'b100);
		
		data_26[15:4] = 0; 
		data_26[3:0] = data; 
		seven_segment_display(data_26[3:0],led);
		seven_segment_display(data_26[7:4],led1); 
		seven_segment_display(data_26[11:8],led2);
		seven_segment_display(data_26[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S54; 
		tracker = 8'hDF;
	end
	S54: begin
		close_write; 
		data_26[15:8] = 0; 
		data_26[7:4] = data; 
		seven_segment_display(data_26[3:0],led);
		seven_segment_display(data_26[7:4],led1); 
		seven_segment_display(data_26[11:8],led2);
		seven_segment_display(data_26[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S55;
		tracker = 8'hDF;		
	end
	S55: begin 
		data_26[15:12] = 0; 
		data_26[11:8] = data; 
		seven_segment_display(data_26[3:0],led);
		seven_segment_display(data_26[7:4],led1); 
		seven_segment_display(data_26[11:8],led2);
		seven_segment_display(data_26[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S56; 
		tracker = 8'hDF;
	end
	S56: begin 
		data_26[15:12] = data; 
		seven_segment_display(data_26[3:0],led);
		seven_segment_display(data_26[7:4],led1); 
		seven_segment_display(data_26[11:8],led2);
		seven_segment_display(data_26[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S57;
		write_to_memory_2(data_26);		 
		tracker = 8'hDF;
	end
	S57: begin 
		write_high_2(3'b101);
		data_27[15:4] = 0; 
		data_27[3:0] = data; 
		seven_segment_display(data_27[3:0],led);
		seven_segment_display(data_27[7:4],led1); 
		seven_segment_display(data_27[11:8],led2);
		seven_segment_display(data_27[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S58; 
		tracker = 8'hBF;
	end
	S58: begin 
		close_write;
		data_27[15:8] = 0; 
		data_27[7:4] = data; 
		seven_segment_display(data_27[3:0],led);
		seven_segment_display(data_27[7:4],led1); 
		seven_segment_display(data_27[11:8],led2);
		seven_segment_display(data_27[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S59; 
		tracker = 8'hBF;
	end
	S59: begin 
		data_27[15:12] = 0; 
		data_27[11:8] = data; 
		seven_segment_display(data_27[3:0],led);
		seven_segment_display(data_27[7:4],led1); 
		seven_segment_display(data_27[11:8],led2);
		seven_segment_display(data_27[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S60; 
		tracker = 8'hBF;
	end
	S60:begin 
		data_27[15:12] = data; 
		seven_segment_display(data_27[3:0],led);
		seven_segment_display(data_27[7:4],led1); 
		seven_segment_display(data_27[11:8],led2);
		seven_segment_display(data_27[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S61; 
		write_to_memory_2(data_27);
		tracker = 8'hBF;
	end
	S61: begin 
		write_high_2(3'b110);
		data_28[15:4] = 0; 
		data_28[3:0] = data; 
		seven_segment_display(data_28[3:0],led);
		seven_segment_display(data_28[7:4],led1); 
		seven_segment_display(data_28[11:8],led2);
		seven_segment_display(data_28[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S62; 
		tracker = 8'h7F;
	end
	S62: begin 
		close_write;
		data_28[15:8] = 0; 
		data_28[7:4] = data; 
		seven_segment_display(data_28[3:0],led);
		seven_segment_display(data_28[7:4],led1); 
		seven_segment_display(data_28[11:8],led2);
		seven_segment_display(data_28[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S63; 
		tracker = 8'h7F;
	end
	S63:begin
		data_28[15:12] = 0; 
		data_28[11:8] = data; 
		seven_segment_display(data_28[3:0],led);
		seven_segment_display(data_28[7:4],led1); 
		seven_segment_display(data_28[11:8],led2);
		seven_segment_display(data_28[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S64;
		tracker = 8'h7F;	
	end
	S64: begin 
		data_28[15:12] = data; 
		seven_segment_display(data_28[3:0],led);
		seven_segment_display(data_28[7:4],led1); 
		seven_segment_display(data_28[11:8],led2);
		seven_segment_display(data_28[15:12],led3);
		arduino_comm=4'h3; 
		next_state = S65; 

		write_to_memory_2(data_28);	
		tracker = 8'h7F;
	end
	S65: begin 
		write_high_2(3'b111);
		mac_rst = 0;
		next_state = S66; 
		i=0;
	end
	S66: begin
		close_write; 
		read_high_1(i);
		next_state = S67; 
	end
	S67: begin 
		read_from_memory_1(op_data); 
		read_high_2(i);
		next_state = S68; 
	end	
	S68: begin 
		read_from_memory_2(op_data_1); 
		i = i+1; 
		if(i==8) next_state = S69; 
		else next_state = S66;
	end
	S69: begin 
		close_read; 
		op_data_1=0; 
		op_data = 0; 
		next_state = S70; 
	end
	S70:begin 
		next_state = S70;
		seven_segment_display(result[3:0],led);
		seven_segment_display(result[7:4],led1);
		seven_segment_display(result[11:8],led2);
		seven_segment_display(result[15:12],led3);
	end
	endcase
end
always @(posedge clk2 or posedge rst or posedge next_trigger) begin
	if(rst) current_state = 0;
	current_state=next_state;
end

task write_high_1(input [2:0] addr);
	address =addr;
	select = 0; 
	write_enable = 0;
endtask	
task write_high_2(input [2:0] addr);
	address =addr;
	select = 1; 
	write_enable = 0;
endtask
task close_write;
	select = 1; 
	write_enable = 1; 
endtask	
task read_high_1(input [2:0] addr);
	address =addr;
	select = 0; 
	output_enable = 0; 
endtask
task read_high_2(input [2:0] addr);
	address =addr;
	select = 1; 
	output_enable = 0;
endtask
task close_read;
	select = 1; 
	output_enable = 1; 
endtask	
task write_to_memory_1(input [15:0] input_data);
	data_into_sram1= input_data; 
endtask 
task write_to_memory_2(input [15:0] input_data);
	data_into_sram2= input_data;
endtask 
task read_from_memory_1(output reg[15:0] output_data);
	output_data =data_from_sram1; 
endtask 
task read_from_memory_2(output reg[15:0] output_data);
	output_data =data_from_sram2;
endtask 
task seven_segment_display(input [3:0] number ,output reg [7:0] pattern_display ); 
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
endtask
endmodule

