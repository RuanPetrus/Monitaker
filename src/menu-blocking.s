.data
OPCAO: .word 1
.text

### Espera o usu�rio pressionar uma tecla
KEY2: 	csrr t1, time			# t1 = current time
	sub t0, t1, s6
	li t2, 100
	blt t0, t2, FIM_NOVO
	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM_NOVO			# n�o tem tecla pressionada ent�o volta ao loop
   	
   	csrr s6, time
   	
   	lw t2,4(t1)			# le o valor da tecla
  	
  	li t0 0x31			#1
	beq t2, t0, OP1  
	li t0 0x32			#2
	beq t2 ,t0, OP2
	li t0, 0x20			#ENTER
	beq t2, t0, ESCOLHE
	j FIM
# Opção 1
OP1:
	la a0, D_IMAGE1 # Carregar imagem selecionada para opção 1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	la t0, OPCAO
	li t1, 1
	sw t1, (t0)
	jr a6
# Opção 2
OP2:
	la a0, D_IMAGE2 # Carregar imagem selecionada para opção 2
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES

	la t0, OPCAO
	li t1, 2
	sw t1, (t0)
	jr a6
# Opção 3
OP3:
	la a0, D_IMAGE_WIN # Carregar imagem selecionada para opção 3
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES

	la t0, OPCAO
	li t1, 3
	sw t1, (t0)
	jr a6

# Definir se opção escolhida no diálogo foi a escolha certa ou errada
ESCOLHE:
	la t0, CUR_MAP # Mapa atual
	lb t1, (t0) # t1 = índice mapa atual
	# Testar se estamos na última fase (todas as opções são certas)
	li t2, 5 # t2 = comparação
	beq t2, t1, CERTA
	# Final do jogo (sair)
	li t2, 6
	beq t2, t1, FINAL_END

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
# Delay para próxima fase
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
# Delay para perder
TEMPO4:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO4
	
	j SEFODEU
	
FINAL_END:
	li a7, 10 # Fechar programa
	ecall

# Receber input blocking (menus, diálogos, etc.)
KEY3: 	
	csrr t1, time			# t1 = current time
	sub t0, t1, s6
	li t2, 100
	blt t0, t2, FIM_NOVO
	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM_NOVO		# n�o tem tecla pressionada ent�o volta ao loop
   	
   	csrr s6, time
   	
   	lw t2,4(t1)			# le o valor da tecla
  	
  	li t0 0x31			#1
	beq t2, t0, OP1  
	li t0 0x32			#2
	beq t2 ,t0, OP2
	li t0, 0x20			#SPACE
	beq t2, t0, SELECIONADO
	j FIM

# Seleção do menu principal
SELECIONADO:
	la t0, OPCAO
	lw t0, (t0)
	li t1, 1
	beq t1, t0, NOVOJOGO
	j FINAL_END

# Iniciar jogo
NOVOJOGO:
	j HISTORIA

# Opções menu de pausa
KEY4: 	
	csrr t1, time			# t1 = current time
	sub t0, t1, s6
	li t2, 100
	blt t0, t2, FIM_NOVO
	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM_NOVO		# n�o tem tecla pressionada ent�o volta ao loop
   	
   	csrr s6, time
   	
   	lw t2,4(t1)			# le o valor da tecla
  	
  	li t0 0x31			#1
	beq t2, t0, OP1  
	li t0 0x32			#2
	beq t2 ,t0, OP2
	li t0 0x33			#3
	beq t2 ,t0, OP3
	li t0, 0x20			#SPACE
	beq t2, t0, SELECIONADO2
	j FIM


# Seleções menu de pausa
SELECIONADO2:
	la t0, OPCAO
	lw t0, (t0)
	li t1, 1
	beq t1, t0, RESUME_O
	li t1, 2
	beq t1, t0, SKIP_O
	li t1, 3
	beq t1, t0, MAIN_MENU_O
	j RESUME_O


# Opções do menu de pausa
RESUME_O:
	j INIT_HUD

MAIN_MENU_O:
	j INIT_I

SKIP_O:
	j MAP_WIN

FIM_NOVO:
	j FIM
