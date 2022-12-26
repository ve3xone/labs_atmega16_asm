.device ATmega16
.include "m16def.inc"


.def  temp=r16          

.def count=r22 // ������� ������                                                                         

.equ  FREQ=1000000                                                       ;������� ��

.equ FreqSCL=100000                                                     ;������������ ������� I2C 400 ��� (������� �� ;���������� ���������� � ������� ����� �����)

.equ  FreqTWBR=((FREQ/FreqSCL)-16)/2                      ;������� �� datasheet, ������� TWPS=0

.equ adrslv=0x4e

.org 0x00
rjmp settings

.org 0x22
rjmp TWSI




settings:
ldi r17, high (RAMEND)
out SPH, r17
ldi r16, low (RAMEND)
out SPL, r16


ldi r16, 0b11111100
out DDRB, r16


 ;*********************************************************************

// ��������� TWI
																	;��������� ����������

ldi temp, FreqTWBR                                                        ; ���������� ������� TWI � TWBR

out TWBR, temp
             
			 sei
 ;********************************************************************

 // ������������� LCD
ldi count, 0b00110000 ;1
call write
call delay

ldi count, 0b00110000 ; 2
call write
call delay

ldi count, 0b00110000 ;3 
call write
call delay

ldi count, 0b00100000 ;4 
call write
call delay

ldi count, 0b00100000 ;5
call write
call delay

ldi count, 0b11000000 ;6 
call write
call delay

ldi count, 0b00000000 ;7
call write
call delay

ldi count, 0b10000000 ;8
call write
call delay

ldi count, 0b00000000 ;9 
call write
call delay

ldi count, 0b00010000 ;10
call write
call delay

ldi count, 0b00000000 ;11
call write
call delay

ldi count, 0b01100000 ;12 
call write
call delay

ldi count, 0b00000000 ;13
call write
call delay

ldi count, 0b11110000 ;14
call write
call delay

ldi count, 0b00000000 ;15
call write
call delay

ldi count, 0b00010000 ;16
call write
call delay
// ������������� ������

Write_CHOOSE:

ldi count, 0b01000000 ; C
call writeLCD
call delay

ldi count, 0b00110000 ; C
call writeLCD
call delay

ldi count, 0b01000000 ; H
call writeLCD
call delay

ldi count, 0b10000000 ; H
call writeLCD
call delay

ldi count, 0b01000000 ; O
call writeLCD
call delay

ldi count, 0b11110000 ; O
call writeLCD
call delay

ldi count, 0b01000000 ; O
call writeLCD
call delay

ldi count, 0b11110000 ; O
call writeLCD
call delay

ldi count, 0b01010000 ; S
call writeLCD
call delay

ldi count, 0b00110000 ; S
call writeLCD
call delay

ldi count, 0b01000000 ; E
call writeLCD
call delay

ldi count, 0b01010000 ; E
call writeLCD
call delay

ldi count, 0b10100000 ; _
call writeLCD
call delay

ldi count, 0b00000000 ; _
call writeLCD
call delay

ldi count, 0b01000000 ; H
call writeLCD
call delay

ldi count, 0b10000000 ; H
call writeLCD
call delay

ldi count, 0b01000000 ; L
call writeLCD
call delay

ldi count, 0b11000000 ; L
call writeLCD
call delay



a:
sbis PINB, 0
call set_HL1

sbis PINB, 1
call set_HL2

ldi count, 0

sbrs r30, 0
rjmp a

ldi count, 0b00000000 ;clear
call write
call delay
call delay

ldi count, 0b00010000 ;clear
call write
call delay
call delay

rjmp back

prewrite_CEHL1:
rjmp write_CEHL1

prewrite_CEHL2:
rjmp write_CEHL2

back:
cpi r30, 3
breq prewrite_CEHL1
cpi r30, 5
breq prewrite_CEHL2
rjmp back


HL1_HL2:
cpi r30, 3
breq fire_HL1
next:
cpi r30, 5
breq fire_HL2
next1:
sbic PINB, 0
rjmp HL1_HL2
sbis PINB, 1
rjmp preWrite_CHOOSE
rjmp HL1_HL2

