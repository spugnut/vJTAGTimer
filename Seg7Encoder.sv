module Seg7Encoder (input logic [0:7]char, output logic [0:7] seg);
	
	
always_comb begin
	case (char)
			8'h30: seg = 8'b11111100;
			8'h31: seg = 8'b01100000;
			8'h32: seg = 8'b11011010;
			8'h33: seg = 8'b11110010;
			8'h34: seg = 8'b01100110;
			8'h35: seg = 8'b10110110;
			8'h36: seg = 8'b00111110;
			8'h37: seg = 8'b11100000;
			8'h38: seg = 8'b11111110;
			8'h39: seg = 8'b11100110;
			
		default: seg = 8'b0;
	endcase
	seg = ~seg;
end
	
endmodule