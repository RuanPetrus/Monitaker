.data
LAST_TILE:	.word 0

.text
.include "MACROSv21.s"

# REGISTRADORES
# s0 = front buffer
# s1 = back buffer
# s3 = current frame address
# s4 = music address
# s5 = turns
# s6 = last input time
# s7 = render permission (1 or 0)
# s8 = thorn in last move (1 or 0)


# a5 = tmp


call MAPA01

INIT:
	jal INIT_VIDEO
	li s7,1
	# Music initialization
	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS
	# Movement initialization
	la s5 N_MOV
	lb s5 0(s5)	# s11 = numero de movimentos disponiveis
	li s6, 0

  lw a4, (s3)
	xori a4, a4, 1		
  mv a0, s5
  call PRINT_INT
  li s8, 0
	# Game loop
G_LOOP:
	jal a6,KEY1	
	jal P_MUS
	jal a6, GLOBAL_DRAW
	j G_LOOP

M_LOOP: 
	jal a6,KEY2		# le o teclado	blocking
	jal P_MUS
	la t0, LAST_TILE
	sw s8, (t0)
	li a0, 100
	call PRINT_INT
	la t0, LAST_TILE
	lw s8, (t0)
	j M_LOOP
	

.include "tiles.asm"
.include "buffer.asm"
.include "render.asm"
.include "sound.asm"
.include "movimentacao.asm"
.include "poling01.asm"
.include "menu-blocking.asm"
.include "correlate.asm"
.include "print_int.asm"
.include "SYSTEMv21.s"
.include "animation.asm"
.include "map_manager.asm"

.data
.include "../sprites/player.data"
.include "../sprites/floor1.data"
.include "../sprites/wall.data"
.include "../sprites/enemy.data"
.include "../sprites/spike.data"
.include "../sprites/black.data"
.include "animation.data"
