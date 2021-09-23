.data
Opcao_1: .string "Você escolheu a opção 1\n"
Opcao_2: .string "Você escolheu a opção 2\n"
.text
# Polling do teclado - Blockin no menu - aguardando input
	li s0,0			# zera o contador
CONTA:  addi s0,s0,1		# incrementa o contador
	jal KEY1		# le o teclado	blockin	g
	j CONTA			# volta ao loop

### Espera o usuário pressionar uma tecla
KEY1: 	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP		# não tem tecla pressionada então volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
  	
  	li t0 0x31		#1
	li t1 0x32		#2
	
um_dois: 
	beq t2 t0 Op1
	beq t2 t1 Op2
	j CONTA
	 
Op1:	la a0 Opcao_1
	li a7 4
	ecall
	j CONTA
Op2:	la a0 Opcao_2
	li a7 4
	ecall
	j CONTA
