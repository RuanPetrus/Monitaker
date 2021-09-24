.text
INIT_VIDEO:
	# On init, register names correlate to frame numbers,
	# but that won't always be the case.
	li s0,0xFF000000 # Front buffer: for display ONLY
	li s1,0xFF100000 # Back buffer: paint here!
	mv t1,ra
	jal REFRESH_BACK_BUFFER_END # s2 = back buffer end address
	mv ra,t1
	li s3,0xFF200604 # s3 = current frame number (0 or 1)
	
	# Force start on frame 0
	li t0,0
	sw t0,0(s3)
	ret

REFRESH_BACK_BUFFER_END:
	li t0,0x12C00 # Hardcoded number of pixels
	mv s2,s1
	add s2,s2,t0
	ret


SWAP_FRAMES:
	# Swap current frame
	lw t0,(s3)
	xori t0,t0,1
	sw t0,(s3)
	
	# Swap back and front buffers
	mv t0,s1
	mv s1,s0
	mv s0,t0
	
	mv t1,ra # REFRESH_BACK_BUFFER_END uses t0, so we store our ra in t1
	jal REFRESH_BACK_BUFFER_END
	mv ra,t1
	ret