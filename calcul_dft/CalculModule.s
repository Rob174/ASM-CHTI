	thumb
	area moncode, code, readwrite
	export calculModule
		
calculModule	proc
	;r0 : Im
    ;r1 : Re
	push {lr}
	mov r3, #0
    smlal r0,r3,r0,r0
    smlal r3,r0,r1,r1
	str r3, [r2]
    ;and r2, #0xFFFFFFFF
	pop {pc}
	endp
	end
	