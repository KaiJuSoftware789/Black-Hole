# Code where the game actually starts and plays till finished.
# Player and AI will go back and forth until the triangle of holes gets filled up numbers
# Winner is determined by least sum amounts from the numbers players put on the black hole board

.include drawboard.asm
.include computer.asm

.data

# Announcements to player
game_msg: .asciiz "You have gone to the game portion of the program\n\n"
win_announcement .asciiz "You claim victory!!!!! :)"
lose_announcement .asciiz "You have lost! :("

# Prompt to player
position_selection_prompt: .asciiz "Your turn to move.\n"


position .byte -1
playerHighestNumber: .byte 0
playerSum: .byte 0
compHighestNumber: .byte 0
computerSum: .byte 0


.text
.globl game

# Player gets prompted to move piece until the last number filled in is 10 for them 
# and the bot's last number filled is 10
game:

	# Player starts game and board displays.
	li $v0, 4
	la $a0, game_msg
	syscall
	
	# Displays game board
	jal displayGameBoard
	
	# Tells user it is their turn to select
	li $v0, 4
	la $a0, position_selection_prompt
	syscall
	
	jal getPosition

	

		# Game takes in player's input by movement along the game board( w, a, s, d, respectively) 
		# ! character will represent what current position they are selecting/hovering over.
	
	
	
		# Game board will take in player's selected position and put their next number to use on that position

		# Computer will select a random position and fill that in with the next number to use on that position
	
	# Once both the player and computer reach number 10 on both their numbers used, nearest numbers respective
	# to each player are tallied up to their own sums

	# Player or computer with the least sum is crowned victor of the  game.


	jr $ra



# Goes through procedure of displaying board to player
conductPlayerTurn:
	
	# Tells user it is their turn to select
	li $v0, 4
	la $a0, position_selection_prompt
	syscall
	
	# Displays game board
	jal displayGameBoard
	jal getPosition
	
	jr $ra
	
printResults:


