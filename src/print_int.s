# Desenhar o contador de movimentos na tela usando SYSTEMv21.s e MACROSv21.s
PRINT_INT:
	li a7 101
	li a1, 25  # Coluna
	li a2, 180  # Linha	
	li a3 0x3
	ecall
	ret
