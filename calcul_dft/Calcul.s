
	thumb
	area moncode, code, readwrite
	export calculSin
	import TabCos
	import TabSin
	import LeSignal
calcul proc
	push {lr}
	; r0 contiendra k
	push {r1}
	mov r1, r0
	bl	calculSin
	pop {r1}
	pop {pc}
	endp
calculSin proc
	push {r4}
	push {r5}
	push {r6}
    ; r0 @ signal origine
	ldr r0, =LeSignal
    ; r1 valeur de k
    ; r2 adresse de la table
	ldr r2, =TabSin
	; i est stocke en r3 : 
	; affectation d'apr�s https://community.arm.com/developer/ip-products/processors/f/cortex-a-forum/4315/how-many-ways-to-set-a-register-32-bit-value
	ldr r3, =0x0
	; le resultat sera stocke dans r12
	ldr r12, =0x0

debutBcl mul r6, r1, r3
    ; on ram�ne ik dans la plage [0;64-1]
	and	r6, r6, #63
	; on se d�cale jusqu'� l'indice d�sir� (arg angle)
    ldrsh r4, [r2, r6, LSL #1] ; r4 contient le sin(ik2pi/N)
	; on multiplie par l'�chantillon
    ldrsh r5, [r0, , LSL #1]; r5 contient x(i)
    mla r12, r5, r4, r12 ; on multiplie et on ajoute le resultat aux precedants
	; on incremente le pas et on retourne au debut si i est inferieur � N
	add r3, #1
	sub r5, r3, #64
	cbnz r5, debutBcl
    sub #0, r12 ; on ajoute le -
	; la valeur de retour est en r12
	pop {r6}
	pop {r5}
	pop {r4}
	bx	lr
	
    endp
    end