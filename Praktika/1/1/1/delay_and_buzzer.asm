//3khz - 241
//2khz - 228
.macro buzzer
	sbi @1, @2
	delay @0
	delay @0	//x2 на реальном железе чтоб точнее было
	cbi @1, @2
.endmacro

.macro delay
	//push r18
	//push r19
	//push r20
	//push r21
	ldi r18,  @0
	ldi r19,  0b00000010
	rjmp init_delay
init_delay:
	out TCNT0, r18
	out TCCR0, r19
test_TIFR:
	in r18, TIFR
	sbrs r18,0
	rjmp test_TIFR
	ldi r20, 0b00000000
	out TCCR0, r20
	ldi r21, 0b00000001
	out TIFR,r21
	/*pop r18
	pop r19
	pop r20
	pop r21*/
.endmacro