.text
	# a0= unidades a mover (negativo para esquerda(-1), positivo para direita(+1))
	# a1= o que vai ser movido (1 para player, 2 para ar, 0 para ch�o e parede)
	# a2= posicao do player (coluna, linha)
	# a3= label matriz - ponteiro
	# a4= tamanho da matriz do jogo (n_linhas, n_colunas)
	
	###### OBJETOS NA MATRIZ ######
	# 	chao = 0		#
	# 	player = 1	#
	# 	personagens = 2 	# 
	# 	chaves = 3	#
	# 	portasF = 4	#
	#	portasA = 5	#
	# 	blocos = 6	#
	# 	inimigos = 7	#
	# 	paredes = 8	#
	#	espinhos = 9	#
	###############################
	
# Movimentacao - Up/Down - Entre linhas
MOV_UD:
	lb t0,0(a2)		#Linha Origem  - t0 = indice da linha origem
	add t1,t0,a0		#Linha Destino - t1 = indice da linha destino
	#Verificacoess de limites de LINHAS da matriz:
	bltz t1,FIM		#verifica se o destino for menor que 0, ou seja, nada: n move
	lw t5,0(a4)		#t5 = numero de linhas
	bge t1,t5,FIM		#verifica se a posi��o de destino(t1) � maior que o n� de linhas existentes e n move
	# Origem:
	lb t2,1(a2)		#Coluna Origem: t2 = indice da coluna onde o jogador esta
	slli t2,t2,2		#t2 = t2 * 4, p/ encontrar a coluna na word
	slli t3,t0,2		#t3 = indice da linha de origem * 4
	add t3,t3,a3		#t3 = t3 + endereco da linha origem 
	lw t3,0(t3)		#t3 = linhax
	# Destino:
	slli t4,t1,2		#t4 = indice linha destino*4
	add t4,t4,a3		#t4 = endereco do destino na matriz
	lw t4,0(t4)		#t4 = linha destino correta / carrega a word do endere�o de destino
	add t5,t2,t4		#t5 = endereco linha destino
	lw t6,0(t5)		#t6 = objeto no endereco destino
	
	# Comparacoes de Colisoes Permitidas ou nao:
	# Free: 
	beq t6 zero MOV_UD_FREE	#Permite mover se tiver chao
	li t4 5		# porta Aberta
	beq t6 t4 MOV_UD_FREE	#Permite mover se tiver porta aberta
	# Obstaculo: NAO MOVE
	li t4 4		#Porta Fechada
	beq t6 t4 FIM		# N move
	li t4 8		#Parede
	beq t6 t4 FIM		# N move
	# Empuroes
	li t4 6			#Bloco
	beq t4 t6 MOV_UD_EMPU	#Empurra objeto
	li t4 7			#Inimigo
	beq t4 t6 MOV_UD_EMPU_ATK	#Empurra objeto
	
MOV_UD_EMPU:
	li a1 6
	j P0_EMPU_UD
MOV_UD_EMPU_ATK:
	li a1 7
P0_EMPU_UD:	
	bltz a0 P01_EMPU_UD		# identifica se move para frente ou tr�s
	addi a0 a0 1			# se positivo, +1 pra frente
	j P2_EMPU_UD
P01_EMPU_UD:
	addi a0 a0 -1			# se negativo, -1 para tras	
P2_EMPU_UD:	
	add a0 t0 a0		# a0 = linha destino do bloco/inimigo
				# t1 = linha origem do bloco/inimigo 	
	#Verificando limites da matriz
	bltz a0,EMPU_UD_FIM		#verifica se o destino for menor que 0, ou seja, nada: n move
	lw a7,4(a4)		#t5 = quantidade de colunas na matriz
	bge a0,a7,EMPU_UD_FIM	#verifica se a posi��o de destino(t1) � maior que o n� de coluna existentes: n move
	#Origem:			#t5 = ENDERECO ORIGEM DO OBJETO
	#			
	#Carregando objeto do destino
	slli a0,a0,2		#a0 = indice linha destino*4
	add a0,a0,a3		#a0 = endereco da linhax destino
	lw a0,0(a0)		#a0 = linhax destino
	add a0,t2,a0		#a0 = endereco linha destino
	lw t6,0(a0)		#t6 = objeto no endereco destino
	
	#Verificando objeto do local destino
	#Empuroes livres: portas abertas, chaves e chao
	li t4 7
	beq t4 a1 EMPU_UD_KILL
	li t4 0
	beq t4 t6 EMPU_UD_FREE
	li t4 5 
	beq t4 t6 EMPU_UD_FREE
	li t4 9
	beq t4 t6 EMPU_UD_FREE
	j FIM
