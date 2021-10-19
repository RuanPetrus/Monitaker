.text
#################################################
#	a0 = endereco da imagem			#
#	a1 = x					#
#	a2 = y					#
#################################################
#	t0 = endereco do bitmap display		#
#	t1 = endereco da imagem			#
#	t2 = contador de linha			#
# 	t3 = contador de coluna			#
#	t4 = largura				#
#	t5 = altura				#
#################################################
		
RENDER:
	mv t0, s1
	add t0,t0,a1			# adiciona x ao t0
	
	li t1,320			# t1 = 320
	mul t1,t1,a2			# t1 = 320 * y
	add t0,t0,t1			# adiciona t1 ao t0
	
	addi t1,a0,8			# t1 = a0 + 8
	
	mv t2,zero			# zera t2
	mv t3,zero			# zera t3
		
	lw t4,0(a0)			# carrega a largura em t4
	lw t5,4(a0)			# carrega a altura em t5
	
P_LINHA:
	lw t6,0(t1)			# carrega em t6 uma word (4 pixeis) da imagem
	sw t6,0(t0)			# imprime no bitmap a word (4 pixeis) da imagem
		
	addi t0,t0,4			# incrementa endereco do bitmap
	addi t1,t1,4			# incrementa endereco da imagem
		
	addi t3,t3,4			# incrementa contador de coluna
	blt t3,t4,P_LINHA		# se contador da coluna < largura, continue imprimindo

	addi t0,t0,320			# t0 += 320
	sub t0,t0,t4			# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
		
	mv t3,zero			# zera t3 (contador de coluna)
	addi t2,t2,1			# incrementa contador de linha
	bgt t5,t2,P_LINHA		# se altura > contador de linha, continue imprimindo
		
	ret				# retorna
												
REV_RENDER:
	mv t0, s1
	add t0,t0,a1			# adiciona x ao t0
	
	li t1,320			# t1 = 320
	mul t1,t1,a2			# t1 = 320 * y
	add t0,t0,t1			# adiciona t1 ao t0
	
	addi t1,a0,8			# t1 = a0 + 8
	
	mv t2,zero			# zera t2
	mv t3,zero			# zera t3
		
	lw t4,0(a0)			# carrega a largura em t4
	lw t5,4(a0)			# carrega a altura em t5
	
  addi t6, t4, -1
  add t0, t0, t6

REV_P_LINHA:
	lb t6,0(t1)			# carrega em t6 uma word (4 pixeis) da imagem
	sb t6,0(t0)			# imprime no bitmap a word (4 pixeis) da imagem
		
	addi t0,t0,-1			# incrementa endereco do bitmap
	addi t1,t1,1			# incrementa endereco da imagem
		
	addi t3,t3,1			# incrementa contador de coluna
	blt t3,t4,REV_P_LINHA		# se contador da coluna < largura, continue imprimindo

	addi t0,t0,320			# t0 += 320
	add t0,t0,t4			# t0 -= largura da imagem
	# ^ isso serve pra "pular" de linha no bitmap display
		
	mv t3,zero			# zera t3 (contador de coluna)
	addi t2,t2,1			# incrementa contador de linha
	bgt t5,t2,REV_P_LINHA		# se altura > contador de linha, continue imprimindo
		
	ret				# retorna
