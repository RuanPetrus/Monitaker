.text

# REGISTRADORES
# s0 = front buffer
# s1 = back buffer
# s3 = current frame address
# s4 = music address
# s5 = turns
# s6 = last input time
# s7 = render permission (1 or 0)


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
	jal P_MUS
	jal a6, GLOBAL_DRAW
	j G_LOOP

M_LOOP: 
	jal a6,KEY2		# le o teclado	blocking
	jal P_MUS
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
