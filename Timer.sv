module Timer (input clk, output logic [0:7] display1, input logic [5:0] data, 
input logic write, input logic pause, output logic [5:0] outseconds, input logic forward);
	logic [0:26] tickCounter = 0;
	logic [4:0] actualSeconds = 0;
	logic [0:7] hichar;
	logic [0:7] lochar;
	logic oneshot;
		
	Seg7Encoder seg1 (actualSeconds+8'h30, display1);	
	assign outseconds = actualSeconds;
	
	always_ff @ (posedge clk) begin : COUNTER
		if (write == 0) oneshot <= ~oneshot;		
		if (tickCounter == 50000000) begin
			if (forward) actualSeconds <= actualSeconds + 1;				
			else actualSeconds <= actualSeconds - 1;
			tickCounter <= 0;
		end
		if (actualSeconds == 10 && forward) begin
			actualSeconds <= 0;
		end
		if (actualSeconds == 31 && !forward) begin
			actualSeconds <= 9;
		end
		if (!pause) tickCounter <= tickCounter + 1;
		if (write && !oneshot) begin
			oneshot <= 1;
			actualSeconds <= data;
			tickCounter <= 0;
		end
	end
	
endmodule