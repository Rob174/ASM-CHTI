
	thumb
	area moncode, code, readwrite
	export calculIm
	import TabCos
	import TabSin
	import TabSig
calculIm proc
	push {lr}
	push {r0}
	; r0 contiendra k
	bl	calculSin
	pop {r0}
	str	r12, [r0]
	pop {pc}
	endp
		
calculSin proc 
	push {r4}
	push {r5}
	push {r6}
    ; r0 @ signal origine
	ldr r0, =TabSig
    ; r1 valeur de k
    ; r2 adresse de la table
	ldr r2, =TabSin
	; i est stocke en r3 : 
	mov r3, #0x0
	; le resultat sera stocke dans r12
	mov r12, #0x0

debutBclSin mul r6, r1, r3
    ; on ramène ik dans la plage [0;64-1]
	and	r6, r6, #63
	; on se décale jusqu'à l'indice désiré (arg angle)
    ldrsh r4, [r2, r6, LSL #1] ; r4 contient le sin(ik2pi/N)
	; on multiplie par l'échantillon
    ldrsh r5, [r0, r6, LSL #1]; r5 contient x(i)
    mla r12, r5, r4, r12 ; on multiplie et on ajoute le resultat aux precedants
	; on incremente le pas et on retourne au debut si i est inferieur à N
	add r3, #1
	cmp r3, #64
	bne debutBclSin
   ; sub #0, r12 ; on ajoute le -
	; la valeur de retour est en r12
	pop {r6}
	pop {r5}
	pop {r4}
	bx	lr
	endp
    end