EMPU_UD_KILL:
	# Verificar se o inimigo empurado esta diante de uma kill
	li t4 8 
	beq t4 t6 KILL_UD
	li t4 6 
	beq t4 t6 KILL_UD
	li t4 9 
	beq t4 t6 KILL_UD
	li t4 4 
	beq t4 t6 KILL_UD
	j EMPU_UD_FREE
EMPU_UD_FREE:
	sw zero,0(t5)		#t5(origem) = 0
	sw a1,0(a0)		#coloca o bloco no novo endereco
	j MOV_EFETIVADO	
KILL_UD:	
	sw zero,0(t5)		# t5(origem) = 0
	j MOV_EFETIVADO
	
MOV_UD_FREE:
	add t6,t2,t3		# t6 = endereco original (linhax + offset da coluna)
	sw zero,0(t6)		#t6 = 0
	sw a1,0(t5)		#coloca o jogador no novo endereco
	sb t1,0(a2)		#muda a posicao do jogador
	j MOV_EFETIVADO
	
# Movimentacao - Left/Rigth - Entre colunas

	# a0= unidades a mover (negativo para esquerda(-1), positivo para direita(+1))
	# a1= o que vai ser movido (1 para player, 2 para ar, 0 para ch�o e parede)
	# a2= posicao do player (coluna, linha)
	# a3= label matriz - para jogador n�o ultrapassar limites
	# a4= tamanho da matriz do jogo (n_linhas, n_colunas)
MOV_LR:
	lb t0,1(a2)		#Coluna de Origem  - t0 = indice da coluna onde o jogador esta
	add t1,t0,a0		#Coluna de Destino - t1 = indice da coluna destino (Coluna de Origem += 1 (ou -1))
	
	#Verificacoess de limites de COLUNAS da matriz:
	bltz t1,FIM		#verifica se o destino for menor que 0, ou seja, nada: n move
	lw t5,4(a4)		#t5 = quantidade de colunas na matriz
	bge t1,t5,FIM		#verifica se a posi��o de destino(t1) � maior que o n� de coluna existentes: n move
	#Origem:
	lb t2,0(a2)		#Linha de Origem - t2 = indice da linha onde o jogador esta
	slli t2,t2,2		#t2= endere�o da linha, como cada linha e um word, multiplica o indice por 4
	add t2,t2,a3		#t2 = endereco da linha na matriz = puxa o �ndice(t2)da label matriz (t2 = Matriz + x)
	lw t3,0(t2)		#t3 = linha = recebe o endere�o da linha de  origem = (t3 = LINHAX)
	#Destino:
	slli t2,t1,2		#t2 = indice da coluna destino * 4
	add t2,t2,t3		#t2 = endereco da linha de origem (recebe endere�o de linha de origem + indice da coluna destino * 4 (x*4)
	lw t4,0(t2)		#t4 = o objeto que estava no endereco da coluna de destino
	
	#Comparacoes de Colisoes Permitidas ou nao:
	#Free: 
	beq t4 zero MOV_LR_FREE	#Permite mover se tiver chao
	li t6 5			# porta Aberta
	beq t4 t6 MOV_LR_FREE	#Permite mover se tiver porta aberta
	#Obstaculo: NAO MOVE
	li t6 4			#Porta Fechada
	beq t4 t6 FIM		# N move
	li t6 8			#Parede
	beq t4 t6 FIM		# N move
	#Empuroes
	li t6 6			#Bloco
	beq t4 t6 MOV_LR_EMPU	#Empurra objeto
	li t6 7			#Inimigo
	beq t4 t6 MOV_LR_EMPU_ATK	#Empurra objeto
	
