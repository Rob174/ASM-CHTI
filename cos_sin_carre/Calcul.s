
		
	thumb
	area madata, data, readonly
	import TabCos
	import TabSin

	area moncode, code, readwrite
	export calcul
	export calcul2
	
		
calcul2 proc
    push {lr}
    ldr r3, =TabCos ; on recup�re les adreeses du debut des tables de sin et cos
    ldrsh r2, [r3, r0, LSL #1] ; on se d�cale jusqu'� l'indice d�sir� (arg angle)
    ldr r3, =TabSin
    ldrsh r12, [r3, r0, LSL #1]
    mul r2, r2, r2 ; on fait le calcul de cos� + sin�
    mla r0, r12, r12, r2
    str r0, [r1] ; on retourne le resultat (dans l'arg res)
    pop {pc}
    endp
	end
		
		