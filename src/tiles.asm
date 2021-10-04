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
