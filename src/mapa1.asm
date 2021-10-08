.data
### OBJETOS NA MATRIZ ###
# 	ch�o = 0	#
# 	player = 1	#
# 	personagens = 2 #
# 	chaves = 3	#
# 	portasF = 4	#
#	portasA = 5	#
# 	blocos = 6	#
# 	inimigos = 7	#
# 	paredes = 8	#
#	espinhos = 9	#
#########################


# MAPA EM MATRIZ 8x8: - OBS: cada mapa pode ser em arquivos diferentes
LINHA0:	.word 1,0,0,0,0,0,0,0
LINHA1:	.word 0,0,0,0,0,0,0,0
LINHA2:	.word 0,0,0,0,0,0,0,0
LINHA3:	.word 0,0,0,0,0,0,0,0
LINHA4:	.word 0,0,0,0,0,0,0,0
LINHA5:	.word 0,0,0,0,0,0,0,0
LINHA6:	.word 0,0,0,0,0,0,0,0
LINHA7:	.word 0,0,0,0,0,0,0,0

MATRIZ: .word LINHA0,LINHA1,LINHA2,LINHA3,LINHA4,LINHA5,LINHA6,LINHA7 # pontero
PLAYER_APOS: .byte 0,0  # Posicao antiga do jogador
PLAYER_POS: .byte 0,0 	# Indice do jogador (linha e coluna)
area:	.word 8,8 	# n_linhas e colunas
N_MOV: 	.byte 30	# Numero de movimentos disponiveis nessa fase
restam: .string " movimentos restantes.\n"
morte:	.string "SE FODEU!\n"



