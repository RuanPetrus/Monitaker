DRAW_P_ANIMATION:
	la t2,Current_Player_Animation #endereço que segura o enderço da musica atual
  lw t3, 0(t2) # musica que vai tocar atual
  lw t0, (t3)   #Tamanho da animatição
  lw t1, 4(t3)  #Posicao atual da animacao
  ble t1, t0, PROX
  li t1, 1
  sw t1, 4(t3)
  la t3, Player_Stop_Animation
  sw t3, 0(t2) # colocando a default musica na musica atual
  lw t0 (t3)
  lw t1, 4(t3)
  ble t1, t0, PROX
  li t1, 1
PROX:  
  addi t2, t1, 1
  sw t2, 4(t3) 
  slli t1, t1, 2
  addi t1, t1, 4
  add t3, t3, t1
  lw a0, (t3)
  mv a3, s9
  j DRAW_TILE

   
DRAW_E_ANIMATION:
	la t2,Current_Skelet_Animation #endereço que segura o enderço da musica atual
  lw t3, 0(t2) # musica que vai tocar atual
  lw t0, (t3)   #Tamanho da animatição
  lw t1, 4(t3)  #Posicao atual da animacao
  ble t1, t0, PROX1
  li t1, 1
  sw t1, 4(t3)
  la t3, Skelet_Stop_Animation
  sw t3, 0(t2) # colocando a default musica na musica atual
  lw t0 (t3)
  lw t1, 4(t3)
  ble t1, t0, PROX1
  li t1, 1
PROX1:  
  addi t2, t1, 1
  sw t2, 4(t3) 
  slli t1, t1, 2
  addi t1, t1, 4
  add t3, t3, t1
  lw a0, (t3)

  
  mv a3, s9
  xori a3, a3, 1
  j DRAW_TILE

