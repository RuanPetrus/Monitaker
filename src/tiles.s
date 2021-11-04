GET_V:	
	# a1, a2 = x, y
	slli t1,a1,2
	slli t2,a2,2
	la t0,MATRIZ
	add t0,t0,t2
	lw t0,(t0)
	add t0,t0,t1
	lw a3,(t0)
	ret
SET_N_MOV:
	# Mudar no label
	la t0, N_MOV
	sb a0, (t0)
	# Mudar no registrador
	mv s5, a0
	ret

SET_OPCAO_CERTA:
	la t0, OPCAO_CERTA
	sw a0, (t0)
	ret

SET_IMAGES:
	la t0 , D_IMAGE1
	sw a0, (t0)

	la t0 , D_IMAGE2
	sw a1, (t0)

	la t0 , D_IMAGE_WIN
	sw a2, (t0)

	la t0 , D_IMAGE_LOS
	sw a3, (t0)

	ret

SET_PLAYER:
	# Somente o player e invertido.
	# a2 = x; a1 = y PARA O PLAYER
	la t0, PLAYER_POS
	sb a1, 1(t0) # y
	sb a2, (t0) # x
SET_V:
	# a1, a2 = x, y
	# a0 = o que queremos colocar
	slli t1,a1,2
	slli t2,a2,2
	la t0,MATRIZ
	add t0,t0,t2
	lw t0,(t0)
	add t0,t0,t1
	sw a0,(t0)
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
	beq t2,t3,COL_COLUNA_B
	li t3,10
	beq t2,t3,COL_COLUNA_C
	li t3,7
	beq t2,t3,COL_ENEMY
	li t3,9
	beq t2,t3,COL_SPIKE
	li t3,3
	beq t2,t3,COL_KEY
	li t3,4
	beq t2,t3,COL_CLOSE_DOOR
	li t3,5
	beq t2,t3,COL_OPEN_DOOR
	li t3,2
	beq t2,t3,COL_DEMON_GIRL
	li t3,6
	beq t2,t3,COL_BLOCK
	li t3,11
	beq t2,t3,COL_PRETO
	li t3,12
	beq t2,t3,COL_PAREDE


# a0 = sprite we'll be drawing (28x28)
# a1 = tile y coordinate
# a2 = tile x coordinate
# a3 = side to be drawing 

# Draw tile (tx,ty)
DRAW_TILE:
	lw t0,0(a0) # w
	# Load image dimensions
	lw t1,4(a0) # h
	# Translate absolute coordinates to tile coordinates
	mul a1,a1,t0  # y = ty * w
	mul a2,a2,t1  # x = tx * h
	# Add border offsets
	addi a1,a1,90
	addi a2,a2,10
	
	mv a5,ra

  beq a3, zero, DIREITA

	call REV_RENDER
	mv ra,a5
	ret

DIREITA:
  call RENDER
  mv ra, a5
  ret 

CLEAR_TILE:
  	la a0, black
	li a1, 25
	li a2, 180
	
	mv a5,ra
	call RENDER
	mv ra,a5
	ret
  