MOV_LR_EMPU:
	li a1 6			#Objeto que sera movido
	j P0_EMPU_LR	
MOV_LR_EMPU_ATK:
	li a1 7			#Objeto que sera movido
P0_EMPU_LR:	
	bltz a0 P01_EMPU_LR		# identifica se move para frente ou tr�s
	addi a0 a0 1			# se positivo, +1 pra frente
	j P2_EMPU_LR
P01_EMPU_LR:
	addi a0 a0 -1			# se negativo, -1 para tras	
P2_EMPU_LR:	
	add a0 t0 a0		# a0 = indice coluna destino do bloco/inimigo (t0 = index coluna origem)	
				# t1 = coluna de destino do bloco 
	#Verificando limites da matriz
	bltz a0,EMPU_LR_FIM		#verifica se o destino for menor que 0, ou seja, nada: n move
	lw t5,4(a4)		#t5 = quantidade de colunas na matriz
	bge a0,t5,EMPU_LR_FIM	# #verifica se a posi��o de destino(t1) � maior que o n� de coluna existentes: n move
	#Origem:			#t3 = linha de  origem = (t3 = LINHAX)
	#Destino:
	slli a0,a0,2		#t2 = indice da coluna destino * 4
	add a0,a0,t3		#t2 = endereco da linha de origem (recebe endere�o de linha de origem + indice da coluna destino * 4 (x*4)
	lw t4,0(a0)		#t4 = o objeto que estava no endereco da coluna de destino
	
	#Verificando objeto do local destino
	#Empuroes livres: portas abertas, chaves e chao
	li t6 7			# Se o que sera movido for um inimigo, fara as verificacoes
	beq a1 t6 EMPU_LR_KILL
	li t6 0
	beq t4 t6 EMPU_LR_FREE
	li t6 5 
	beq t4 t6 EMPU_LR_FREE
	li t6 9
	beq t4 t6 EMPU_LR_FREE
	j FIM
EMPU_LR_KILL:
	# Verificar se o inimigo empurado esta diante de uma kill
	li t6 8 			#Fatores de kill: paredes, blocos, espinhos e portasF
	beq t4 t6 KILL_LR
	li t6 6 
	beq t4 t6 KILL_LR
	li t6 9 
	beq t4 t6 KILL_LR
	li t6 4 
	beq t4 t6 KILL_LR
	j EMPU_LR_FREE
EMPU_LR_FREE:
	slli t6,t1,2		# t4 = offset index coluna origem
	add t6,t6,t3		# t4 = endereco original do objeto
	sw zero,0(t6)		# Coloca 0 onde o bloco estava
	sw a1,0(a0)		# muda posicao do bloco na matriz
	j MOV_EFETIVADO
KILL_LR:
	slli t6,t1,2		# t4 = indice da coluna origem do objeto 
	add t6,t6,t3		# t4 = endereco original do jogador
	sw zero,0(t6)		#!!! O local de origem do player ch�o que j� estava l� !!!
	j MOV_EFETIVADO
	
MOV_LR_FREE: #Label: "Nao ha obstaculos, mova:"
	slli t4,t0,2		# t4 = endere�o de coluna de origem
	add t4,t4,t3		# t4 = endereco original do jogador
	sw zero,0(t4)		#!!! O local de origem do player ch�o que j� estava l� !!!
	sw a1,0(t2)		#!!! coloca o jogador no novo endereco !!!
	sb t1,1(a2)		# muda a posicao do jogador na matriz 
	j MOV_EFETIVADO		
	
SEFODEU:
	la a0 morte
	li a7 4
	ecall
	li a7 10
	ecall
	
MOV_EFETIVADO:
	li s7,1                 # Algo na tela mudou, redesenhe
	addi s5,s5,-1		# A cada movimento: total de movimentos disponiveis - 1
	bltz s5, SEFODEU	# Verifa se s5 < 0
	mv a0,s5		# alocacao para print
	li a7 1			# cod de print int
	ecall			# chamada cod acima
	la a0,restam		# carrega mensagem de movimentos restantes
	li a7,4			# cod de print de string
	ecall			# chamada cod acima
	j FIM	



