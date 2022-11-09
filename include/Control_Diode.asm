 .macro Control_Diode
sbic PINB,0
	jmp zero
	jmp q

b:
out portb, @3
@4

q:
sbic PINB,7
	jmp @2
	jmp q2
jmp b

q2:
	@0 @3
jmp b

sevenROL:
ldi @3, 0b00000001
jmp b

sevenROR:
ROR @3
jmp b

zero:
ldi @3, @1
jmp b
.endmacro