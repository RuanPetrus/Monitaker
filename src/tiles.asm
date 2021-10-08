GET_V:	# a1, a2 = y, x
	slli t1,s11,2
	slli t2,s10,2
	la t0,MATRIZ
	add t0,t0,t2
	lw t0,(t0)
	add t0,t0,t1
	
	lw a3,(t0)
	ret

GLOBAL_DRAW:
	beq s7,zero,GLOBAL_DRAW_END_NODRAW # No frame change
	li s11,-1
	li s9,7 # map width & height
ITER_X: bge s11,s9,GLOBAL_DRAW_END
	li s10,0
	addi s11,s11,1
ITER_Y: bgt s10,s9,ITER_X
	call GET_V
	mv a1,s11
	mv a2,s10
	call CORRELATE
	
	addi s10,s10,1
	j ITER_Y

GLOBAL_DRAW_END:
	call SWAP_FRAMES # fallthrough
GLOBAL_DRAW_END_NODRAW:
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
