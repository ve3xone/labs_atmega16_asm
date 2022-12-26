.macro encoder_check
sbis @0, @1
		jmp b
		checkr21:
			ldi @4,0
@5
b:
	cpi @4, 0
		BREQ c
@5
c:
	ldi @4,1
	sbic @2, @3
		@6
		@7	
.endmacro