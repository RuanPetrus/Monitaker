.data
Opcao_1: .string "Voc� escolheu a op��o 1\n"
Opcao_2: .string "Voc� escolheu a op��o 2\n"
.text

### Espera o usu�rio pressionar uma tecla
KEY2: 	csrr t1, time			# t1 = current time
	sub t0, t1, s6
	li t2, 1000
	blt t0, t2, FIM
	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM			# n�o tem tecla pressionada ent�o volta ao loop
   	
   	csrr s6, time
   	
   	lw t2,4(t1)			# le o valor da tecla
  	
  	li t0 0x31			#1
	li t1 0x32			#2
	
um_dois: 
	beq t2 t0 Op1
	beq t2 t1 Op2
	jr a6 
	 
Op1:	la a0 Opcao_1
	li a7 4
	ecall
	call MAP_WIN
	jr a6
Op2:	la a0 Opcao_2
	li a7 4
	ecall
	jal G_LOOP
	jr a6
