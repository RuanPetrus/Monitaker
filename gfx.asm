.text
	# On init, register names correlate to frame numbers,
	# but that won't always be the case.
	li s0,0xFF000000 # Front buffer: for display ONLY
	li s1,0xFF100000 # Back buffer: paint here!
	jal REFRESH_BACK_BUFFER_END # s2 = back buffer end address
	li s3,0xFF200604 # s3 = current frame number (0 or 1)
	
	# Force start on frame 0
	li t0,0
	sw t0,0(s3)
	
	li a0,0x07070707 # red
	jal PAINT_SCREEN
	jal SWAP_FRAMES
	li a0,0x38383838 # green
	jal PAINT_SCREEN
	jal SWAP_FRAMES
	j QUIT

REFRESH_BACK_BUFFER_END:
	li t0,0x12C00 # Hardcoded number of pixels
	mv s2,s1
	add s2,s2,t0
	jr ra

PAINT_SCREEN:
	# a0 = 8-bit RGB code to paint with
	mv t0,s1 # Messing with the back buffer's address directly will break the system
	
	WHILE:
		bgt t0,s2, DONE
		sw a0,0(t0)
		addi t0,t0,4
		j WHILE
	DONE:
		jr ra

SWAP_FRAMES:
	# Swap current frame
	lw t0,(s3)
	xori t0,t0,1
	sw t0,(s3)
	
	# Swap back and front buffers
	mv t0,s1
	mv s1,s0
	mv s0,t0
	
	# Move ra to t1 to let REFRESH_BACK_BUFFER_END use it
	# Use t1 because REFRESH_BACK_BUFFER_END uses t0
	mv t1,ra
	jal REFRESH_BACK_BUFFER_END
	jr t1

QUIT:
	li a7,10
	ecall
