.data
PLAYER_POSITION:	.half 0,0
.text
INIT:
	jal INIT_VIDEO
	# Load map and draw it on both buffers
	la a0, map
	li a1, 0 # x
	li a2, 0 # y
	call RENDER
	call SWAP_FRAMES
	call RENDER
	call SWAP_FRAMES
	# Music initialization
	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS
	# Game loop
G_LOOP:
	jal a6,KEY1
	la a0, player
	la t0, PLAYER_POSITION
	lh a1,(t0)  # draw player on a1 tile (x)
	lh a2,2(t0) # draw player on a2 tile (y)
	call DRAW_TILE
	call SWAP_FRAMES
	jal P_MUS
	j G_LOOP

.include "tiles.asm"
.include "buffer.asm"
.include "render.asm"
.include "sound.asm"
.include "poling-non-blocking.asm"

.data
.include "../sprites/map.data"
.include "../sprites/player.data"
