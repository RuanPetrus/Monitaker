###############################################
#  File for music data			      #
#  ISC Set 2021				      #
#  Ruan Petrus Alves Leite		      #
###############################################
.data
#The music data is represented by a word array with the follow composition:
#	MUSIC_NOTES:	Address for the array of notes		label + 00
#	MUSIC_NUM:	number of notes				label + 04
#	NOTE_CONTER:	keep track of the notes			label + 08
#	LAST_PLAYED:	time when the last nome was played	label + 12
#	LAST_DURATION: 	duration of the last note		label + 16
#	INSTRU_NUM:	Instrument number			label + 20
#	VOL_NUM:	Volume number				label + 24
#EX of representation:
	#Music label: .word MUSIC_NOTES, music_num, note_conter, last_played, last_duration, instru_num, volume_num

#BACK GROUND:	
M_BG:		.word M_BG_NOTES, 63, 0, 0, 0, 24, 127

#SOUND EFFECTS:
M_TESTE:	.word M_TESTE_NOTES, 13, 0, 0, 0, 24, 127

#MUSIC NOTES:
M_BG_NOTES:	60,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,60,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,62,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,62,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,65,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,65,234,72,234,67,234,65,234,77,234,67,234,76,234,67,234,74,234,67,234,72,234,67,234,74,234,67,234,76,234,67,234,77,234,67,234,76,234,67,234,74,234,67,234,72,469
M_TESTE_NOTES: 	69,500,76,500,74,500,76,500,79,600, 76,1000,0,1200,69,500,76,500,74,500,76,500,81,600,76,1000
