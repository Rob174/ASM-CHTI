
	thumb
	area moncode, code, readwrite
	export calcul
	import TabCos
	import TabSin
		
calcul proc
	push {r4}
	push {r5}
	push {r6}
	ldr r4, =TabCos ; on recupère les adreeses du debut des tables de sin et cos
	ldr r2, =TabSin
	ldr r5, [r4, r0] ; on se décale jusqu'à l'indice désiré (arg angle)
	ldr r6, [r2, r0]
	mul	r3, r5, r5 ; on fait le calcul de cos² + sin²
	mla r12, r6, r6, r3
	str r12, [r1] ; on retourne le resultat (dans l'arg res)
	pop	{r6}
	pop	{r5}
	pop	{r4}
	endp
	end