preWrite_CHOOSE:
ldi count, 0b00000000 ;clear
call write
call delay
call delay

ldi count, 0b00010000 ;clear
call write
call delay
call delay

ldi r30, 0

rjmp Write_CHOOSE

fire_HL1:
sbi PORTB, 3
call delay
cbi PORTB, 3
call delay
rjmp next

fire_HL2:
sbi PORTB, 4
call delay
cbi PORTB, 4
call delay
rjmp next1

set_HL1:
ldi r30, 3
ldi count, 0b00110000 ; 1
call writeLCD
call delay

ldi count, 0b00010000 ; 1
call writeLCD
call delay
ret

set_HL2:
ldi r30, 5
ldi count, 0b00110000 ; 2
call writeLCD
call delay

ldi count, 0b00100000 ; 2
call writeLCD
call delay
ret

write_CEHL1:
ldi count, 0b01000000 ; C
call writeLCD
call delay

ldi count, 0b00110000 ; C
call writeLCD
call delay

ldi count, 0b01000000 ; H
call writeLCD
call delay

ldi count, 0b10000000 ; H
call writeLCD
call delay

ldi count, 0b01000000 ; O
call writeLCD
call delay

ldi count, 0b11110000 ; O
call writeLCD
call delay

ldi count, 0b01000000 ; O
call writeLCD
call delay

ldi count, 0b11110000 ; O
call writeLCD
call delay

ldi count, 0b01010000 ; S
call writeLCD
call delay

ldi count, 0b00110000 ; S
call writeLCD
call delay

ldi count, 0b01000000 ; E
call writeLCD
call delay

ldi count, 0b01010000 ; E
call writeLCD
call delay

ldi count, 0b01000000 ; D
call writeLCD
call delay

ldi count, 0b01000000 ; D
call writeLCD
call delay

ldi count, 0b10100000 ; _
call writeLCD
call delay

ldi count, 0b00000000 ; _
call writeLCD
call delay

ldi count, 0b01000000 ; H
call writeLCD
call delay

ldi count, 0b10000000 ; H
call writeLCD
call delay

ldi count, 0b01000000 ; L
call writeLCD
call delay

ldi count, 0b11000000 ; L
call writeLCD
call delay

ldi count, 0b00110000 ; 1
call writeLCD
call delay

ldi count, 0b00010000 ; 1
call writeLCD
call delay

rjmp HL1_HL2

write_CEHL2:
ldi count, 0b01000000 ; C
call writeLCD
call delay

ldi count, 0b00110000 ; C
call writeLCD
call delay

ldi count, 0b01000000 ; H
call writeLCD
call delay

ldi count, 0b10000000 ; H
call writeLCD
call delay

ldi count, 0b01000000 ; O
call writeLCD
call delay

ldi count, 0b11110000 ; O
call writeLCD
call delay

ldi count, 0b01000000 ; O
call writeLCD
call delay

ldi count, 0b11110000 ; O
call writeLCD
call delay

ldi count, 0b01010000 ; S
call writeLCD
call delay

ldi count, 0b00110000 ; S
call writeLCD
call delay

ldi count, 0b01000000 ; E
call writeLCD
call delay

ldi count, 0b01010000 ; E
call writeLCD
call delay

ldi count, 0b01000000 ; D
call writeLCD
call delay

ldi count, 0b01000000 ; D
call writeLCD
call delay

ldi count, 0b10100000 ; _
call writeLCD
call delay

ldi count, 0b00000000 ; _
call writeLCD
call delay

ldi count, 0b01000000 ; H
call writeLCD
call delay

ldi count, 0b10000000 ; H
call writeLCD
call delay

ldi count, 0b01000000 ; L
call writeLCD
call delay

ldi count, 0b11000000 ; L
call writeLCD
call delay

ldi count, 0b00110000 ; 2
call writeLCD
call delay

ldi count, 0b00100000 ; 2
call writeLCD
call delay

rjmp HL1_HL2

