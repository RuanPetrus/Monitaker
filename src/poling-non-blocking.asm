.data
Click_W: .string "Você clicou na tecla W\n"
Click_A: .string "Você clicou na tecla A\n"
Click_S: .string "Você clicou na tecla S\n"
Click_D: .string "Você clicou na tecla D\n"
manha: .string "Trapaça Ativada! Pulando de Fase...\n"
.text
# Polling do teclado non-bloocking - JOGO NORMAL
	li s0,0			# zera o contador
CONTA:  addi s0,s0,1		# incrementa o contador
	jal KEY1       		# le o teclado 	non-blocking
	j CONTA			# volta ao loop
#Verifica se há tecla pressionada
KEY1:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se não há tecla pressionada então vai para FIM
  	lw t2,4(t1)  			# t2 = valor da tecla teclada

	li t1 0x61
	blt t2 t1 MAIUSCULO 		# Verifica se é maiusculo, se for, pula para correspondente
	# ASCII de WASD em cada registrador	
  	li t0 0x77 			#w 
  	li t1 0x61			#a
  	li t3 0x73			#s
  	li t4 0x64			#d
  	li t5 0x70			#p
  	j WASD
MAIUSCULO:
	li t0 0x57 			#W
  	li t1 0x41			#A
  	li t3 0x53			#S
  	li t4 0x44			#D
  	li t5 0x50			#P
WASD: 	# Se o conteúdo de t2 for igual a um dos ASCII acima, a condicional irá chamar o procedimento correspondente
	beq t2 t0 UP
	beq t2 t1 LEFT
	beq t2 t3 DOWN
	beq t2 t4 RIGHT
	beq t2 t5 MANHA
	j CONTA
LEFT: #A seguir, os procedimentos que iremos definir, coloquei print para testar o funicionamento
	la a0 Click_A
	li a7 4
	ecall
	j CONTA
UP:
	la a0 Click_W
	li a7 4
	ecall
	j CONTA
DOWN:
	la a0 Click_S
	li a7 4
	ecall
	j CONTA
RIGHT:
	la a0 Click_D
	li a7 4
	ecall
	j CONTA
MANHA:
	la a0 manha
	li a7 4
	ecall
	j CONTA

FIM:	ret
