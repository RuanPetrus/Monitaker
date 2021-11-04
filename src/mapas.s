.data
#Mapa 01
MAP1LINHA0:	.word 11,11,10,10,10,11,11,11
MAP1LINHA1:	.word 11,10, 8, 8, 8, 0, 1,11
MAP1LINHA2:	.word 11, 8, 0, 0, 7, 0, 0,11
MAP1LINHA3:	.word 10, 8, 0, 7, 0, 7,11,11
MAP1LINHA4:	.word  8, 0, 0,11,11,11,11,10
MAP1LINHA5:	.word  8, 0, 6, 0, 0, 6, 0, 8
MAP1LINHA6:	.word  8, 0, 6, 0, 6, 0, 2,11
MAP1LINHA7:	.word 11,11,11,11,11,11,11,11

#Mapa 02
MAP2LINHA0:	.word 10,11,11,11,11,10,11,11
MAP2LINHA1:	.word  8, 0, 0, 0, 0, 8,11,11
MAP2LINHA2:	.word  8, 7,11, 9, 9, 0, 0,11
MAP2LINHA3:	.word  0, 9,11,11, 6, 6, 6,11
MAP2LINHA4:	.word  0, 0,11,11, 0, 0, 0,10
MAP2LINHA5:	.word  1, 0,11,10, 0, 7, 0, 8
MAP2LINHA6:	.word 11,11,11, 8, 2, 0, 7,11
MAP2LINHA7:	.word 11,11,11,11,11,11,11,11

#Mapa 03
MAP3LINHA0:	.word 11,11,10,11,11,11,11,11
MAP3LINHA1:	.word 11,11, 8, 0, 0, 2, 0,10
MAP3LINHA2:	.word 11,11, 8,12,12,12, 4, 8
MAP3LINHA3:	.word 11,11, 0, 9, 9, 0, 0, 1
MAP3LINHA4:	.word 11,11, 9,12, 9,12, 0, 0
MAP3LINHA5:	.word 11,10, 0, 0, 7, 9, 9,12
MAP3LINHA6:	.word  3, 8, 9,12, 9,12, 0,11
MAP3LINHA7:	.word  0, 0, 0, 0, 0, 7, 0,11

#Mapa 04
MAP4LINHA0:	.word 11,11,11,11,11,11,10,11
MAP4LINHA1:	.word 11,11,11,11, 2, 0, 8,10
MAP4LINHA2:	.word 11,11,11,10, 0, 4, 0, 8
MAP4LINHA3:	.word 11, 0, 3, 8, 6, 6, 6,12
MAP4LINHA4:	.word 11, 7, 6, 0, 7, 6, 0,11
MAP4LINHA5:	.word 10, 0,11, 7, 0, 0, 1,11
MAP4LINHA6:	.word  8, 9,11,12, 9,11,11,11
MAP4LINHA7:	.word 12, 9, 9, 9, 9,11,11,11

#Mapa 05
MAP5LINHA0:	.word 11, 10, 0, 1, 0 ,11,11,11
MAP5LINHA1:	.word 11, 8, 9 , 6, 6, 10,10,11
MAP5LINHA2:	.word  11, 0, 0, 0, 3, 8, 8,10
MAP5LINHA3:	.word  11, 12, 0, 6, 0 , 0, 8, 8
MAP5LINHA4:	.word  11, 12, 7, 0, 6, 6, 0, 0
MAP5LINHA5:	.word  11, 11, 0, 0, 6, 0, 7, 12
MAP5LINHA6:	.word 11, 11, 11, 11, 12, 4, 6, 0
MAP5LINHA7:	.word 11, 11, 11, 11, 12, 0, 2,11

# Mapa 06
MAP6LINHA0:	.word 11,11,11,11,11,10,11,11
MAP6LINHA1:	.word 10,11, 0, 2, 6, 8,10,11
MAP6LINHA2:	.word  8,10, 0, 0, 0, 0, 8,11
MAP6LINHA3:	.word  8, 8, 6, 4, 6,10, 8,11
MAP6LINHA4:	.word  6, 0, 6, 0, 0, 8, 0,12
MAP6LINHA5:	.word  0, 0, 6, 6, 6, 0, 0, 3
MAP6LINHA6:	.word  6, 6, 6, 0, 0, 6, 6, 0
MAP6LINHA7:	.word  1, 0, 6, 0, 0, 6, 0,11

