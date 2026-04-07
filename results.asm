
.data
win_announcement: .asciiz "You claim victory!!!!! :)\n"
lose_announcement: .asciiz "You have lost! :(\n"
tie_announcement: .asciiz "It's a tie! :o\n"
player_sum_msg: .asciiz "Your sum: "
comp_sum_msg: .asciiz "Computer's sum: "

.text
.globl printResults

printResults:
	# Save return address on stack
	addi $sp, $sp, -4
    	sw   $ra, 0($sp)
findBlackHole:
	# Load board address
	la $t0, board
	
	# Load index counter
    	li $t1, 0  
    	
    	# Load total positions         
    	li $t2, 21          

searchLoop:

	# Loads board address being pointed to 
	# and checks if it is a empty space. Goes to store index of black hole if so.
    	lb $t3, 0($t0)
    	li $t4, '*'
    	beq $t3, $t4, foundHole
    
    	# Reiterates loop 
	addi $t0, $t0, 1    # next board slot
    	addi $t1, $t1, 1    # increment index
    	blt $t1, $t2, searchLoop

foundHole:
	# Stores index of black hole
	move $s0, $t1
	
	
findRow:

	# Finds which row the index is in
	beq $s0, 0, row1
    	blt $s0, 3, row2     
    	blt $s0, 6, row3     
    	blt $s0, 10, row4    
    	blt $s0, 15, row5    
    	j row6
    	
# Assigns the number of columns the row will have
row1: li $s1, 1
      j calcNeighbors
row2: li $s1, 2
      j calcNeighbors
row3: li $s1, 3
      j calcNeighbors
row4: li $s1, 4
      j calcNeighbors
row5: li $s1, 5
      j calcNeighbors
row6: li $s1, 6
      j calcNeighbors
      

# Goes through different section of neighbors for the black hole
calcNeighbors:
    

   	 # Goes through all possible top left neighbors
    
    	# Skips if first row
    	beq $s1, 1, belowAndRightNeighbors
    	
    	# Shifts the neighbor index to be right next to the black hole index
    	sub $t2, $s0, $s1
    	addi $t2, $t2, 1       
    	jal addIfOwned

    	# Goes through all top right (not valid for row 1
    	# Shifts the neighbor index to be right next to the black hole index
    	sub $t2, $s0, $s1
    	addi $t2, $t2, 2
    	jal addIfOwned

belowAndRightNeighbors:
    	# Goes through all possible below neighbors
    
    	# Skips if bottom row
    	beq $s1, 6, leftNeighbors
    	# Shifts the neighbor index to be right next to the black hole index
    	add $t2, $s0, $s1
    	jal addIfOwned

    	# Goes through all possible bottom right neighbors
    	# Shifts the neighbor index to be right next to the black hole index
    	add $t2, $s0, $s1
    	addi $t2, $t2, 1
    	jal addIfOwned

leftNeighbors:
    	# Goes through all possible left neighbors
    
    	# Skips if there is no left edge
    	jal isLeftEdge
    	beq $v0, 1, rightNeighbors
    	addi $t2, $s0, -1
    	jal addIfOwned

rightNeighbors:
    	# Goes through all the possible right neigbors
    
    	# Skips if there are no right neighbors
    	jal isRightEdge
    	beq $v0, 1, compareResults
	addi $t2, $s0, 1
    	jal addIfOwned
    	j compareResults
    
# Checks if neighbor index is at left edge 
isLeftEdge:
    	beq $s0, 0, isEdge
    	beq $s0, 1, isEdge
    	beq $s0, 3, isEdge
    	beq $s0, 6, isEdge
    	beq $s0, 10, isEdge
    	beq $s0, 15, isEdge
    	li $v0, 0
    	jr $ra

# Checks if neighbor index is at right edge
isRightEdge:
    	beq $s0, 0, isEdge
    	beq $s0, 2, isEdge
    	beq $s0, 5, isEdge
    	beq $s0, 9, isEdge
    	beq $s0, 14, isEdge
    	beq $s0, 20, isEdge
    	li $v0, 0
    	jr $ra

