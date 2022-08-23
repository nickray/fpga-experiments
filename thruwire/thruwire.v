`default_nettype none

module thruwire(
	/* input wire i_btn, */
	input wire i_sw,
	input wire i_uart,
	output wire [3:0] o_led,
	output wire o_uart
);

	// exercise 1: control LEDs with switch 0
	assign o_led[0] = i_sw;
	assign o_led[1] = ~i_sw;
	assign o_led[2] = ~i_sw;
	assign o_led[3] = i_sw;

	// exercise 2: echo incoming UART traffic
	assign o_uart = i_uart;

endmodule

`default_nettype wire
