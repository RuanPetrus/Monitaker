.data
OPCAO: .word 1
.text

### Espera o usu�rio pressionar uma tecla
KEY2: 	csrr t1, time			# t1 = current time
	sub t0, t1, s6
	li t2, 100
	blt t0, t2, FIM
	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM			# n�o tem tecla pressionada ent�o volta ao loop
   	
   	csrr s6, time
   	
   	lw t2,4(t1)			# le o valor da tecla
  	
  	li t0 0x31			#1
	beq t2, t0, OP1  
	li t0 0x32			#2
	beq t2 ,t0, OP2
	li t0, 0x20
	beq t2, t0, ESCOLHE
	j FIM
OP1:
	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	la t0, OPCAO
	li t1, 1
	sw t1, (t0)
	jr a6
OP2:
	la a0, D_IMAGE2
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES

	la t0, OPCAO
	li t1, 2
	sw t1, (t0)
	jr a6

ESCOLHE:
	la t0, OPCAO
	lw t0, (t0)
	la t1, OPCAO_CERTA
	lw t1, (t1)

	beq t1, t0, CERTA
	j ERRADA


CERTA:
	la a0, D_IMAGE_WIN
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES

	li t0, 3000
	csrr t1, time
TEMPO3:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO3
	j MAP_WIN

ERRADA:
	la a0, D_IMAGE_LOS
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES

	li t0, 3000
	csrr t1, time
TEMPO4:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO4
	
	j SEFODEU
	
	
	
