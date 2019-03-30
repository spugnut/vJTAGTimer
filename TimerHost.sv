module TimerHost (input clk, output logic [0:7] display1);

//These signals are required for the vJTAG module
logic tck, tdi, tdo, cdr, eldr, e2dr, pdr; 
logic sdr, udr, uir, cir, e1dr, bypass_reg;
logic [3:0] ir_in;

//Signals for our implementation specifics
logic pause, w_enable; //Pause and write enable for the timer.
logic [5:0] tmp_reg; // Declaration of data register
logic [5:0] seconds;	// The value of the timer in seconds.
logic write_oneshot = 0;	//A one-shot trigger to write to the timer
logic forward = 1; //Direction of the timer count
logic [5:0] shift_buffer = 6'h0; //Our implementation of the shift buffer.

//Instantiation of the timer module.
Timer t (clk, display1, tmp_reg, w_enable, pause, seconds, forward);

//Instantiation of the JTAG module.
vJTAG v(
 .tdo (tdo),
 .tck (tck),
 .tdi (tdi),
 .ir_in(ir_in),
 .ir_out(),
 .virtual_state_cdr (cdr),
 .virtual_state_e1dr(e1dr),
 .virtual_state_e2dr(e2dr),
 .virtual_state_pdr (pdr),
 .virtual_state_sdr (sdr),
 .virtual_state_udr (udr),
 .virtual_state_uir (uir),
 .virtual_state_cir (cir)
);

assign ir_out = ir_in; //Assignment for passthrough.

//JTAG IR Codes 
localparam BYPASS =     4'b1111;
localparam SETPARAM =   4'b0001;
localparam RESET   =    4'b0010;
localparam PAUSE   =    4'b0011;
localparam RUN     =    4'b0100;
localparam GETVAL  =    4'b0101;
localparam TOGGLEDIR =  4'b0111;

always_ff @ (posedge tck) begin
	w_enable <= 0;
	if (sdr) begin				
		shift_buffer <= {tdi, shift_buffer[5:1]};	
	end	
	if (cdr) begin
		case (ir_in)
			GETVAL: shift_buffer <= seconds;
		endcase
	end	
	if (uir) begin
		case (ir_in)
			PAUSE: begin
				pause <= 1;
			end
			RUN:   begin
				pause <= 0;
			end
			SETPARAM: begin
				tmp_reg <= shift_buffer;
				write_oneshot <= 1;
			end
			RESET: begin
				tmp_reg <= 0;
				w_enable <= 1;
			end
			TOGGLEDIR: begin
				forward <= !forward;
			end
		endcase
	end
end

//Passthough behaviour when the current instruction is BYPASS.
always_comb begin
	if (ir_in == BYPASS) tdo <= tdi;
	else tdo <= shift_buffer[0];
end

endmodule