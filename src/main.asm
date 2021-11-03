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

INIT:
	jal INIT_VIDEO
	li s7,1
	# Music initialization
	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS


jal a6, PRIMEIRAS_ANIMACOES


INIT_I:

	la a1, MENU01
	la a0, MENU02
	call SET_IMAGES

	la t0, OPCAO
	li t1, 1
	sw t1, (t0)

	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
I_LOOP: 
	jal a6,KEY3		# le o teclado	blocking
	#jal P_MUS	
	j I_LOOP

HISTORIA:
	jal a6, D_HISTORIA

call MAPA01

INIT_G:
	# Movement initialization
	la s5 N_MOV
	lb s5 0(s5)
	li s6, 0

INIT_HUD:
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

INIT_O:
	la t0, OPCAO
	li t1, 1
	sw t1, (t0)

	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
O_LOOP: 
	jal a6,KEY2		# le o teclado	blocking
	#jal P_MUS	
	j O_LOOP


INIT_M:
	la a0, pause0
	la a1, pause1
	la a2, pause2
	call SET_IMAGES

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
	jal a6,KEY4		# le o teclado	blocking
	#jal P_MUS	
	j M_LOOP


	
	
.include "buffer.asm"
.include "render.asm"
.include "sound.asm"
.include "poling01.asm"
.include "movimentacao.asm"
.include "menu-blocking.asm"
.include "tiles.asm"
.include "correlate.asm"
.include "animation.asm"
.include "map_manager.asm"
.include "historyAnimation.asm"
.include "print_int.asm"
.include "board.asm"
.include "mapas.asm"
.include "SYSTEMv21.s"

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

#Dialogos MAP1
.include "../sprites/menu/dialog10.data"
.include "../sprites/menu/dialog11.data"
.include "../sprites/menu/dialog12.data"

#Dialogos MAP2
.include "../sprites/menu/dialog20.data"
.include "../sprites/menu/dialog21.data"
.include "../sprites/menu/dialog22.data"

#Dialogos MAP3
.include "../sprites/menu/dialog30.data"
.include "../sprites/menu/dialog31.data"
.include "../sprites/menu/dialog32.data"

#Dialogos MAP4
.include "../sprites/menu/dialog40.data"
.include "../sprites/menu/dialog41.data"
.include "../sprites/menu/dialog42.data"

#Dialogos MAP5
.include "../sprites/menu/dialog50.data"
.include "../sprites/menu/dialog51.data"

#MENUS
.include "../sprites/menu/creditosfinais.data"
.include "../sprites/menu/alerta_inicial.data"
.include "../sprites/menu/MENU01.data"
.include "../sprites/menu/MENU02.data"

#HISTORIA
.include "../sprites/menu/history0.data"
.include "../sprites/menu/history1.data"
.include "../sprites/menu/history2.data"
.include "../sprites/menu/history3.data"

#PAUSE
.include "../sprites/menu/pause0.data"
.include "../sprites/menu/pause1.data"
.include "../sprites/menu/pause2.data"

.text
