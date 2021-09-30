.text
# !!!!!!!

# FALTA INTEGRAR EM MAIN

# !!!!!!!


# Exemplo Polling do teclado non-bloocking - JOGO NORMAL
	la s11 N_MOV
	lb s11 0(s11)	# s11 = numero de movimentos disponiveis
CONTA: 
	jal KEY1       		# le o teclado 	non-blocking
	j CONTA			# volta ao loop

KEY1:	li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se nenhuma tecla pressionada, vá para FIM
  	lw t2,4(t1)  			# t2 = valor da tecla teclada

	li t1 0x61			# Declara um minusculo adiantado p/ estrutura de decisao seguinte
	blt t2 t1 MAIUSCULO 		# Verifica se e maiusculo, se for, pula para correspondente
	# ASCII de WASD em cada registrador	
  	li t0 0x77 			#w 
  	li t1 0x61			#a
  	li t3 0x73			#s
  	li t4 0x64			#d
  	li t5 0x70			#p
  	jal WASD
  	
MAIUSCULO:
	li t0 0x57 			#W
  	li t1 0x41			#A
  	li t3 0x53			#S
  	li t4 0x44			#D
  	li t5 0x50			#P
WASD: 	# Se o conteudo de t2 for igual a um dos ASCII acima, a condicional ira chamar o procedimento correspondente
	beq t2 t0 UP
	beq t2 t1 LEFT
	beq t2 t3 DOWN
	beq t2 t4 RIGHT
	beq t2 t5 MANHA
	j CONTA

#A seguir, os procedimentos definidos:	
LEFT: 	
	li a0 -1
	li a1 1
	la a2 Player
	la a3 MATRIZ
	la a4 area
	j MOV_LR
RIGHT:
	li a0 1
	li a1 1
	la a2 Player
	la a3 MATRIZ
	la a4 area
	j MOV_LR
UP:
	li a0 -1
	li a1 1
	la a2 Player
	la a3 MATRIZ
	la a4 area
	j MOV_UD
DOWN:	
	li a0 1
	li a1 1
	la a2 Player
	la a3 MATRIZ
	la a4 area
	j MOV_UD
MANHA:		
	j CONTA
	#jr a6
FIM: 	
	j CONTA
	#jr a6