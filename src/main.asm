.text
INIT:	
	# Video test
	jal INIT_VIDEO
	li a0,0x07070707 # red
	jal PAINT_SCREEN
	jal SWAP_FRAMES
	li a0,0x38383838 # green
	jal PAINT_SCREEN
	jal SWAP_FRAMES

	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS
	
G_LOOP:	jal a6,KEY1
	jal P_MUS
	j G_LOOP

.include "video.asm"
.include "sound.asm"
.include "poling-non-blocking.asm"
