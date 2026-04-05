# File to handle player's fill selection on the game board
# File also handles input validation from drawboard.asm

.include "drawboard.asm"
.include "game.asm"

.data

positionInvalidMsg: "Position is invalid. Please try again.\n"

# Asterisks will be used to display available spots to fill with numbers     
board: .byte 

'*',
'*', '*',
'*', '*', '*',
'*', '*', '*', '*', 
'*', '*', '*', '*', '*', 
'*', '*', '*', '*', '*', '*'

# Board to help player find position to select
positionBoard: .byte

'1',
'2', '3',
'4', '5', '6',
'7', '8', '9', '10', 
'11', '12', '13', '14', '15', 
'16', '17', '18', '19', '20', '21'

.text

# Gets position that player wants to put their number in
getPosition:

	li $v0, 12
	syscall
	
	sb $v0, position
	
	jr $ra

# Checks if position is valid
checkPositionValidity:

	# If position is not "*" which is a free space, position is not valid
	
	# Position invalid msg
	
printInvalidMessage:
	
	li $v0, 4
	la $a0, positionInvalidMsg
	syscall
	jr $ra

	



