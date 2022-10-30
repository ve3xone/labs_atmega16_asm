.macro	setStack
	/*.if @0>RAMEND
	.error "Value greater than RAMEND used for setting stack"
	.else
	ldi	@1,LOW(@0)
	out	SPL,@1
	ldi	@1,LOW(@0)
	out	SPL,@1
	.endif*/
	ldi	@1,LOW(@0)
	out	SPL,@1
	ldi	@1,HIGH(@0)
	out	SPH,@1
.endmacro