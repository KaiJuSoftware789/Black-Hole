# File to handle player's fill selection on the game board
# File also handles input validation from drawboard.asm

.include "game.asm"

.data

positionInvalidMsg: "Position is invalid. Please try again.\n"



.text

# Gets position that player wants to put their number in
getPosition:

	li $v0, 12
	syscall
	
	sb $v0, position
	
	jr $ra

# Checks if position is valid
checkPositionValid:

	# If position is not "*" which is a free space, position is not valid
	
	# Position invalid msg
	
printInvalidMessage:
	
	li $v0, 4
	la $a0, positionInvalidMsg
	syscall
	jr $ra

	



