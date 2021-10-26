.data
CUR_MAP: .byte 0 # Index do mapa atual

.text
MAP_WIN: # CUR_MAP += 1
	la t0, CUR_MAP
	lb t1, (t0)
	addi t1, t1, 1
	sb t1, (t0)
MAP_LOAD:
	la t0, CUR_MAP
	lb t1, (t0)
	li t2, 0
	beq t1, t2, MAPA01
	li t2, 1
	beq t1, t2, MAPA02
	li t2, 2
	beq t1, t2, MAPA03
	li t2, 3
	beq t1, t2, MAPA04
	li t2, 4
	beq t1, t2, MAPA05
	li t2, 5
	bge t1, t2, BEAT_GAME

.include "board.asm" # Matriz base
.include "mapas.asm" # Labels com comandos que modificam a matriz