MAP_1: .word MAP1LINHA0, MAP1LINHA1, MAP1LINHA2, MAP1LINHA3, MAP1LINHA4, MAP1LINHA5, MAP1LINHA6, MAP1LINHA7 # pontero
MAP_2: .word MAP2LINHA0, MAP2LINHA1, MAP2LINHA2, MAP2LINHA3, MAP2LINHA4, MAP2LINHA5, MAP2LINHA6, MAP2LINHA7 # pontero
MAP_3: .word MAP3LINHA0, MAP3LINHA1, MAP3LINHA2, MAP3LINHA3, MAP3LINHA4, MAP3LINHA5, MAP3LINHA6, MAP3LINHA7 # pontero
MAP_4: .word MAP4LINHA0, MAP4LINHA1, MAP4LINHA2, MAP4LINHA3, MAP4LINHA4, MAP4LINHA5, MAP4LINHA6, MAP4LINHA7 # pontero
MAP_5: .word MAP5LINHA0, MAP5LINHA1, MAP5LINHA2, MAP5LINHA3, MAP5LINHA4, MAP5LINHA5, MAP5LINHA6, MAP5LINHA7 # pontero
MAP_6: .word MAP6LINHA0, MAP6LINHA1, MAP6LINHA2, MAP6LINHA3, MAP6LINHA4, MAP6LINHA5, MAP6LINHA6, MAP6LINHA7 # pontero
CURRENT_MAP: .word MAP_1

XY2: .byte -1, 0  
MAP_WIDTH2: .byte 7
.text
# Coleta o valor na matriz
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

# Itera toda a matriz do mapa dado e salve na matriz principal
MAP:
	la t0, XY2
  	li t3, -1
  	sb t3, 0(t0)
ITER_X2: 
  	la t0, XY2
  	lb t1, 0(t0)
  	la t2, MAP_WIDTH2
  	lb t2, (t2)

  	bge t1,t2,INTER_INIT_G
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
	

INTER_INIT_G:		
	j INIT_G # O primeiro mapa e carregado antes dos INIT_GS do jogo



# Carrega informações do mapa atual para ser jogada
# Ex: Numero de movimentos, opção do dialogo, localização do player, sprites para
# o dialogo.
 MAPA01:	

	la t0, CURRENT_MAP
	la t1, MAP_1
	sw t1, (t0)

	li a0, 22
	call SET_N_MOV

	li a0, 2
	call SET_OPCAO_CERTA

	la a0, dialog10
	la a1, dialog11
	la a2, dialog12
	la a3, MORTE
	call SET_IMAGES


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

	li a0, 23
	call SET_N_MOV

	li a0, 1
	call SET_OPCAO_CERTA

	la a0, dialog20
	la a1, dialog21
	la a2, dialog22
	la a3, MORTE
	call SET_IMAGES

	li a0, 1
	li a1, 0
	li a2, 5
	call SET_PLAYER
	
	j MAP

 MAPA03:
	# Configurar turnos
	la t0, CURRENT_MAP
	la t1, MAP_3
	sw t1, (t0)

	li a0, 32
	call SET_N_MOV

	li a0, 2
	call SET_OPCAO_CERTA

	la a0, dialog40
	la a1, dialog41
	la a2, dialog42
	la a3, MORTE
	call SET_IMAGES

	li a0, 1
	li a1, 7
	li a2, 3
	call SET_PLAYER
	
	j MAP

 MAPA05:
	# Configurar turnos
	la t0, CURRENT_MAP
	la t1, MAP_4
	sw t1, (t0)

	li a0, 38
	call SET_N_MOV

	li a0, 1
	call SET_OPCAO_CERTA

	la a0, dialog30
	la a1, dialog31
	la a2, dialog32
	la a3, MORTE
	call SET_IMAGES

	li a0, 1
	li a1, 6
	li a2, 5
	call SET_PLAYER
	
	j MAP

 MAPA04:
	# Configurar turnos
	la t0, CURRENT_MAP
	la t1, MAP_5
	sw t1, (t0)

	li a0, 28
	call SET_N_MOV

	li a0, 2
	call SET_OPCAO_CERTA

	la a0, dialog60
	la a1, dialog61
	la a2, dialog63
	la a3, MORTE
	call SET_IMAGES

	li a0, 1
	li a1, 3
	li a2, 0
	call SET_PLAYER
	
	j MAP

 MAPA06:
	# Configurar turnos
	la t0, CURRENT_MAP
	la t1, MAP_6
	sw t1, (t0)

	li a0, 33
	call SET_N_MOV

	li a0, 1
	call SET_OPCAO_CERTA

	la a0, dialog50
	la a1, dialog50
	la a2, dialog51
	la a3, dialog51
	call SET_IMAGES

	li a0, 1
	li a1, 0
	li a2, 7
	call SET_PLAYER
	
	j MAP

# Quando se chega no final do jogo
BEAT_GAME:
	la a0, creditosfinais
	la a1, creditosfinais
	la a2, creditosfinais
	la a3, creditosfinais
	call SET_IMAGES

	j INIT_O

	li a7, 10
	ecall
