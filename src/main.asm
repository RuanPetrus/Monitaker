.data
PLAYER_POSITION:	.half 0,0
.text
INIT:	
	# Video initialization
	jal INIT_VIDEO
	la a0, map
	li a1, 0
	li a2, 0
	call RENDER
	call RENDER
	
	#Music initialization
	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS
	
	#Game LOOP
G_LOOP:	jal a6,KEY1
	la a0, player
	la t0, PLAYER_POSITION
	lh a1, (t0)
	lh a2, 2(t0)	
	call RENDER
	jal P_MUS
	j G_LOOP

.include "buffer.asm"
.include "render.asm"
.include "sound.asm"
.include "poling-non-blocking.asm"

.data
.include "../sprites/map.data"
.include "../sprites/player.data"
