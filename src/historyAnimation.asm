PRIMEIRAS_ANIMACOES:
	la a0, alertainicial
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	li t0, 5000
	csrr t1, time
TEMPO_PA:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO_PA

    mv ra, a6
    ret


D_HISTORIA:
	la a0, history0
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	li t0, 5000
	csrr t1, time
TEMPO_h0:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO_h0

###########################
	la a0, history1
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	li t0, 5000
	csrr t1, time
TEMPO_h1:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO_h1
##################
	la a0, history2
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	li t0, 5000
	csrr t1, time
TEMPO_h2:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO_h2

######################
	la a0, history3
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	li t0, 5000
	csrr t1, time
TEMPO_h3:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO_h3

    mv ra, a6
    ret