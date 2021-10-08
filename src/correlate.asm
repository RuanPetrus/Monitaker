COL_GROUND:
	la a0,floor_tile
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