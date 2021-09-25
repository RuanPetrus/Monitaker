# a0 = sprite que vamos desenhar (28x28)
# a1 = tile x coordinate
# a2 = tile y coordinate

# Draw tile (tx,ty)
DRAW_TILE:
	# Load image dimensions
	lw t0,0(a0) # w
	lw t1,4(a0) # h
	# Translate absolute coordinates to tile coordinates
	mul a1,a1,t0  # x = tx * w
	mul a2,a2,t1  # y = ty * h
	# Add border offsets
	addi a1,a1,48
	addi a2,a2,8
	
	mv s11,ra
	call RENDER
	mv ra,s11
	ret