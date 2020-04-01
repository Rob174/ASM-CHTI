	
	thumb
	area moncode, code, readwrite
	export calculModule
	import TabCos
	import TabSin

		
calculModule	proc
	push {r0}
	push {lr}
	; r2 adresse de la table
	ldr r2, =TabCos
	b calcul
	mov r3, #0
    SMULL r12,r3,r0,r0
	pop {r0}
	push {lr}
	ldr r2, =TabSin
	b calcul
    SMULL r12,r0,r1,r1
	add r1, r3, r0
	str r1, [r2]
	pop {pc}
	endp
		
calcul proc
	push {lr}
	push {r0}
	; r0 contiendra k
	bl	calculTrig
	pop {r0}
	str	r12, [r0]
	pop {pc}
	endp
		
calculTrig proc 
	push {lr}
	push {r4-r7}
    ; r1 valeur de k
	; i est stocke en r3 : 
	; affectation d'après https://community.arm.com/developer/ip-products/processors/f/cortex-a-forum/4315/how-many-ways-to-set-a-register-32-bit-value
	ldr r3, =0x0
	; le resultat sera stocke dans r12
	ldr r12, =0x0
	b debutBcl
	pop {pc}
	endp

debutBcl proc
boucle	mul r6, r1, r3
    ; on ramène ik dans la plage [0;64-1]
	and	r6, r6, #63
	; on se décale jusqu'à l'indice désiré (arg angle)
    ldrsh r4, [r2, r6, LSL #1] ; r4 contient le sin(ik2pi/N)
	; on multiplie par l'échantillon
    ldrsh r5, [r0, r3, LSL #1]; r5 contient x(i)
    mla r7, r5, r4, r12 ; on multiplie et on ajoute le resultat aux precedants
	; r7 esr là car sinon ça fait une erreur donc registre auxlliaire
	mov r12, r7
	; on incremente le pas et on retourne au debut si i est inferieur à N
	add r3, #1
	cmp r3, #64
	bne boucle
   ; sub #0, r12 ; on ajoute le -
	; la valeur de retour est en r12
	pop {r4-r7}
	bx	lr
	endp	
	end
	