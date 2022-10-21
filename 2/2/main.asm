;
; 2.asm
;
; Created: 07.09.2022 16:05:30
; Author : ve3xone
;
#define RS 5							//RS=PD2
#define E  7							//E=PD3
.def temp = r20
.device ATMEGA16
.include "m16def.inc"
.org 0x00

//Инициализация МК-------------------------------
INIT:
//Инициализация стека----------
ldi r19,low(ramEND)
out SPL,r19
ldi r19,high(ramEND)
out SPH,r19
//----------------------------
ldi r16,0b11111111
out DDRb,r16
ldi r17,0b11100000
out DDRa,r17

CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL RETRY
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL RETRY
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL RETRY
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
ldi r23,0b00111000
out PORTb,r23
CALL OKE
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
ldi r23,0b00001111
out PORTb,r23
CALL OKE
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
ldi r23,0b00000110
out PORTb,r23
CALL OKE

//Первая строка
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 0x80
	out PORTb,r23
CALL OKE
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	sbi PORTa, 5
	ldi r23, 'S'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 't'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'a'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'r'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
	ldi r23, 'c'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'e'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'v'
	out PORTb,r23
CALL OKE1

//Вторая строка
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 0xc0
	out PORTb,r23
CALL OKE
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	sbi PORTa, 5
	ldi r23, 'S'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'i'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'n'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 't'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'u'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'r'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'i'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
	ldi r23, 'n'
	out PORTb,r23
CALL OKE1
CALL WAIT_5ms
CALL WAIT_5ms
CALL WAIT_5ms
cbi PORTa, 5


LOOP:

JMP LOOP

RETRY:
ldi r23,0b00110000
out PORTb,r23
CALL OKE
RET

//E 1-0
OKE:
	/*ldi r21,(0<<RS)|(0<<E)
	out portA,r21
	or temp,r21
	out portA,temp
	ldi r21,(0<<RS)|(1<<E)
	out portA,r21*/
	cbi porta,5
	sbi porta,7
	nop
	cbi porta,7
RET

OKE1:
	/*ldi r21,(1<<RS)|(1<<E)
	out portA,r21
	or temp,r21
	out portA,temp
	ldi r21,(1<<RS)|(0<<E)
	out portA,r21*/
	sbi porta,7
	nop
	cbi porta,7
RET
//----------------------------------
//Подпрограммы задержки

WAIT_20ms:
; =============================
; delay loop generator
; 160000 cycles:
; -----------------------------
; delaying 159975 cycles:
ldi R17, $E1
WGLOOP01: ldi R18, $EC
WGLOOP11: dec R18
brne WGLOOP11
dec R17
brne WGLOOP01
; -----------------------------
; delaying 24 cycles:
ldi R17, $08
WGLOOP21: dec R17
brne WGLOOP21
; -----------------------------
; delaying 1 cycle:
nop
; =============================

RET

//----------------------------------

WAIT_5ms: ;Расчет делался в программе
; =============================
; delay loop generator
; 40000 cycles:
; -----------------------------
; delaying 39999 cycles:
ldi R17, $43
WGLOOP02: ldi R18, $C6
WGLOOP12: dec R18
brne WGLOOP12
dec R17
brne WGLOOP02
; -----------------------------
; delaying 1 cycle:
nop
; =============================

RET

//----------------------------------
WAIT_100us:
; =============================
; delay loop generator
; 800 cycles:
; -----------------------------
; delaying 798 cycles:
ldi R17, $02
WGLOOP03: ldi R18, $84
WGLOOP13: dec R18
brne WGLOOP13
dec R17
brne WGLOOP03
; -----------------------------
; delaying 2 cycles:
nop
nop
; =============================

RET