;======================================================================================================================================  
; �������� �� i2c + ������������ ������ (����� �� ����� �)
;======================================================================================================================================  
writeLCD:

sbr count,0b00000101			; ����� �=1 � 2 ����
rcall TWI_start					;��������� TWI, ���������� ������
rcall delay			;��������� �����

cbr count,0b00000100			; ����� �=0 � 2 ����
rcall TWI_start					;��������� TWI, ���������� ������
rcall delay			;��������� �����

ret

;======================================================================================================================================  
; �������� �� i2c + ������������ ������ (����� �� ����� �)
;======================================================================================================================================  
write:
sbr count,0b00000100			; ����� �=1 � 2 ����
rcall TWI_start					;��������� TWI, ���������� ������
rcall delay			;��������� �����

cbr count,0b00000100			; ����� �=0 � 2 ����
rcall TWI_start					;��������� TWI, ���������� ������
rcall delay			;��������� �����

ret


;=================================================================================================

; ���������� ���������� TWI

;=================================================================================================

 TWSI:                                    ;���������� ���������� TWI

 cli                                           ;������ ����������

 in r16,TWSR                          ;������ ������-�������, ��� ��������� ����� ����� �������� ��������� ����������

 andi r16,0xF8                        ;���������� � ���������� ������ � ���������� ��� ������ 3-� ������� �����

 cpi r16,0x08

 breq SLAW_Adr                     ;���������� �� ���� ����� ���������� � ��������� �������� Slawe+Write

 cpi r16,0x10

 breq SLAW_Adr                     ;���������� �� ���� ����� ���������� ����� �������� � ��������� �������� Slawe+Write

 cpi r16,0x18                           ;���� 0x18, �� ������� � ���������� ����� �������� �����

 breq ByteTrasmit                    ;�������� �� ���� ���� ��� ������������ ���� �� ������

 cpi r16,0x28                           ;���� 0x28, �� ������� � ���������� ����� �������� ���������� ��� ���������� �����

 breq TWI_Stop                       ;�������� �� ���� ��������� ��� ��������� ����, ���� ������������ ���� �� ������

 

Vix:

 sei                                                                           ;��������� ����������

 reti                                                                           ;����� �� ����������� ����������

 

ByteTrasmit:

mov r16,count                                                         ;�������� count � r16

rcall TWI_SendByte                                                ;� ��������� �� ����

rjmp Vix

 

SLAW_Adr:

ldi r16, adrslv                                                          ; �������� ������ ����������  (� �������� ����������) (����� �� datasheet)+������  0x4E-����� LCD to I2C

rcall TWI_SendByte

rjmp Vix

 

TWI_Start:                                                             ;�������� �����

ldi r16,0b10100101                                               ;TWINT,TWEN,TWIE - ��������� ��������� � ����������

out TWCR,temp                                                    ;TWSTA - �������������� ��������, ��������� ���� =0

ret

 

TWI_Stop:                                                             ;�������� ���� � ��������� ����������

ldi r16,0b00010100                                               ;TWEN - ��������� ���������, TWSTO - ����

out TWCR,temp                                                    ;TWSTA - �������������� ��������, ��������� ���� =0

rjmp Vix

 

TWI_SendByte:                                                                    

out TWDR,r16                                                       ;���������� ������ � �������

ldi r16,0b10000101                                               ;TWINT,TWEN,TWIE - ��������� ��������� � ����������

out TWCR,temp                                                    

ret

;================================================================================================= 
;==================================================================================================
  //������������ ��������� �����

delay_40mks:
ldi r18, 238				; ���� ���������� �������� = 245
ldi r19, 0b00000001			; ��������� ������������ (CS00-CS02) - ����������� 1024, ����� Normal
jmp pdelay

delay: ;���� ������ 15ms
ldi r25, 200
ldi r26, 0b00000101
jmp pdelay

delay_250ms:
ldi r18, 1					;232 ���� ���������� �������� = 256-20=236
ldi r19, 0b00000101			; ��������� ������������ (CS00-CS02) - ����������� 1024, ����� Normal
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