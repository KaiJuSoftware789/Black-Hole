# Code where the game actually starts and plays till finished.
# Player and AI will go back and forth until the triangle of holes gets filled up numbers
# Winner is determined by least sum amounts from the numbers players put on the black hole board

.include "drawboard.asm"
.include "computer.asm"
.include "results.asm"

.data

# Announcements to player
game_msg: .asciiz "You have gone to the game portion of the program\n\n"


# Prompt to player
position_selection_prompt: .asciiz "Your turn to move.\n"

# Test message
# test_msg: .asciiz "Code has been passed.\n"






.text
.globl game

# Player gets prompted to move piece until the last number filled in is 10 for them 
# and the bot's last number filled is 10
game:
	# Save original return address to stack before doing other jal calls
	addi $sp, $sp, -4
    	sw   $ra, 0($sp)
    	
    	jal resetBoard

	# Player starts game and board displays.
	li $v0, 4
	la $a0, game_msg
	syscall

	# Displays game board
	jal displayGameBoard
	
	# Goes into game loop
	jal gameLoop
	
	# After game is completed, prints results
	jal printResults
	
	
	
		
	
	# Once both the player and computer reach number 10 on both their numbers used, nearest numbers respective
	# to each player are tallied up to their own sums

	# Player or computer with the least sum is crowned victor of the  game.
	
	
	# Restore orignal return address
	lw   $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
gameLoop:
	
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	
	# Tells user it is their turn to select
	li $v0, 4
	la $a0, position_selection_prompt
	syscall
	
	# Takes in position for player, checks validity, and places position on game baord
	jal getPosition
	jal checkPositionValid
	jal placePosition
	
	# Displays changed gameboard
	jal displayGameBoard
	
	# Checks if player has reach 10 moves
	# lb $t0, playerHighestNumber
	# li $t1, 10
   	# beq $t0, $t1, gameComplete
	
	# Performs computer's turn and displays it
	jal computerTurn
    	jal displayGameBoard
    	
    	
    	# Checks if both players reached 10
    	lb $t0, playerHighestNumber
    	lb $t1, compHighestNumber
    	bne $t0, $t1, continueGame
    	li $t2, 10
    	beq $t0, $t2, gameComplete
    	
    	# If player's highest number equals 10, goes gameCome
	beq $t0, $t2, gameComplete
    	
    	# If both highest numbers not equal, game loops again
    	bne $t0, $t1, gameLoop
    	
    	# If player's highest number does not equal 10, game loops again
	li $t2, 10
	bne $t0, $t2, gameLoop
	# Test message
	# li $v0, 4
	# la $a0, test_msg
	# syscall
	
	# li $v0, 10
	# syscall
	
	# Cleans return address to free up space in the stack
	lw   $ra, 0($sp)
    	addi $sp, $sp, 4
	j gameLoop



# Cleans stack for next iteration in the loop
continueGame:
    	lw   $ra, 0($sp)
   	addi $sp, $sp, 4
    	j gameLoop	

# Restores original address to return to main after game is complete
gameComplete:
	lw   $ra, 0($sp)
	addi $sp, $sp, 4
    	jr   $ra