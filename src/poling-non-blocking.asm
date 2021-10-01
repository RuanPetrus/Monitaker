.data
Click_W: .string "Voc� clicou na tecla W\n"
Click_A: .string "Voc� clicou na tecla A\n"
Click_S: .string "Voc� clicou na tecla S\n"
Click_D: .string "Voc� clicou na tecla D\n"
manha: .string "Trapa�a Ativada! Pulando de Fase...\n"
.text
# Exemplo Polling do teclado non-bloocking - JOGO NORMAL
	#li s0,0			# zera o contador
#CONTA: addi s0,s0,1		# incrementa o contador
	#jal KEY1       		# le o teclado 	non-blocking
	#j CONTA			# volta ao loop
#Verifica se h� tecla pressionada
KEY1:	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se n�o h� tecla pressionada ent�o vai para FIM
  	lw t2,4(t1)  			# t2 = valor da tecla teclada

	li t1 0x61
	blt t2 t1 MAIUSCULO 		# Verifica se � maiusculo, se for, pula para correspondente
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
WASD: 	# Se o conte�do de t2 for igual a um dos ASCII acima, a condicional ir� chamar o procedimento correspondente
	beq t2 t0 UP
	beq t2 t1 LEFT
	beq t2 t3 DOWN
	beq t2 t4 RIGHT
	beq t2 t5 MANHA
	jr a6 
#A seguir, os procedimentos que iremos definir, coloquei print para testar o funicionamento	
LEFT:
	la t0, PLAYER_POSITION
	lh t1, 0(t0)
	addi t1,t1,-1
	sh t1, 0(t0)
	la a0 Click_A
	li a7 4
	ecall
	li a0 -1
	jr a6
RIGHT:	
	la a0 Click_D
	li a7 4
	ecall
	li a0 1
	jr a6
UP:
	la t0, PLAYER_POSITION
	lh t1, 2(t0)
	addi t1,t1,-1
	sh t1, 2(t0)
	
	la a0 Click_W
	li a7 4
	ecall
	jr a6
DOWN:	
	la t0, PLAYER_POSITION
	lh t1, 2(t0)
	addi t1,t1,1
	sh t1, 2(t0)
	
	la a0 Click_S
	li a7 4
	ecall
	jr a6
RIGHT:	
	la t0, PLAYER_POSITION
	lh t1, 0(t0)
	addi t1,t1,1
	sh t1, 0(t0)

	la a0 Click_D
	li a7 4
	ecall
	jr a6
MANHA:		
	la s4, M_TESTE
	la a0 manha
	li a7 4
	ecall
	jr a6
	
FIM: 	jr a6

