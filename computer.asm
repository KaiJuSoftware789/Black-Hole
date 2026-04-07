# File to handle computer game choices

.data
comp_msg: .asciiz "Computer making move. \n"

.text
.globl computerTurn

computerTurn:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li $v0, 4
    la $a0, comp_msg
    syscall


    
pickRandom:

	# Generate random number between 1-21
	li $v0, 42
	li $a0, 0
	li $a1, 21
	syscall
	
	
	# Shifts number to 1 - 21 to exclude 0
	addi $a0, $a0, 1
	
	# Stores position
	sw $a0, position
	
	# Checks if position is valid and tries again if not
	la $t1, board
	
	# Shifts position to index
	addi $t0, $a0, -1
	
	# Adds index to board address to save number at chosen position
	add $t1, $t1, $t0
	
	# Loads character at the indexed board address
	lb $t2, 0($t1)
	
	# Loads character to check if free space 
	li $t3, '*'
	
	# Checks if space at board address is free. If not, picks random number again for position.
	bne $t2, $t3, pickRandom
	
	# Stores owner type into respective index from board into owner array
	la $t3, owner
    	add $t3, $t3, $t0
    	li $t4, 2          
    	sb $t4, 0($t3)     
	
	# Increment computer's number by 1 for next turn's highest number
	lb $t2, compHighestNumber
    	addi $t2, $t2, 1
    	sb $t2, compHighestNumber
    	
    	# Checks for 10 for special character
    	li $t3, 10
    	beq $t2, $t3, placeCompTen
    	
    	# convert integer to ASCII and store to board
    	addi $t2, $t2, 48 
	j storeCompNumber

placeCompTen:
	li $t2, '#'

storeCompNumber:

	# temp debug
    	# li $v0, 11
    	# move $a0, $t2
    	# syscall

	# Stores character into board address
	sb $t2, 0($t1)
	
	# Restores return address
	lw  $ra, 0($sp)
   	addi $sp, $sp, 4
    	jr $ra
	
	
	
	
