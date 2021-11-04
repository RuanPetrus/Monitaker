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

# Recarrega o diálogo da fase atual
RELOAD_DIALOGUE:
	la t0, CUR_MAP
	lb t1, (t0)
	li t2, 0
	beq t1, t2, RELOAD_DIALOGUE_M1
	li t2, 1
	beq t1, t2, RELOAD_DIALOGUE_M2
	li t2, 2
	beq t1, t2, RELOAD_DIALOGUE_M3
	li t2, 3
	beq t1, t2, RELOAD_DIALOGUE_M4
	li t2, 4
	beq t1, t2, RELOAD_DIALOGUE_M5
	li t2, 5
	beq t1, t2, RELOAD_DIALOGUE_M6

RELOAD_DIALOGUE_M1:
	la a0, dialog10
	la a1, dialog11
	la a2, dialog12
	la a3, MORTE
	call SET_IMAGES
	j INIT_HUD

RELOAD_DIALOGUE_M2:
	la a0, dialog20
	la a1, dialog21
	la a2, dialog22
	la a3, MORTE
	call SET_IMAGES
	j INIT_HUD

RELOAD_DIALOGUE_M3:
	la a0, dialog40
	la a1, dialog41
	la a2, dialog42
	la a3, MORTE
	call SET_IMAGES
	j INIT_HUD

RELOAD_DIALOGUE_M4:
	la a0, dialog60
	la a1, dialog61
	la a2, dialog63
	la a3, MORTE
	call SET_IMAGES
	j INIT_HUD

RELOAD_DIALOGUE_M5:
	la a0, dialog30
	la a1, dialog31
	la a2, dialog32
	la a3, MORTE
	call SET_IMAGES
	j INIT_HUD

RELOAD_DIALOGUE_M6:
	la a0, dialog50
	la a1, dialog50
	la a2, dialog51
	la a3, dialog51
	call SET_IMAGES
	j INIT_HUD