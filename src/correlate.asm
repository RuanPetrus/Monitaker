.data
POSICAOXY: .byte 0, 0

.text

COL_GROUND:
	la a0,floor
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret
COL_PLAYER:
	mv a4,ra
  la t0, POSICAOXY
  sb a1, 0(t0)
  sb a2, 1(t0)
  bne s8, zero, AAAA
  la a0, floor
  j DESENHA1
AAAA:
  la a0, spike
DESENHA1:
  jal DRAW_TILE

  la t0, POSICAOXY
  lb a1, 0(t0)
  lb a2, 1(t0)
	la a0,Player_Animation
  mv ra, a4
	j DRAW_ANIMATION
COL_WALL:
	la a0,wall
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret
COL_ENEMY:
	mv a4,ra
  la t0, POSICAOXY
  sb a1, 0(t0)
  sb a2, 1(t0)
  la a0, floor
  jal DRAW_TILE

  la t0, POSICAOXY
  lb a1, 0(t0)
  lb a2, 1(t0)
	la a0,enemy
	jal DRAW_TILE
	mv ra,a4
	ret

COL_SPIKE:
	la a0,spike
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret
