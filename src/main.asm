.include "video.asm"

.text
INIT:	
	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS
	
G_LOOP:	jal a6,KEY1
	jal P_MUS
	j G_LOOP

.include "sound.asm"
.include "poling-non-blocking.asm"