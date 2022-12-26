.device ATmega16
.include "m16def.inc"
.org 0x00
rjmp settings

.org 0x02
rjmp iqr0

settings:
ldi r17, high (RAMEND)
out SPH, r17
ldi r16, low (RAMEND)
out SPL, r16

ldi r16, 0xFF
out DDRB, r16
ldi r16, 0b00000000
out DDRD, r16

ldi r16, 0b01000000
out GICR, r16
ldi r16, 0b01000000
out MCUCR, r16
sei

ldi r16, 0

a:
cpi r16, 0
breq zero
cpi r16, 5
breq first
cpi r16, 10
breq second
cpi r16, 15
breq third
rjmp a



iqr0:
call delay_250ms
inc r16
reti


;================================================================================================= 
;==================================================================================================
  //������������ ��������� �����

delay: ;���� ������ 15ms
ldi r25, 200
ldi r26, 0b00000101
jmp pdelay

delay_250ms:
ldi r25, 1					;232 ���� ���������� �������� = 256-20=236
ldi r26, 0b00000101			; ��������� ������������ (CS00-CS02) - ����������� 1024, ����� Normal
jmp pdelay

pdelay:
out TCNT0, r25
out TCCR0, r26
pdelay2:
in r25, TIFR
sbrs r25, 0
rjmp pdelay2
ldi r26, 0b00000000
out TCCR0, r26
ldi r27, 0b00000001
out TIFR, r27
ret



zero:
cli
cbi PORTB, 1
cbi PORTB, 0
cbi PORTB, 2
cbi PORTB, 3
sei
rjmp a

first:
cli
sbi PORTB, 1
cbi PORTB, 0
cbi PORTB, 2
cbi PORTB, 3
sei
rjmp a

second:
cli
sbi PORTB, 1
cbi PORTB, 0
sbi PORTB, 2
cbi PORTB, 3
sei
rjmp a

third:
cli
sbi PORTB, 1
sbi PORTB, 0
sbi PORTB, 2
sbi PORTB, 3
call delay_250ms
call delay_250ms
call delay_250ms
call delay_250ms
ldi r16, 0
cbi PORTB, 1
cbi PORTB, 0
cbi PORTB, 2
cbi PORTB, 3
sei
rjmp a
