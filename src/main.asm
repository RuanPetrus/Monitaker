.data
LAST_TILE:	.word 0

.text
.include "MACROSv21.s"

# REGISTRADORES
# s0 = front buffer
# s1 = back buffer
# s3 = current frame address
# s4 = music address
# s5 = numero de movimentos/turnos
# s6 = last input time
# s7 = render permission (1 or 0)
# s8 = thorn in last move (1 or 0)
# s9 = side to render
# s11 = key or no key

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
	lb s5 0(s5)
	li s6, 0

	#Hud inicialization
	la a0, hud
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	la a0, hud
	li a1, 0
	li a2, 0
	call RENDER
	#DOOR INITIALIZATION
	li s11, 0

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

INIT_M:
	la t0, OPCAO
	li t1, 1
	sw t1, (t0)

	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
M_LOOP: 
	jal a6,KEY2		# le o teclado	blocking
	jal P_MUS	
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
.include "../sprites/misc/floor.data"
.include "../sprites/misc/key.data"
.include "../sprites/misc/door.data"
.include "../sprites/misc/stone.data"
.include "../sprites/misc/spike.data"
.include "../sprites/misc/ColunaBaixo.data"
.include "../sprites/misc/ColunaCima.data"
.include "../sprites/misc/parede.data"
.include "../sprites/wall.data"
.include "../sprites/enemy.data"
.include "../sprites/black.data"
.include "animation.data"
.include "../sprites/hud.data"

.include "../sprites/menu/MORTE.data"
.include "../sprites/menu/reset_and_sucess_pass.data"