COL_GROUND:
	la a0,floor
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret
COL_PLAYER:
	la a0,player
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret
COL_WALL:
	la a0,wall
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret
COL_ENEMY:
	la a0,enemy
	mv a4,ra
	jal DRAW_TILE
	mv ra,a4
	ret