# Makes $v0 1 to indicate if black hole is on an edge
isEdge:
    	li $v0, 1
    	jr $ra
    
addIfOwned:

	# Loads base address of owner array
    	la $t3, owner
    	
    	# Moves to specific address on positionBoard from neighbor index
    	add $t3, $t3, $t2
    	lb $t4, 0($t3)
    	
    	# Adds to respective sums depending on owner type (1 for player, 2 for computer)
    	li $t5, 1
    	beq $t4, $t5, addToPlayer
    	li $t5, 2
    	beq $t4, $t5, addToComp
    	jr $ra

addToPlayer:
	
	# Loads base address of game board
    	la $t3, board
    	
    	# Moves to specific neighbor index on the game baord
    	add $t3, $t3, $t2
    	
    	# Loads character from board address
    	lb $t4, 0($t3)
    	
    	# Checks if it is special character (#) for 10
    	li $t6, '#'
    	beq $t4, $t6, playerTen
    	
    	# Converts the ASCII back to integer
    	addi $t4, $t4, -48
    	
    	# Loads playerSum
    	lb $t5, playerSum
    	
    	# Adds integer from game board to the player sum
    	add $t5, $t5, $t4
    	sb $t5, playerSum
    	jr $ra
    	
playerTen:
	li $t4, 10
	
addPlayerSum:

	# Loads address of playerSum into $t5
	lb $t5, playerSum
	
    	# Adds integer from board address to player sum
	add $t5, $t5, $t4
	
    	# Stores sum back into playerSum	
    	sb $t5, playerSum
    	jr $ra

addToComp:
	
	# Loads base address of game board
    	la $t3, board
    	
    	# Moves to specific neighbor index on the game baord
    	add $t3, $t3, $t2
    	
    	# Loads character from board address
    	lb $t4, 0($t3)
    	
    	
    	# li $v0, 1
    	# move $a0, $t4
    	# syscall
    	
    	
    	# Checks if it is special character (#) for 10
    	li $t6, '#'
    	beq $t4, $t6, compTen
    	
    	# Converts the ASCII back to integer
    	addi $t4, $t4, -48
    	
    	# Loads computerSum
    	lb $t5, computerSum
    	
    	# Adds integer from game board to the computer sum
    	add $t5, $t5, $t4
    	sb $t5, computerSum
    	jr $ra
    	
compTen:
	li $t4, 10
    	
addCompSum:
	
	# Loads address of computerSum into $t5
    	lb $t5, computerSum
    	
    	# Adds integer from board address to computer sum
    	add $t5, $t5, $t4
    	
    	# Stores sum back into computerSum
    	sb $t5, computerSum
    	jr $ra

compareResults:

	# Loads player and computer sums
    	lb $t0, playerSum
    	lb $t1, computerSum
    
    	# Determines which if player won or computer won
    	blt $t0, $t1, playerWon
    	bgt $t0, $t1, computerWon
    
    	# If there is a tie, announces tie
    	li $v0, 4
    	la $a0, tie_announcement
    	syscall
    	j printSums
    	
    	
 playerWon:
  	li $v0, 4
    	la $a0, win_announcement
    	syscall
    	j printSums
    	j endResults
 
computerWon:
    	li $v0, 4
    	la $a0, lose_announcement
    	syscall
    	j printSums
    	j printSums
    	
 printSums:
 
 	# Prints player's sum
    	li $v0, 4
    	la $a0, player_sum_msg
    	syscall
    	lb $a0, playerSum
    	li $v0, 1
    	syscall
    	li $v0, 4
    	la $a0, newline
    	syscall
    
    	# Print's computer's sum
    	li $v0, 4
    	la $a0, comp_sum_msg
    	syscall
    	lb $a0, computerSum
    	li $v0, 1
    	syscall	
    	li $v0, 4
    	la $a0, newline
    	syscall
    	
    	li $v0, 4
    	la $a0, newline
    	syscall

    
    	j endResults
    		
 endResults:
 
 	# Return back to main
    	lw   $ra, 0($sp)
    	addi $sp, $sp, 4
    	jr $ra

