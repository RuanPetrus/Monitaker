.include "MACROSv21.s"
.text
PRINT_INT:
li a7 101
li a0 2000000
#mv a0 s5
#li a1  #Coluna
#li a2  #linha	
li a3 0x45
ecall
ret
.include "SYSTEMv21.s"	
	
	
	
	
	
	
	
	
	
	
	#Coleta
	#li t4 3			# chaves
	#beq t4 t6 COLETA 	#Permite mover se tiver chave
	#Passou de fase
	#li t4 2
	#beq t4 t6 SUCESS
