.macro setup
	ldi @2,@1
	out @0,@2
	//ldi r17, 0b00000001
	//out PORTB, r17
.endmacro