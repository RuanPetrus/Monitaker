
DRAW_ANIMATION:
  lw t0, (a0)   #Tamanho da animatição
  lw t1, 4(a0)  #Posicao atual da animacao
  ble t1, t0, PROX
  li t1, 1
PROX:  
  addi t2, t1, 1
  sw t2, 4(a0) 
  slli t1, t1, 2
  addi t1, t1, 4
  add a0, a0, t1
  lw a0, (a0)
  j DRAW_TILE

  
   
