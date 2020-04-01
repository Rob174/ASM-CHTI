	thumb
	area moncode, code, readwrite
	export calculModule
		
calculModule	proc
	;r0 : Im
    ;r1 : Re
	push {lr}
	mov r3, #0
    SMULL r12,r3,r0,r0
    SMULL r12,r0,r1,r1
	add r1, r3, r0
	str r1, [r2]
    ;and r2, #0xFFFFFFFF
	pop {pc}
	endp
	end
	