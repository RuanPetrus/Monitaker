.data
CUR_MAP: .byte 0 # Index do mapa atual

.text
MAP_WIN:

	la t0, CUR_MAP
	lb t1, (t0)
	addi t1, t1, 1
	sb t1, (t0)
	# CADEIA DE MAPAS
	# Nao precisa do MAPA01 porque iniciamos nele
	li t2, 1
	beq t1, t2, MAPA02
	li t2, 2
	bge t1, t2, BEAT_GAME

.include "board.asm" # Matriz base
.include "mapas.asm" # Labels com comandos que modificam a matriz
