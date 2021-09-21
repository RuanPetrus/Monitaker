.data
LAST_DURATION:	.word 0		# duration of the last note
LAST_PLAYED:	.word 0		# time when the last nome was played
MUSIC_NUM:	.word 63	# number of notes
MUSIC_NOTES:	60,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,60,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,62,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,62,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,65,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,65,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,74,234,67,234,72,234,67,234,74,234,67,234,76,234,67,234,77,234,67,234,76,234,67,234,74,234,67,234,72,469
NOTE_CONTER:	.word 0
INSTRU_NUM:	.word 24	#Instrument number
VOL_NUM:	.word 127	#Volume number

.text
	jal a0,ST_MUS
M_LOOP:	jal P_MUS
	
		
	
	j M_LOOP

	#Play music
P_MUS:	la t1,LAST_PLAYED	#adress of the last played
	lw t1,0(t1)		#t1 = last played
	beq t1, zero, P_CONT	#if last played == 0 THEN continue loop (firt ocurrence)
	
	li a7, 30		#define the syscall time
	ecall			#a0 = current time
	la t0, LAST_DURATION	#last duration adress
	lw t0,0(t0)		#t0 = last note duration
	sub t1, a0, t1		#t1 = current time - last played note time
	bge t1, t0, P_CONT	#if t1 > last nome duration play next note
	ret			#Return to main LOOP

	#LOOP thrue notes
P_CONT:	la t0, NOTE_CONTER	#Adress of note_conter
	lw t0, 0(t0)		#t0 = note_conter	
	la t1, MUSIC_NUM	#Adress of MUSCIC_NUM
	lw t1, 0(t1)		#t1 = music num

	bne t0,t1,P_NOTE	#If t0 != t1 play note
	jal a0,ST_MUS		#Set Defalt value
	ret			#Return to main LOOP

	#Play the note
P_NOTE:	la t0, NOTE_CONTER	#Note conter adress
	lw t1, 0(t0)		#Note conter value
	li t2, 8		#t2 = 8
	mul t2, t1, t2 		#t2 = t1 * 8
	la t3, MUSIC_NOTES	#Adress of music_notes
	add t2, t3, t2		#t2 = t3 + t1*8
	
	lw a0, 0(t2)		#Read the value of the note
	lw a1, 4(t2)		#Read the duration of the note
	
	la t4, INSTRU_NUM	#Adress of the number of the instrument
	lw a2, 0(t4)		#Loading to a2 to number of the instrument
	
	la t4, VOL_NUM		#Adress of the number of the instrument
	lw a3, 0(t4)		#Loading to a3 the number of the volume
	
	li a7, 31		#Define the syscall
	ecall			#Play the note
	
	la t5,LAST_DURATION	#Last duration adress
	sw a1,0(t5)		#Store the duration in the last duration time
	
	li a7,30		#Define the syscall Time
	ecall			#a0 = current time
	la t6, LAST_PLAYED	#t6 = last played adress
	sw a0,0(t6)		#Store the current time in last played
	
	addi t1, t1, 1
	sw t1,0(t0)								
	ret

	#Set default values to play music
ST_MUS:	la t1, NOTE_CONTER	#adress of note conter
	li t2, 0		#t2 = 0
	sw t2,0(t1)		#store 0 in note conter
	
	jr a0
