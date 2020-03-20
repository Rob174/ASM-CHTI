
GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register
	thumb
	area moncode, code, readwrite
	export timer_callback
	import etat

	 



; N.B. le registre BSRR est write-only, on ne peut pas le relire
timer_callback	proc
	ldr r12, =etat
	ldr r1, [r12]; récupère dans r1 l'état
	cbz r1, mise_a_un; 
	b mise_a_zero

			
; mise a 1 de PB1
mise_a_un	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00000002
	str	r1, [r3]
	mov r2, #0x01
	str r2, [r12]
    b fin
; mise a zero de PB1
mise_a_zero
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00020000
	str	r1, [r3]
	mov r2, #0x00
	str r2, [r12]

fin
	bx lr
	endp
		
	
	end