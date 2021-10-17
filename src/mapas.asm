.text
MAPA01:
	mv t1, ra
	call CLEAR_MATRIX
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
	mv ra,t1
	ret

CLEAR_MATRIX:
	mv a6, ra
	li a0, 0 # Constante: Encher de chaos
	li a1, -1 # x (começa com -1 por causa da lógica do loop)
	li a2, 0 # y
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
