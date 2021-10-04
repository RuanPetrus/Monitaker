.text

# REGISTRADORES
# s0 = front buffer
# s1 = back buffer
# s3 = current frame address
# s4 = music address
# s5 = turns
# s6 = last input time

# a5 = tmp

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
	# Movement initialization
	la s5 N_MOV
	lb s5 0(s5)	# s11 = numero de movimentos disponiveis
	li s6, 0
	# Game loop
G_LOOP:
	jal a6,KEY1
	la a0, player
	la t0, PLAYER_POS	
	lb a1,1(t0)  # draw player on a1 tile (y)
	lb a2,(t0)   # draw player on a2 tile (x)
	call DRAW_TILE
	call SWAP_FRAMES
	jal P_MUS
	la a0,floor
	la t0,PLAYER_APOS
	lb a1,1(t0)
	lb a2,(t0)
	call DRAW_TILE
	j G_LOOP

M_LOOP: jal a6,KEY2		# le o teclado	blocking
	j M_LOOP


.include "tiles.asm"
.include "buffer.asm"
.include "render.asm"
.include "sound.asm"
.include "movimentacao.asm"
.include "mapa1.asm"
.include "poling01.asm"
.include "menu-blocking.asm"

.data
.include "../sprites/map.data"
.include "../sprites/player.data"
.include "../sprites/floor_tile.data"
