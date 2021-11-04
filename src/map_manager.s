.data
CUR_MAP: .byte 0 # Index do mapa atual

.text
# Adiciona 1 ao mapa atual
MAP_WIN: # CUR_MAP += 1
	la t0, CUR_MAP
	lb t1, (t0)
	addi t1, t1, 1
	sb t1, (t0)
	
# Chama o mapa atual
MAP_LOAD:
	la t0, CUR_MAP
	lb t1, (t0)
	li t2, 0
	beq t1, t2, INTER_MAPA01
	li t2, 1
	beq t1, t2, INTER_MAPA02
	li t2, 2
	beq t1, t2, INTER_MAPA03
	li t2, 3
	beq t1, t2, INTER_MAPA04
	li t2, 4
	beq t1, t2, INTER_MAPA05
	li t2, 5
	beq t1, t2, INTER_MAPA06
	li t2, 6
	bge t1, t2, INTER_BEAT_GAME

INTER_MAPA01:
	j MAPA01

INTER_MAPA02:
	j MAPA02

INTER_MAPA03:
	j MAPA03

INTER_MAPA04:
	j MAPA04

INTER_MAPA05:
	j MAPA05

INTER_MAPA06:
	j MAPA06

INTER_BEAT_GAME:
	j BEAT_GAME