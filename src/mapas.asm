.text
MAPA01:
	mv s11, ra
	call CLEAR_MATRIX
	# Configurar turnos
	li a0, 9
	call SET_N_MOV
	# Colocar jogador
	li a0, 1
	li a1, 0
	li a2, 0
	call SET_PLAYER
	# Paredes
	li a0, 8
	li a1, 3
	li a2, 5
	call SET_V
	addi a2, a2, 1
	call SET_V
	addi a1, a1, 2
	call SET_V
	addi a2, a2, -1
	call SET_V
	# Inimigos
	addi a1, a1, -1
	li a0, 7
	call SET_V

	#key
	li a1, 2
	li a2, 2
	li a0, 3
	call SET_V

	#close door
	li a1, 3
	li a2, 3
	li a0, 4
	call SET_V

	#Demon girl
	li a1, 7
	li a2, 0
	li a0, 2
	call SET_V


	mv ra, s11
	ret


MAPA02:
	mv t1, ra
	call CLEAR_MATRIX
	# Configurar turnos
	li a0, 120
	call SET_N_MOV
	# Colocar jogador
	li a0, 1
	li a1, 5
	li a2, 2
	call SET_PLAYER
	# Paredes
	li a0, 8
	li a1, 4
	li a2, 5
	call SET_V
	addi a2, a2, 1
	call SET_V
	addi a1, a1, 3
	call SET_V
	addi a2, a2, -1
	call SET_V
	li a0, 9
	addi a1, a1, 1
	call SET_V
	addi a2, a2, 1
	call SET_V
	# Inimigos
	addi a1, a1, -3
	li a0, 7
	call SET_V
	mv ra, t1
	li s11, 0
	ret

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
