GET_V:	# a1, a2 = y, x
	slli t1, a2, 2
	slli t2, a1, 2
	la t0, MATRIZ
	add t0,t0,t2
	lw t0,(t0)
	add t0,t0,t1
	
	lw a3 (t0)
	
	li a7, 1
	mv a0, a3
	ecall
	ret

GLOBAL_DRAW:
	beq s7,zero,GLOBAL_DRAW_END # No frame change
	li a1,0
	li t0,8 # constant: map size
ITER_X: bge a1,t0,GLOBAL_DRAW_END
	li a2,0
ITER_Y: bge a2,t0,ITER_X
	call GET_V
	call CORRELATE
	j ITER_Y

GLOBAL_DRAW_END:
	li s7,0
	jr a6

# Correlate number to a tile and draw it at (a2,a1)
CORRELATE:
	mv t2,a3

	li t3,0 # ground
	beq t2 t3 COL_GROUND
	li t3,1 # player
	beq t2 t3 COL_PLAYER

# a0 = sprite we'll be drawing (28x28)
# a1 = tile y coordinate
# a2 = tile x coordinate

# Draw tile (tx,ty)
DRAW_TILE:
	# Load image dimensions
	lw t0,0(a0) # w
	lw t1,4(a0) # h
	# Translate absolute coordinates to tile coordinates
	mul a1,a1,t0  # y = ty * w
	mul a2,a2,t1  # x = tx * h
	# Add border offsets
	addi a1,a1,48
	addi a2,a2,8
	
	mv a5,ra
	call RENDER
	mv ra,a5
	ret
