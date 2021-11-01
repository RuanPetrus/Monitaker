.text
KEY1:	
	csrr t1, time			# t1 = current time
	sub t0, t1, s6
	li t2, 250 # delay de movimento (ms)
	blt t0, t2, FIM
	
	li t1,0xFF200000        	# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)        		# Le bit de Controle Teclado
	andi t0,t0,0x0001        	# mascara o bit menos significativo
	beq t0,zero,FIM          	# Se nenhuma tecla pressionada, vá para FIM
	
	csrr s6, time			
	
	lw t2,4(t1)              	# t2 = valor da tecla teclada
	# ASCII de WASD-P-R em cada registrador
	li t3 0x77             #w
	beq t2 t3 UP 
	li t3 0x61            #a
	beq t2 t3 LEFT
	li t3 0x73            #s
	beq t2 t3 DOWN
	li t3 0x64            #d
	beq t2 t3 RIGHT
	li t3 0x70            #p
	beq t2 t3 MANHA
	li t3 0x72            #r
	beq t2 t3 RESET
	li t3 0x57             #W
	beq t2 t3 UP
	li t3 0x41            #A
	beq t2 t3 LEFT
	li t3 0x53            #S
	beq t2 t3 DOWN
	li t3 0x44            #D
	beq t2 t3 RIGHT
	li t3 0x50            #P
	beq t2 t3 MANHA
	li t3 0x52            #R
	beq t2 t3 RESET
	li t3 0x1b            #ESC
	beq t2 t3 MENU_OPCAO
	j FIM

MENU_OPCAO:
	j INIT_M

#A seguir, os procedimentos definidos:	
LEFT: 	
	li a0 -1
	li a1 1
	la a2 PLAYER_POS
	lb t1,(a2) # x
	lb t2,1(a2)# y
	la a3 MATRIZ
	la a4 area

  li s9, 1

	j MOV_LR
RIGHT:
	li a0 1
	li a1 1
	la a2 PLAYER_POS
	lb t1,(a2) # x
	lb t2,1(a2)# y
	la a3 MATRIZ
	la a4 area

  li s9, 0

	j MOV_LR
UP:
	li a0 -1
	li a1 1
	la a2 PLAYER_POS
	lb t1,(a2) # x
	lb t2,1(a2)# y
	la a3 MATRIZ
	la a4 area
	j MOV_UD
DOWN:	
	li a0 1
	li a1 1
	la a2 PLAYER_POS
	lb t1,(a2) # x
	lb t2,1(a2)# y
	la a3 MATRIZ
	la a4 area
	j MOV_UD
MANHA:	
	j INIT_O	
	#jr a6
EMPU_LR_FIM: 	
	li t6 7
	beq a1 t6 KILL_LR
	jr a6
EMPU_UD_FIM:
	li t4 7
	beq a1 t4 KILL_UD
	jr a6
FIM:
	jr a6
RESET:
	la a0, reset_and_sucess_pass
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	li t0, 500
	csrr t1, time
TEMPO666:
	csrr t2, time
	sub t2, t2, t1
	blt t2, t0, TEMPO666
	j MAP_LOAD
