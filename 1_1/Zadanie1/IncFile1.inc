/*
 * IncFile1.inc
 *
 *  Created: 06.09.2022 12:47:47
 *   Author: ve3xone
 */ 
 .device ATmega16
.include "m16def.inc"

.macro delayms
push r18
push r24
push r25

ldi r18,@0/10
rcall delay10ms


pop r25
pop r24
pop r18
.endmacro
