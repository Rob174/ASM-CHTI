; ce programme est pour l'assembleur RealView (Keil)
	thumb

	area  madata, data, read
	export compteur4

compteur4	dcd	0



	area  moncode, code, readwrite
	export t4_callback
;
t4_callback	proc
	ldr	r1, =compteur4
	ldr	r0, [r1]
	add	r0, #1
	str	r0, [r1]
	bx	lr	; derni�re instruction de la fonction
	endp
;
	end