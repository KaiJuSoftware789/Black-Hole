# File to display and handle board for the game

.data

positionInvalidMsg: .asciiz "Position is invalid. Please try again.\n"

horizontalborder: .asciiz "+-----------+"
horizontalrefborder: .asciiz "+-----------------+"
referencegap: "\t"
verticalpad: .asciiz "|"
newline: .asciiz "\n"
space: .asciiz " "

# Gaps for displaying game board
gap1: .asciiz "     "
gap2: .asciiz "    "
gap3: .asciiz "   "
gap4: .asciiz "  "
gap5: .asciiz " "

# Gaps for displaying reference board
pgap1: .asciiz "        "
pgap2: .asciiz "       "
pgap3: .asciiz "      "
pgap4: .asciiz "     "
pgap4.5: .asciiz "    "   
pgap5: .asciiz "  "
pgap5.5: .asciiz " "

# Game data
# owner data stores owner type based off index of board address
# 0 = empty, 1 = player, 2 = computer
owner: .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
position: .word -1
playerHighestNumber: .byte 0
playerSum: .byte 0
compHighestNumber: .byte 0
computerSum: .byte 0

# Board data
positionBoard: .byte
1,
2, 3,
4, 5, 6,
7, 8, 9, 10,
11, 12, 13, 14, 15,
16, 17, 18, 19, 20, 21
   
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

	li $v0, 5
	syscall
	
	sw $v0, position
	
	li $v0, 4
	la $a0, newline
	syscall
	
	jr $ra
	
# Checks if position is valid
checkPositionValid:

	# Load given position and the board
	lw $t0, position
	la $t1, board
	
	# Checks if position is out of bounds
	blt $t0, 1, positionInvalid
    	bgt $t0, 21, positionInvalid
	
	# Convert the position to index
	addi $t0, $t0, -1
	
	# Align that index with the board address
	add $t1, $t1, $t0
	
	# Load byte to get what is at the board address
	lb $t2, 0($t1)

	# If position is "*" which is a free space, position is valid
	li $t3, '*'
	beq $t2, $t3, positionValid
	j positionInvalid
	
	
positionValid:
	jr $ra
	
placePosition:
	# Load position chosen
	lw $t0, position
	
	# Convert input to index
	addi $t0, $t0, -1
	
	# Point position to position on board
	la $t1, board
	add $t1, $t1, $t0
	
	# Stores owner type into respective index from board into owner array
	la $t3, owner
    	add $t3, $t3, $t0 
    	li $t4, 1 
    	sb $t4, 0($t3)     
	
	# Get the next number to place (increment playerHighestNumber)
    	lb $t2, playerHighestNumber
    	addi $t2, $t2, 1
    	sb $t2, playerHighestNumber
    	
    	# Check if number is 10. If so, use special character
	li $t3, 10
	beq $t2, $t3, placeTen
    	
    	# Convert integer to ASCII before storing number into board
    	addi $t2, $t2, 48
    	j storeNumber
    	
    	# Puts player's current number to position chosen
    	sb $t2, 0($t1)
    	
    	jr $ra
    	
placeTen:
li $t2, '#'

storeNumber:
sb $t2, 0($t1)
jr $ra
	
positionInvalid:
	
	# Print position invalid message
	li $v0, 4
	la $a0, positionInvalidMsg
	syscall
	
	# Saves return address on stack
	addi $sp, $sp, -4
	sw   $ra, 0($sp)
	
	jal getPosition
	
	
	# Restores address before jumping
	lw   $ra, 0($sp)
   	addi $sp, $sp, 4
   	
   	
	j checkPositionValid
	
resetBoard: 
	# Resets player's and computer's data
	sb $zero, playerHighestNumber
    	sb $zero, compHighestNumber
    	sb $zero, playerSum
    	sb $zero, computerSum 
    	
    	# Loads values to reset board back to original state
    	la $t0, board
    	li $t1, 21
    	li $t2, '*'
    	
resetLoop:
	
	# Iterates and goes through board array to reset it
	sb $t2, 0($t0)
    	addi $t0, $t0, 1
    	addi $t1, $t1, -1
    	bgt $t1, 0, resetLoop
    	
    	# Loads address of owner array after resetting board loop is done
    	la $t0, owner
    	li $t1, 21 
    	
resetOwner:
	
	# Goes through owner array and resets elements back to 0
	sb $zero, 0($t0)
    	addi $t0, $t0, 1
    	addi $t1, $t1, -1
    	bgt $t1, 0, resetOwner
    	
    	jr $ra

# Updates the screen after modifications
displayGameBoard:

	# Row 1

		# Borders
		li $v0, 4
		la $a0, horizontalborder
		syscall
		
		# Reference gap
		li $v0, 4
		la $a0, referencegap
		syscall
		
		# Borders
		li $v0, 4
		la $a0, horizontalrefborder
		syscall
		
		# Newline
		li $v0, 4
		la $a0, newline
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
		
		# Reference gap
		li $v0, 4
		la $a0, referencegap
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap1
		syscall
		
		
		# Character in row 1 of position board
		lb $a0, positionBoard
		li $v0, 1
		syscall
		
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap1
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
		
		# Reference gap
		li $v0, 4
		la $a0, referencegap
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, pgap2
		syscall
		
		
		# Characters in row 2 of position board
		lb $a0, positionBoard+1
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+2
		li $v0, 1
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap2
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
	
		lb $a0, board+4
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
		la $a0, gap3
		syscall
	
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Reference gap
		li $v0, 4
		la $a0, referencegap
		syscall
		
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, pgap3
		syscall
		
		# Characters in row 3 of board
		lb $a0, positionBoard+3
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+4
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+5
		li $v0, 1
		syscall
	
		# Gap to center row
		li $v0, 4
		la $a0, pgap3
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
		lb $a0, board+6
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+7
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+8
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+9
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
		
		
		# Reference gap
		li $v0, 4
		la $a0, referencegap
		syscall
		
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap4
		syscall
		
		# Characters in row 4 of board		
		lb $a0, positionBoard+6
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+7
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+8
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+9
		li $v0, 1
		syscall
		
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap4.5
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
		lb $a0, board+10
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+11
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+12
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+13
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+14
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
		
		# Reference gap
		li $v0, 4
		la $a0, referencegap
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap5
		syscall
		
		# Characters in row 5 of board
		lb $a0, positionBoard+10
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+11
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall

		lb $a0, positionBoard+12
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+13
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+14
		li $v0, 1
		syscall
		
		# Gap to center row
		li $v0, 4
		la $a0, pgap5.5
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
		lb $a0, board+15
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+16
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+17
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+18
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+19
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, board+20
		li $v0, 11
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, referencegap
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# Characters in row 6 of board
		lb $a0, positionBoard+15
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+16
		li $v0, 1
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+17
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+18
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+19
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+20
		li $v0, 1
		syscall
		
		# Vertical pad
		li $v0, 4
		la $a0, verticalpad
		syscall
		
		# End of row 6
		
		li $v0, 4
		la $a0, newline
		syscall
	
		li $v0, 4
		la $a0, horizontalborder
		syscall
		
		li $v0, 4
		la $a0, referencegap
		syscall
		
		li $v0, 4
		la $a0, horizontalrefborder
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		
		
		jr $ra 
	
		



