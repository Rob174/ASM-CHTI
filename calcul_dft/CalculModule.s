	thumb
	area moncode, code, readwrite
	export calculModule
		
calculModule	proc
	;r0 : Im
    ;r1 : Re
	mov r3, #0
    smlal r0,r3,r0,r0
    smlal r2,r0,r1,r1
    and r2, #0xFFFFFFFF00000000
	endp
	end
	