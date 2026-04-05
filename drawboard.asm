# File to display and handle board for the game

.data

positionInvalidMsg: .asciiz "Position is invalid. Please try again.\n"

horizontalborder: .asciiz "+-----------+\n"
verticalpad: .asciiz "|"
newline: .asciiz "\n"
space: .asciiz " "

gap1: .asciiz "     "
gap2: .asciiz "    "
gap3: .asciiz "   "
gap4: .asciiz "  "
gap5: .asciiz " "


positionBoard: .byte
1,
2, 3,
4, 5, 6,
7, 8, 9, 10,
11, 12, 13, 14, 15,
16, 17, 18, 19, 20, 21

                                    
# Asterisks will be used to display available spots to fill with numbers     
board: .byte 

'*',
'*', '*',
'*', '*', '*',
'*', '*', '*', '*', 
'*', '*', '*', '*', '*', 
'*', '*', '*', '*', '*', '*'

.text
.globl displayGameBoard

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


# Updates the screen after modifications
displayGameBoard:

	# Row 1

		# Borders
		li $v0, 4
		la $a0, horizontalborder
		syscall
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, gap1
		syscall
	
		# Character in row 1 of board
		lb $a0, board
		li $v0, 11
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, gap1
		syscall
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		li $v0, 4
		la $a0, newline
		syscall
	
	# End of Row 1
	
	# Row 2
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, gap2
		syscall
	
		# Characters in row 2 of board
		lb $a0, board+1
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+2
		li $v0, 11
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, gap2
		syscall
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
	
		li $v0, 4
		la $a0, newline
		syscall
	
	# End of Row 2
	
	# Row 3
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, gap3
		syscall
		
		# Characters in row 3 of board
		lb $a0, board+3
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+3
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+3
		li $v0, 11
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, gap3
		syscall
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		li $v0, 4
		la $a0, newline
		syscall
	
	# End of Row 3
	
	# Row 4
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, gap4
		syscall
		
		
		# Characters in row 4 of board
		lb $a0, board+4
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+4
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+4
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+4
		li $v0, 11
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, gap4
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		li $v0, 4
		la $a0, newline
		syscall
	
	# End of row 4
	
	# Row 5
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, gap5
		syscall
		
		
		# Characters in row 5 of board
		lb $a0, board+5
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+5
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+5
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+5
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+5
		li $v0, 11
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, gap5
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		li $v0, 4
		la $a0, newline
		syscall
	
	# End of row 5
	
	# Row 6
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Characters in row 6 of board
		lb $a0, board+6
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+6
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+6
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+6
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+6
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+6
		li $v0, 11
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		li $v0, 4
		la $a0, newline
		syscall
	
	# End of row 6
	
	# Borders
	li $v0, 4
	la $a0, horizontalborder
	syscall
	
	jr $ra   


