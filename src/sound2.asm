.data
#LAST_DURATION: duration of the last note		label + 16
#LAST_PLAYED:	time when the last nome was played	label + 12
#MUSIC_NUM:	number of notes				label + 4
#NOTE_CONTER:	keep track of the notes			label + 8
#INSTRU_NUM:	Instrument number			label + 20
#VOL_NUM:	Volume number				label + 24
#Music label: .word MUSIC_NOTES, music_num, note_conter, last_played, last_duration, instru_num, volume_num
M_BG:		.word M_BG_NOTES, 63, 0, 0, 0, 24, 127
M_BG_NOTES:	60,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,60,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,62,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,62,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,65,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,65,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,74,234,67,234,72,234,67,234,74,234,67,234,76,234,67,234,77,234,67,234,76,234,67,234,74,234,67,234,72,469
M_TESTE:	.word M_TESTE_NOTES, 13, 0, 0, 0, 24, 127
M_TESTE_NOTES: 	69,500,76,500,74,500,76,500,79,600, 76,1000,0,1200,69,500,76,500,74,500,76,500,81,600,76,1000

.text
#Loop principal genérico apenas para teste
	jal P_TESTE
	jal a0,ST_MUS	
M_LOOP:	jal P_MUS
	
	j M_LOOP

P_TESTE:la t0, M_TESTE
	mv a1, t0


#Play Music
P_MUS:	lw t0, 12(a1)		#t0 = last_played
	beq t0, zero, P_CONT	#if last played == 0 THEN continue loop (firt ocurrence)
	
	csrr t1, time		#t1 = current time
	lw t2, 16(a1)		#t2 = last_note_duration
	
	sub t0, t1, t0		#t0 = current time - last played note time
	bge t0, t2, P_CONT	#if t0 > last nome duration play next note
	ret

#LOOP thrue notes
P_CONT: lw t0, 8(a1)		#t0 = note_conter
	lw t1, 4(a1)		#t1 = music num

	bne t0,t1, P_NOTE	#If t0 != t1 play note
	
	li t2, 0		#t2 = 0
	sw t2,8(a1)		#store 0 in note conter
	
	jal a0,ST_MUS		#Set Defalt value
	ret			#Return to main LOOP
	
#Play the note
P_NOTE:	mv t6, a1		#t6 = MUSIC adress
	lw t0, 8(t6)		#t0 = Note conter
	li t1, 8		#t1 = 8
	mul t1, t1, t0		#t1 = t0 * 8
	lw t2, 0(t6)		#t2 = notes adress
	add t1, t2, t1		#Adress of the right note
	
	lw a2, 20(t6)		#Read the instrument number
	lw a3, 24(t6)		#Read the instrument number
	lw a0, 0(t1)		#Read the value of the note
	lw a1, 4(t2)		#Read the duration of the note
	
	li a7, 31		#Define the syscall
	ecall			#Play the note
	
	sw a1, 16(t6)		#Store the value of the last duration
	
	csrr t5, time		#t5 = current time
	sw t5, 12(t6)		#Store the current time in last played
	
	addi t0,t0,1		#Add 1 to conter
	sw t0,8(t6)		#Store the conter in conter
	mv a1, t6		
	ret

#Set default values to play music
ST_MUS:	la a1, M_BG	
	jr a0
	
	
	