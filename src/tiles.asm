GET_V:	# a1, a2 = x, y
	slli t1,a1,2
	slli t2,a2,2
	la t0,MATRIZ
	add t0,t0,t2
	lw t0,(t0)
	add t0,t0,t1
	
	lw a3,(t0)
	ret

.data
XY: .byte -1, 0  
MAP_WIDTH: .byte 7

.text

#t0 = LABEL adress
#t1 = x
#t2 = MAP_WIDTH
#t4 = y
GLOBAL_DRAW:
	csrr t1, time			# t1 = current time
	sub t0, t1, s7
	li t2, 100 # delay de movimento (ms)
	blt t0, t2, GLOBAL_DRAW_END_NODRAW
  mv s7, t1
  la t0, XY
  li t3, -1
  sb t3, 0(t0)
ITER_X: 
  la t0, XY
  lb t1, 0(t0)
  la t2, MAP_WIDTH
  lb t2, (t2)

  bge t1,t2,GLOBAL_DRAW_END
	sb zero,1(t0)
	addi t1, t1, 1
  sb t1, 0(t0)
ITER_Y:
  lb t4, 1(t0)

  bgt t4,t2,ITER_X

  mv a1, t1
  mv a2, t4
	call GET_V
	call CORRELATE
	
  la t0, XY
  lb t1, (t0)
  lb t4, 1(t0)
  addi t4, t4, 1
  sb t4, 1(t0)

  la t2, MAP_WIDTH
  lb t2, 0(t2)

	j ITER_Y

GLOBAL_DRAW_END:
	la t0, LAST_TILE
  sw s8, (t0)
  li a1, 0
  li a2, 8
  call CLEAR_TILE

  lw a4, (s3)
	xori a4, a4, 1		#descobre o buffer antes de chamr swap frames
  mv a0, s5
  call PRINT_INT         #Chama print_int depois de swapar o buffer

  la t0, LAST_TILE
  lw s8, (t0)

	call SWAP_FRAMES # fallthrough
GLOBAL_DRAW_END_NODRAW:
	jr a6

# Correlate number to a tile and draw it at (a2,a1)
CORRELATE:
	mv t2,a3

	li t3,0
	beq t2,t3,COL_GROUND
	li t3,1
	beq t2,t3,COL_PLAYER
	li t3,8
	beq t2,t3,COL_WALL
	li t3,7
	beq t2,t3,COL_ENEMY
	li t3,9
	beq t2,t3,COL_SPIKE

# a0 = sprite we'll be drawing (28x28)
# a1 = tile y coordinate
# a2 = tile x coordinate

# Draw tile (tx,ty)
DRAW_TILE:
	lw t0,0(a0) # w
	# Load image dimensions
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

CLEAR_TILE:
  la a0, black
	lw t0,0(a0) # w
	# Load image dimensions
	lw t1,4(a0) # h
	# Translate absolute coordinates to tile coordinates
	mul a1,a1,t0  # y = ty * w
	mul a2,a2,t1  # x = tx * h
	# Add border offsets
	addi a1,a1,10
	addi a2,a2,-10
	
	mv a5,ra
	call RENDER
	mv ra,a5
	ret
  
