.data
MAP1LINHA0:	.word 11,11,10,10,10,11,11,11
MAP1LINHA1:	.word 11,10,08,08,08,00,01,11
MAP1LINHA2:	.word 11,08,00,00,07,00,00,11
MAP1LINHA3:	.word 10,08,00,07,00,07,11,11
MAP1LINHA4:	.word 08,00,00,11,11,11,11,10
MAP1LINHA5:	.word 08,00,06,00,00,06,00,08
MAP1LINHA6:	.word 08,00,06,00,06,00,02,11
MAP1LINHA7:	.word 11,11,11,11,11,11,11,11

MAP2LINHA0:	.word 11,11,10,10,10,11,11,11
MAP2LINHA1:	.word 11,10,08,08,08,00,01,11
MAP2LINHA2:	.word 11,08,00,00,07,00,00,11
MAP2LINHA3:	.word 10,08,00,07,00,07,11,11
MAP2LINHA4:	.word 08,00,00,11,11,11,11,10
MAP2LINHA5:	.word 08,00,06,00,00,06,00,08
MAP2LINHA6:	.word 08,00,06,00,06,00,02,11
MAP2LINHA7:	.word 11,11,11,11,11,11,11,11

MAP_1: .word MAP1LINHA0, MAP1LINHA1, MAP1LINHA2, MAP1LINHA3, MAP1LINHA4, MAP1LINHA5, MAP1LINHA6, MAP1LINHA7 # pontero
MAP_2: .word MAP2LINHA0, MAP2LINHA1, MAP2LINHA2, MAP2LINHA3, MAP2LINHA4, MAP2LINHA5, MAP2LINHA6, MAP2LINHA7 # pontero
CURRENT_MAP: .word MAP_1

XY2: .byte -1, 0  
MAP_WIDTH2: .byte 7
.text
GET_V2:	
	# a1, a2 = x, y
	slli t1,a1,2
	slli t2,a2,2
	la t0, CURRENT_MAP
	lw t0, (t0)
	add t0,t0,t2
	lw t0,(t0)
	add t0,t0,t1
	lw a3,(t0)
	ret

MAP:
	la t0, XY2
  	li t3, -1
  	sb t3, 0(t0)
ITER_X2: 
  	la t0, XY2
  	lb t1, 0(t0)
  	la t2, MAP_WIDTH2
  	lb t2, (t2)

  	bge t1,t2,INIT
	sb zero,1(t0)
	addi t1, t1, 1
  	sb t1, 0(t0)
ITER_Y2:
  	lb t4, 1(t0)

  	bgt t4,t2,ITER_X2

  	mv a1, t1
  	mv a2, t4
	call GET_V2
	mv a0, a3
	call SET_V
	
  	la t0, XY2
  	lb t1, (t0)
  	lb t4, 1(t0)
  	addi t4, t4, 1
  	sb t4, 1(t0)

  	la t2, MAP_WIDTH2
  	lb t2, 0(t2)

	j ITER_Y2
		
	j INIT # O primeiro mapa e carregado antes dos INITS do jogo


MAPA01:
	#         MAPA
	# 11 11 11 10 10 10 11 11
	# 11 11 10 08 08 08 00 01
	# 11 11 08 00 00 07 00 00
	# 11 10 08 00 07 00 07 11
	# 11 08 00 00 11 11 11 06
	# 11 08 00 06 00 00 06 00
	# 11 08 00 06 00 06 00 02
	# 11 11 11 11 11 11 11 11
	
	# Configurar turnos
	la t0, CURRENT_MAP
	la t1, MAP_1
	sw t1, (t0)

	li a0, 60
	call SET_N_MOV

	li a0, 1
	li a1, 6
	li a2, 1
	call SET_PLAYER
	
	j MAP


MAPA02:
	# Configurar turnos
	la t0, CURRENT_MAP
	la t1, MAP_2
	sw t1, (t0)

	li a0, 60
	call SET_N_MOV

	li a0, 1
	li a1, 6
	li a2, 1
	call SET_PLAYER
	
	j MAP

BEAT_GAME:
	li a7, 10
	ecall

CLEAR_MATRIX:
	mv a6, ra
	li a0, 0 # Constante: Encher de chaos
	li a1, -1 # x (comeca com -1 por causa da logica do loop)
	li a2, 0 # y
	# OBS: SET_V usa t0, 1 e 2, entao vamos com o 3.
	li t3, 7 # Constante: Tamanho do mapa (largura e altura)
ITER_HOR:
	bge a1, t3, CLEAR_MATRIX_END # SAIDA
	li a2, 0
	addi a1, a1, 1
ITER_VER:
	bgt a2, t3, ITER_HOR
	call SET_V
	addi a2, a2, 1
	j ITER_VER

CLEAR_MATRIX_END:
	mv ra, a6
	ret
