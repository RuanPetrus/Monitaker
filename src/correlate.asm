.data
POSICAOXY: .byte 0, 0

.text

COL_GROUND:
	la a0,floor
	mv a4,ra
  mv a3, zero
	jal DRAW_TILE
	mv ra,a4
	ret
COL_PLAYER:
	mv a4,ra
  la t0, POSICAOXY
  sb a1, 0(t0)
  sb a2, 1(t0)
  mv a3, zero
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
  mv ra, a4
	j DRAW_P_ANIMATION
COL_WALL:
	la a0,wall
	mv a4,ra
  mv a3, zero
	jal DRAW_TILE
	mv ra,a4
	ret
COL_ENEMY:
	mv a4,ra
  la t0, POSICAOXY
  sb a1, 0(t0)
  sb a2, 1(t0)
  mv a3, zero
  la a0, floor
  jal DRAW_TILE

  la t0, POSICAOXY
  lb a1, 0(t0)
  lb a2, 1(t0)
	mv ra,a4
	j DRAW_E_ANIMATION
	ret

COL_SPIKE:
	la a0,spike
	mv a4,ra
  mv a3, zero
	jal DRAW_TILE
	mv ra,a4
	ret
COL_KEY:
	la a0,spike
	mv a4,ra
  mv a3, zero
	jal DRAW_TILE
	mv ra,a4
	ret
COL_CLOSE_DOOR:
	la a0,black
	mv a4,ra
  mv a3, zero
	jal DRAW_TILE
	mv ra,a4
	ret
COL_OPEN_DOOR:
	la a0,floor
	mv a4,ra
	mv a3, zero
	jal DRAW_TILE
	mv ra,a4
	ret