.include "drawboard.asm"

.data
.globl test
.text

test: 

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
	
		# Character in row 1 of positionBoard
		lb $a0, positionBoard
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
	
		# Characters in row 2 of positionBoard
		lb $a0, positionBoard+1
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+2
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
		
		# Characters in row 3 of positionBoard
		lb $a0, positionBoard+3
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+4
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+5
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
		
		
		# Characters in row 4 of positionBoard
		lb $a0, positionBoard+6
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+7
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+8
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+9
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
		
		
		# Characters in row 5 of positionBoard
		lb $a0, positionBoard+10
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+11
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+12
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+13
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+14
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
		
		# Characters in row 6 of positionBoard
		lb $a0, positionBoard+15
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+16
		li $v0, 11
		syscall
	
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+17
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+18
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+19
		li $v0, 11
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
		lb $a0, positionBoard+20
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