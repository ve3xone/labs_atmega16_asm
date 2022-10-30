.macro delay_for_lab_6_1
         ldi @0, @1
delay1: ldi @2, @3
delay2: dec @2
         brne delay2
         dec @0
         brne delay1
.endmacro

delay3xx:
	delay_for_lab_6_1 r21, 255, r20, 255
	delay_for_lab_6_1 r21, 255, r20, 255
	delay_for_lab_6_1 r21, 255, r20, 255
ret